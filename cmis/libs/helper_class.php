<?php
class helper{
    private static $instance = null;

    private function get_config(){
        return storage::init()->system_config;
    }
    public static function init(){
        if(self::$instance === null) self::$instance = new Static();
        return self::$instance;
    }
    public function save_user($user_data){
        $db = db::get_connection(storage::init()->system_config->db_configs);
        $ret = ['status'=>'unknown', 'details'=>'not set', 'user_id'=>0];
        $data = [];
        // Some fields are optional
        if(isset($user_data['first_name'])) $data['first_name'] = addcslashes($user_data['first_name']);
        if(isset($user_data['middle_name'])) $data['middle_name'] = addcslashes($user_data['middle_name']);
        if(isset($user_data['last_name'])) $data['last_name'] = addcslashes($user_data['last_name']);
        if(isset($user_data['system_role'])) $data['system_role'] = addcslashes($user_data['system_role']);
        if(isset($user_data['status'])) $data['status'] = addcslashes($user_data['status']);
        if(isset($user_data['phone_number'])) $data['phone_number'] = self::format_phone_number($user_data['phone_number']);
        if(isset($user_data['email'])) $data['email'] = self::format_email($user_data['email']);

        if(isset($user_data['user_id']) && $user_data['user_id']){
            $id = intval($user_data['user_id']);
            $result = $db->update('user', $data)->where(['user_id'=>$id])->commit();
        }
        else{
            if(!isset($data['first_name']) or (!isset($data['phone_number']) && !isset($data['email']))) return;
            $user_data['created_by'] = self::get_session_user('user_id');
            $user_data['created_time'] = date('Y-m-d H:i:s');
            $id = $db->insert('user', $data);
        }
        if($db->error()) $ret = ['status'=>'fail', 'details'=>$db->error(), 'user_id'=>$id];
        else $ret = ['status'=>'ok', 'details'=>'Save was a success!', 'user_id'=>$id];

        return (object)$ret;
    }
    public function get_session_user($index = null){
        $conf = storage::init()->system_config;
        $user = isset($_SESSION[$conf->session_name]) ? $_SESSION[$conf->session_name] : null;
        if($user){
            if($index == null) return $user;
            elseif(isset($user[$index])) return $user[$index];
        }
        return null;
    }
    public function get_user_permissions($role){
        $db = db::get_connection(storage::init()->system_config->database);
        $whr = "permission_id IN SELECT role_id FROM role_permission_list WHERE role_id = {$role}";
        $permission = $db->select('permision','permission_name')->where($whr)->fetchAll();
        if($permission) {
            $return = [];
            foreach($permission as $k=>$v){
                $return[] = $v;
            }
            return $return;
        }
        else return null;
    }
    public function user_can($reference){
        $permission = $this->get_user_permissions($this->get_session_user('system_role'));
        return in_array($reference, $permission) ? true : false;
    }
    public static function format_time($time, $format = 'Y-m-d H:i:s'){
        $timestamp = strtotime($time);
        return date($format, $timestamp);
    }
    public static function format_phone_number($number){
        if($number[0] == 0) $number = '255'.substr($number, 1);
        return $number;
    }
    public static function format_email($email){
        return filter_var($email, FILTER_SANITIZE_EMAIL);
    }
    public static function find_template($template_name, $data = []){
        $registry = storage::init();
        //$dirs = scandir(__DIR__);
        $dirs = storage::init()->system_config->modules;
        $nav = [
                    [
                        'name'=>'Dashboard', 
                        'href'=>str_replace('//','/', "/{$registry->request_dir}/{$registry->request[0]}/"),
                        'icon'=>'home'
                    ]
                ];
        foreach($dirs as $dir){
            $jfile = realpath(__DIR__.'/../')."/modules/{$dir}/module.json";
            //die($jfile);
            if(!is_readable($jfile)) continue;
            $info = json_decode(file_get_contents($jfile));
            if(!isset($info->nav) or !is_array($info->nav)){
                $info->nav = null;
            }
            $nav[] = [
                'href'=>str_replace('//','/', "/{$registry->request_dir}/{$registry->request[0]}/$dir"),
                'icon'=>$info->icon,
                'name'=>$info->name,
                'children'=>$info->nav
            ];
        }
    
        $storage = storage::init();
        extract($data);
        ob_start();
        $root = realpath(__DIR__.'/../system/templates/')."/{$storage->system_config->theme}";
        $base = trim("{$storage->request_dir}/cmis/system/assets/",'/');
        if(is_readable($root."/{$template_name}.html")) include $root."/{$template_name}.html";
        else echo '<h1>Template not found</h1>';
        $pdata = ob_get_clean();
        ob_start();
        $site_name = $storage->system_config->system_name;
        $page_title = "Dashboard &raquo; {$template_name}";
        include $root.'/index.html';
    }
}