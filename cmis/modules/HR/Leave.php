<?php 

$db = db::get_connection(storage::init()->system_config->database);
$my = helper::init()->get_session_user();
$me = $db->select('staff')->where(['user_reference'=>$my['user_id']])->fetch();
$mod_conf = json_decode(file_get_contents(__DIR__.'/module.json'));

$msg = '';
if(isset($_POST['cancel_leave'])){
    $db->update('leave_application',['leave_application_status'=>'Cancelled'])
       ->where(['leave_application_id'=>intval($_POST['cancel_leave'])])
       ->commit();
    if(!$db->error()) $k = 'ok';
    else $k = 'fail';
    die($k);
}
if(isset($_POST['delete_leave'])){
    $db->delete('leave_application')
       ->where(['leave_application_id'=>intval($_POST['delete_leave'])])
       ->commit();
    if(!$db->error()) $k = 'ok';
    else $k = 'fail';
    die($k);
}
if(isset($_POST['leave_flow'])){
    $ls = implode(',',array_values($_POST['leave_flow']));
    $mod_conf->modules->leave->approval_flow = $ls;
    file_put_contents(__DIR__.'/module.json', json_encode($mod_conf, JSON_PRETTY_PRINT));
    $mod_conf = json_decode(file_get_contents(__DIR__.'/module.json')); // refresh values...
    $msg = 'Leave approval flow updated';
    $db->update('leave_application',['leave_application_status'=>'Invalid'])
       ->where(['leave_application_status'=>'Pending'])
       ->or(['leave_application_status'=>'Progressing'])
       ->commit();
}
$approval_flow = explode(',', $mod_conf->modules->leave->approval_flow);
if(isset($_POST['leave_type'])){
    $data = [
        'staff_id'=>$me['staff_id'], 
        'leave_application_description'=>addslashes($_POST['leave_application_description']), 
        'leave_start_date'=>helper::format_time($_POST['leave_start'], 'Y-m-d H:i:s'), 
        'leave_application_type'=>addslashes($_POST['leave_type']), 
        'leave_length'=>intval($_POST['leave_length']), 
        'application_date'=>date('Y-m-d H:i:s'), 
        'responsibility_assignee'=>intval($_POST['responsibility_assignee'])
    ];
    if(!$data['responsibility_assignee']){
        $data['next_to_approve'] = $approval_flow[0];
        $data['remarks'] = json_encode(['<b>System&nbsp;</b>No responsibility assignee']);
        $data['response_date'] = json_encode([date('Y-m-d H:i:s')]);
        $data['leave_application_status'] = 'Progressing';
    }
    else{
        $data['next_to_approve'] = $_POST['responsibility_assignee'];
        $data['leave_application_status'] = 'Pending';
    }
    //if(!intval($data['responsibility_assignee'])) $data['assignee_response_date'] = date('Y-m-d H:i:s');
    $k = $db->insert('leave_application', $data);
    if(!$db->error() && $k) $msg = 'Leave application is a success';
    else $msg = 'Leave application failed';
    //var_dump($db->error());
}

if(isset($_POST['leave_remarks'])){
    $lv = $db->select('leave_application')
             ->where(['leave_application_id'=>intval($_POST['lid'])])
             ->fetch();
    if(!$db->error() && $lv){
        $data = [];
        if($lv['remarks'] == NULL) {
            $data['next_to_approve'] = $approval_flow[0];
            $_POST['response'] = 'Progressing';
        }
        else{
            $key = array_search($lv['next_to_approve'], $approval_flow);
            if(end($approval_flow) != $approval_flow[$key]) {
                if(isset($approval_flow[$key+1])){
                    // got a way to go...
                    $data['next_to_approve'] = $approval_flow[$key+1];
                    if($_POST['response'] == 'Approved') $_POST['response'] = 'Progressing';
                }
                else {
                    die('Config changed unexpectedly');
                }
            }
            else {
                $_POST['response'] = 'Approved';
                $data['approval_date'] = date('Y-m-d H:i:s');
                //var_dump($data);die('else2');
            }
            
        }
        $data['leave_application_status'] = $_POST['response'];
        $lv['remarks'] = $lv['remarks'] ? $lv['remarks'] :'[]';
        $remarks = json_decode($lv['remarks'], true);
        if(intval($lv['responsibility_assignee']) && count($remarks) < 1){
            $nxp = $db->select('user', 'first_name, middle_name, last_name')
                      ->where(['user_id'=>intval($lv['responsibility_assignee'])])
                      ->fetch();
            $name = "{$nxp['first_name']} {$nxp['middle_name']} {$nxp['last_name']}";
        }
        else{
            $nxp = $db->select('role','role_name as name')
                      ->where(['role_id'=>intval($lv['next_to_approve'])])
                      ->fetch();
            $name = $nxp['name'];
        }
        //var_dump($db->error(), $name);die;
        array_push($remarks, "<b>{$name}&nbsp;</b>{$_POST['leave_remarks']}");
        $data['remarks'] = json_encode($remarks);

        $lv['response_date'] = $lv['response_date'] ? $lv['response_date'] :'[]';
        $rdates = json_decode($lv['response_date'], true);
        array_push($rdates, date('Y-m-d H:i:s'));
        $data['response_date'] = json_encode($rdates);

        $k = $db->update('leave_application', $data)
                ->where(['leave_application_id'=>$lv['leave_application_id']])
                ->commit();
        if(!$db->error()) $msg = 'Leave status updated!';
    }
}
if(isset($req[3])){
    $leave = $db->select('leave_application', 'leave_application.*,user.first_name,user.last_name,user.middle_name')
                ->join('staff','staff.staff_id=leave_application.staff_id','left')
                ->join('user','user_id=user_reference','left')
                //->where(['staff_id'=>$me['staff_id']])
                ->where("leave_application.staff_id={$me['staff_id']}")
                ->order_by('leave_application_id', 'desc')
                ->fetchAll();
}
else{
    $whr = "leave_application.staff_id = {$me['staff_id']}";
    if(in_array($my['system_role'], explode(',', $mod_conf->modules->leave->approval_flow))){
        $whr = "staff_department IS NULL OR staff_department = '{$me['staff_department']}'";
    }

    $leave = $db->select('leave_application', 'leave_application.*,user.first_name,user.last_name,user.middle_name')
                ->join('staff','staff.staff_id=leave_application.staff_id','left')
                ->join('user','user_id=user_reference','left')
                ->where($whr)
                ->or(['responsibility_assignee'=>$my['user_id']])
                ->order_by('leave_application_id', 'desc')
                ->fetchAll();

}
//var_dump('<pre>',$db->error());
//var_dump('<pre>',$db->getQuery());
$assignee = $db->select('user')
               ->where("system_role='{$my['system_role']}' AND user_id != '{$my['user_id']}'")
               ->fetchAll();

 $roles = $db->select('role','role_id,role_name')
              ->order_by('role_name', 'asc')
              ->fetchAll();

$user = array_merge($me,$my);
echo helper::find_template(
    'leave', 
    [
        'assignee'=>$assignee,
        'leave'=>$leave,
        'msg'=>$msg,
        'roles'=>$roles,
        'approval_flow'=>$approval_flow,
        'me_user'=>$user
    ]
);