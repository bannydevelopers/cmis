<?php
class user{
    private static $instance = null;
    public static $user = null;

    private function get_config(){
        return storage::init()->system_config;
    }
    public static function init(){
        if(self::$instance === null) self::$instance = new Static();
        $conf = storage::init()->system_config;
        $user = isset($_SESSION[$conf->session_name]) ? $_SESSION[$conf->session_name] : null;
        if(self::$user === null && isset($user['user_id']) && $user['user_id']){
            self::$user = $user;
        }
        return self::$instance;
    }
    public function save_user($user_data){
        $db = db::get_connection(storage::init()->system_config->db_configs);
        $ret = ['status'=>'unknown', 'details'=>'not set', 'user_id'=>0];
        if(isset($user_data['full_name'])){
            // Basic fields
            $data = [
                'full_name'=>$user_data['full_name'], 
                'email'=>$user_data['email'], 
                'phone'=>$user_data['phone']
            ];
            // Some fields are optional
            if(isset($user_data['passcode'])) $data['passcode'] = system::create_hash($user_data['passcode']);
            if(isset($user_data['status'])) $data['status'] = $user_data['status'];
            if(isset($user_data['extras'])) $data['extras'] = stripslashes(json_encode($user_data['extras']));

            if(isset($user_data['user_id']) && $user_data['user_id']){
                $id = intval($user_data['user_id']);
                $result = $db->update('user_accounts', $data)->where(['user_id'=>$id])->commit();
            }
            else{
                $id = $db->insert('user_accounts', $data);
            }
            if($db->error()) $ret = ['status'=>'fail', 'details'=>$db->error(), 'user_id'=>$id];
            else $ret = ['status'=>'ok', 'details'=>'Save was a success!', 'user_id'=>$id];
        }
        return (object)$ret;
    }
    public function get_user($reference,$createria){

    }

    public function get_user_roles($user_id){

    }
    public function get_user_permissions($role){

    }

    public function get_user_permission($role){

    }
    
    public function can($reference){
        if(!$this->user) return false;
        $role = json_encode($this->user['user_roles']);
    }
}