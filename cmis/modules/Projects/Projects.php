<?php 
$db = db::get_connection(storage::init()->system_config->database);

//var_dump($_POST);
if(isset($_POST['project_name'])){
    $data = [
        'project_name'=>addslashes($_POST['project_name']),
        'started_date'=>addslashes($_POST['started_date']),
        'end_date'=>addslashes($_POST['end_date']),
        'project_discription'=>addslashes($_POST['project_deiscription']),
        'project_burget'=>addslashes($_POST['project_burget']),
        'project_manager'=>addslashes($_POST['project_manager']),
        ];
   
$user = $db->select('user','user_id,user_name')->fetchALL();
$store = $db->select('store','store_id,store_name')->fetchALL();
$staff = $db->select('staff')
            ->join('user','user.user_id=staff.user_reference')
            ->join('user', 'user_id=user','LEFT')
            ->fetchAll();

$k = $db->insert('project', $data);
if(intval($k)) $msg = 'project added successful';
    else  $msg = 'project add failed';
}
$project = $db->select('project','project_id,name')->fetchALL();
        
    //var_dump('<pre>',$project);
    echo helper::find_template('projects', ['project'=>$project, 'db'=>$db]);
        