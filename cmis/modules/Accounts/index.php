<?php 
$db = db::get_connection(storage::init()->system_config->database);
$data = $db->select('staff')->join('user','staff.user_reference=user.user_id')->fetchAll();

echo find_template('customer', ['users'=>$data,'msg'=>'I\'m hr, dude!']);