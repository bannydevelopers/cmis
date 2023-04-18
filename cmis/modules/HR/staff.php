<?php 
$db = db::get_connection(storage::init()->system_config->database);
$designation = $db->select('designation','designation_id,designation_name')->fetchALL();

$staff = $db->select('staff')
            ->join('user','user_id=user_reference')
            ->join('user as creator', 'creator.user_id=user.created_by','LEFT OUTER')
            ->join('designation', 'designation_id=designation','LEFT OUTER')
            ->join('bank', 'bank.bank_id=staff.bank_id','LEFT OUTER')
            ->fetchAll();
echo helper::find_template('Staff', ['designation'=>$designation, 'staff'=>$staff]);