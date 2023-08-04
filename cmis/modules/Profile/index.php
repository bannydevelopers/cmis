<?php 

$db = db::get_connection(storage::init()->system_config->database);
$user = $db->select('staff')
           ->join('user','user_id=user_reference')
           ->where(['user_id'=>helper::init()->get_session_user('user_id')])
           ->fetch();
$user = $db ->select('staff')
            ->join('user','user.user_id=staff.user_reference')
            //->join('user as creator', 'creator.user_id=user.created_by')
            ->join('designation', 'designation_id=designation','LEFT')
            ->join('department', 'department_id=staff_department','LEFT')
            ->join('role', 'role_id=system_role','LEFT')
            ->join('branches', 'branch_id=work_location','LEFT')
            ->join('bank', 'bank.bank_id=staff.bank_id','LEFT')
            ->where(['user_id'=>helper::init()->get_session_user('user_id')])
            ->order_by('user_id', 'desc')
            ->fetch();
echo helper::find_template('profile', ['user'=>$user]);