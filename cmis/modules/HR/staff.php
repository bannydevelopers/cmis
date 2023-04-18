<?php 
$db = db::get_connection(storage::init()->system_config->database);
$designation = $db->select('designation','designation_id,designation_id')->fetchALL();

$staff = $db->select('staff')->fetchAll();
echo helper::find_template('Staff', ['designation'=>$designation, 'staff'=>$staff]);