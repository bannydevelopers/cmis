<?php 
$db = db::get_connection(storage::init()->system_config->database);
$msg = '';
$request = $_SERVER['REQUEST_URI'];
if(isset($_POST['ajax_del_staff'])){
    $staff_id = intval($_POST['ajax_del_staff']);
    $staff = $db->select('staff', 'user.user_id,user.first_name,user.middle_name,user.last_name')
                ->join('user', 'user_id=user_reference')
                ->where(['staff_id'=>$staff_id])
                ->fetch();
    if($staff){
        $k = $db->delete('staff')->where(['staff_id'=>$staff_id])->commit();
        if(!$db->error() && $k) {
            $k = $db->delete('user')->where(['user_id'=>$staff['user_id']])->commit();
            $msg = 'Staff deleted succesfully';
        }
        else $msg = 'Delete failed';
        die(json_encode(['status'=>'success','msg'=>$msg,'staff'=>$staff]));
    }
}
if(isset($_POST['designation_name']) && isset($_POST['designation_details'])){
    if($helper->user_can('can_add_designation')){
        $data = [
            'designation_name'=>addslashes($_POST['designation_name']),
            'designation_detail'=>addslashes($_POST['designation_details'])
        ];
        $k = $db->insert('designation', $data);
        if(intval($k)) $msg = 'Designation added successful';
        else  $msg = 'Designation add failed';
        //$k = $db->insert('role', ['name'=>str_replace(' ', '_', $data['designation_name'])]);
    }
    else $msg = 'You do not have permission for the action';
}
if(isset($_POST['first_name'])){
    if($helper->user_can('can_add_staff')){
        $role = $db->select('designation_role','role_id')
                ->where(['designation_id'=>intval($_POST['designation'])])
                ->fetch();
        
        $user = [
            'first_name'=>addslashes($_POST['first_name']), 
            'middle_name'=>addslashes($_POST['middle_name']), 
            'last_name'=>addslashes($_POST['last_name']), 
            'system_role'=>$role['role_id'], 
            'status'=>'activate', 
            'phone_number'=>helper::format_phone_number($_POST['phone_number']), 
            'email'=>helper::format_email($_POST['email']), 
            'password'=>helper::create_hash(time()), 
            'activation_token'=>null, 
            'created_by'=>helper::init()->get_session_user('user_id'), 
            'created_time'=>date('Y-m-d H:i:s')
        ];
        $user_id = $db->insert('user',$user);
        //var_dump('<pre>',$db->error());
        $staff = [
            'registration_number'=>addslashes($_POST['registration_number']), 
            'residence_address'=>addslashes($_POST['residence_address']), 
            'designation'=>addslashes($_POST['designation']), 
            'user_reference'=>$user_id, 
            'date_employed'=>helper::format_time($_POST['date'], 'Y-m-d H:i:s'), 
            'employment_length'=>2,//addslashes($_POST['employment_length']), 
            'employment_status'=>'active'
        ];
        $k = $db->insert('staff',$staff);
        if(!$k) $db->delete('user')->where(['user_id',$user_id])->commit(); // revert changes, staff issues
        else {
            $msg = 'Staff created'; 
        }
    }
}
$designation = $db->select('designation','designation_id,designation_name')->fetchALL();

$staff = $db->select('staff')
            ->join('user','user.user_id=staff.user_reference')
            //->join('user as creator', 'creator.user_id=user.created_by')
            ->join('designation', 'designation_id=designation','LEFT')
            ->join('bank', 'bank.bank_id=staff.bank_id','LEFT')
            ->where("user.status != 'deleted'")
            ->order_by('user_id', 'desc')
            ->fetchAll();
//var_dump('<pre>',$staff);
if($helper->user_can('can_view_staff')){
    $data = ['designation'=>$designation, 'staff'=>$staff,'msg'=>$msg, 'request_uri'=>$request];
    echo helper::find_template('Staff', $data);
}
else echo helper::find_template('permission_denied');