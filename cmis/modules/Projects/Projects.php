<?php 

$db = db::get_connection(storage::init()->system_config->database);
$my = helper::init()->get_session_user();
$ok = false;
$me = $db->select('staff')->where(['user_reference'=>$my['user_id']])->fetch();
$msg = '';

$request = $_SERVER['REQUEST_URI'];
$storage = storage::init();

$file = __DIR__.'/module.json';
$json = file_get_contents($file);
$mod_conf = json_decode($json, false);

if(isset($_POST['project_manager_role'])){
    $mod_conf->pm_manager = intval($_POST['project_manager_role']);
    file_put_contents($file, json_encode($mod_conf, JSON_PRETTY_PRINT));
}
if(isset($_POST['project_name'])){
    $data = [
        'project_name'=>$_POST['project_name'], 
        'project_starting_date'=>$_POST['project_starting_date'],
        'project_ending_date'=>$_POST['project_ending_date'],
        'project_burget'=>$_POST['project_burget'],
        'project_description'=>$_POST['project_description'],
        'project_manager'=>$_POST['project_manager'],
        'created_by'=>$my['user_id'],
        'created_time'=>date('Y-m-d H:i:s')
    ];
    
    $k = $db->insert('project', $data);
   
    if(!$db->error() && $k) {
        $msg = 'project added successful';
        $ok =true;
    }
    else $msg = 'Error adding project';
    //var_dump($db->error());
}
if(isset($storage->request[3]) && intval($storage->request[3])){
    $cols = "project.*,designation.designation_name, concat( first_name,' ',last_name) as pm_name";
    $project = $db->select('project', $cols)
                 ->join('user', 'project_manager=user_id')
                 ->join('staff','staff.user_reference=user.user_id')
                 ->join('designation', 'designation_id=staff.designation')
                 ->where(['project_id'=>$storage->request[3]])
                 ->order_by('project_id', 'desc')->fetch();
    var_dump($db->error());
    $activities = $db->select('activities')->where(['activity_id'=>$storage->request[3]])->fetchAll();
    $data = [
        'project'=>$project,
        'activity'=>$activities,
        'currency'=>$storage->system_config->system_currency
    ];
    die(helper::find_template('project_details', $data));
}

$staff = $db->select('user',"user_id,concat(first_name,' ', last_name) as pm_name")
            ->where(['system_role'=>$mod_conf->pm_manager])
            ->fetchALL();

$project = $db->select('project', "project.*, concat( first_name,' ',last_name) as pm_name")
              ->join('user', 'project_manager=user_id')
              ->join('staff', 'user_reference=user_id')
              ->order_by('project_id', 'desc')->fetchAll();
$roles = $db->select('role')->fetchAll();
$data = [
    'project'=>$project,
    'msg'=>$msg, 
    'status'=>$ok,
    'request_uri'=>$request,
    'user'=>$staff,
    'currency'=>$storage->system_config->system_currency,
    'roles'=>$roles
];
echo helper::find_template('projects', $data);