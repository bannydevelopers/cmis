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

$users = $db->select('user',"user_id,concat(first_name,' ', last_name) as full_name")
            ->where("system_role IN ({$mod_conf->project_assignees})")
            ->fetchALL();

if(isset($storage->request[3]) && intval($storage->request[3])){
    $cols = "project.*,designation.designation_name,customer.*, concat(first_name,' ',last_name) as pm_name";
    
    if(isset($_POST['activity_name'])){
        $data = [ 
            'activity_name'=>$_POST['activity_name'], 
            'activity_duration'=>$_POST['activity_duration'], 
            'activity_description'=>$_POST['activity_description'], 
            'project_ref'=>$_POST['project_ref'], 
            'assignee_id'=>$_POST['project_assignee'], 
            'created_by'=>helper::init()->get_session_user('user_id'), 
            'activity_parent'=>$_POST['activity_parent'], 
        ];
        $k = $db->insert('activities', $data);
        if(intval($k)) $msg = 'Activity created successful';
        else $msg = 'Activity creation fail';
    }
    if(isset($_POST['activity_resource_type'])){
        var_dump($_POST);
        $data = [
        'resource_type'=>addslashes($_POST['activity_resource_type']), 
        'resource_requester'=>helper::init()->get_session_user('user_id'), 
        'resource_activity'=>addslashes($_POST['activity_ref']), 
        'resource_status'=>'requested', 
        'resource_quantity'=>0,
        'request_date'=>date('Y-m-d H:i:s')
        ];
        if($_POST['activity_resource_type'] == 'deliverables' or $_POST['activity_resource_type'] == 'tools'){
            $data['resource_reference'] = json_encode($_POST['resource_name']);
            $data['resource_quantity'] = json_encode($_POST['resource_quantity']);
        }
        else{
            $data['resource_reference'] = implode(',',$_POST['resources']);
        }
        $k = $db->insert('project_resources', $data);
    }
    $project = $db->select('project', $cols)
                 ->join('user', 'project_manager=user_id')
                 ->join('staff','staff.user_reference=user.user_id')
                 ->join('customer','project.project_client=customer.customer_id')
                 ->join('designation', 'designation_id=staff.designation')
                 ->where(['project_id'=>$storage->request[3]])
                 ->order_by('project_id', 'desc')->fetch();

    $activities = $db->select('activities', "activities.*, concat(first_name,' ', last_name) as assignee")
                     ->join('user', 'assignee_id=user_id')
                     ->where(['project_ref'=>$storage->request[3]])
                     ->order_by('activity_id','ASC')
                     ->fetchAll();
    $activities_tree = [];
    // Arrange in tree hierarchy
    foreach($activities as $child){
        if($child['activity_parent'] == 0) {
            $child['tasks'] = [];
            $activities_tree[$child['activity_id']] = $child;
        }
        else{
            $activities_tree[$child['activity_parent']]['tasks'][] = $child;
        }

    }
    rsort($activities_tree);
    
    $data = [
        'project'=>$project,
        'activity'=>$activities_tree,
        'users'=>$users,
        'currency'=>$storage->system_config->system_currency
    ];
    die(helper::find_template('project_details', $data));
}

$staff = $db->select('user',"user_id,concat(first_name,' ', last_name) as pm_name")
            ->where(['system_role'=>$mod_conf->pm_manager])
            ->fetchALL();

$clients = $db->select('customer','customer_id, customer_name, customer_email')->fetchAll();

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
    'clients'=>$clients,
    'currency'=>$storage->system_config->system_currency,
    'roles'=>$roles
];
echo helper::find_template('projects', $data);