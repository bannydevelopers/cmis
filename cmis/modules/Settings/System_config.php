<?php 
$conf = storage::init()->system_config;
$data = [
    'configs'=>$conf
];
echo helper::find_template('System_config', $data);