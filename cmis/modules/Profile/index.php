<?php 

$db = db::get_connection(storage::init()->system_config->database);
$user = helper::init()->get_session_user();
echo helper::find_template('profile', ['user'=>$user]);