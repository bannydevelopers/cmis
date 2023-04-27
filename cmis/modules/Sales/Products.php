<?php 
$db = db::get_connection(storage::init()->system_config->database);
$ok = false;
$msg = '';

$data['products'] = $db->select('product')
           ->order_by('product_id', 'desc')
           ->fetchAll();

echo helper::find_template('Products', $data);