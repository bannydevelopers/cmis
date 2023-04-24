<?php 

$db = db::get_connection(storage::init()->system_config->database);
$my = helper::init()->get_session_user();
$me = $db->select('staff')->where(['staff_id'=>$my['user_id']])->fetch();

if(isset($_POST['leave_type'])){
    //'leave_application''staff_id', 'leave_description', 'approval', 'remark', 
    //'leave_start_date', 'leave_end_date', 'response_date', 'application_date', 
    //'responsibility_asignee', 'asignee_response_date'
    $data = [
        'staff_id'=>$me['user_id'], 
        'leave_description'=>addslashes($_POST['leave_description']), 
        'leave_start_date'=>helper::format_time($_POST['leave_start'], 'Y-m-d H:i:s'), 
        'leave_length'=>intval($_POST['leave_length']), 
        'application_date'=>date('Y-m-d H:i:s'), 
        'responsibility_asignee'=>intval($_POST['responsility_assignee'])
    ];
    $k = $db->insert('leave_application', $data);
    if($k) echo 'Ta da';
    else var_dump($db->error());
    //'asignee_response_date'
}
$leave = $db->select('leave_application')->fetchAll();
$assignee = $db->select('user')
               ->where("system_role='{$my['system_role']}' AND user_id != '{$my['user_id']}'")
               ->fetchAll();
echo helper::find_template('leave', ['assignee'=>$assignee,'leave'=>$leave]);