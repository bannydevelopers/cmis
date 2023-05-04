<?php 

$db = db::get_connection(storage::init()->system_config->database);
$my = helper::init()->get_session_user();
$ok = false;
$me = $db->select('staff')->where(['user_reference'=>$my['user_id']])->fetch();
$msg = '';

$request = $_SERVER['REQUEST_URI'];
if(isset($_POST['project_name'])){
    $data = [
        'project_name'=>$_POST['project_name'], 
        'project_starting_date'=>$_POST['project_starting_date'],
        'project_ending_date'=>$_POST['project_ending_date'],
        'project_burget'=>$_POST['project_burget'],
        'project_description'=>$_POST['project_description'],
        'staff_id'=>$me['staff_id'],
        'created_time'=>date('Y-m-d H:i:s')
    ];
    $k = $db->insert('project', $data);
    //var_dump($db->error());
   
    if(!$db->error() && $k) {
        $msg = 'project added successful';
        $ok =true;
    }
    else $msg = 'Error adding project';
    //var_dump($db->error());
}
 $staff= $db->select('staff','staff_id,staff_name')
                  ->fetchALL();

$project = $db->select('project')->order_by('project_id', 'desc')->fetchAll();
$data = ['project'=>$project,'msg'=>$msg, 'status'=>$ok,'request_uri'=>$request];
echo helper::find_template('projects', $data);