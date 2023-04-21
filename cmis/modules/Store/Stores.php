<?php 
$db = db::get_connection(storage::init()->system_config->database);

    //var_dump($_REQUEST);
if(isset($_POST['store_name'])){
    $data = [
        'store_name'=>addslashes($_POST['store_name']),
        'store_location'=>addslashes($_POST['store_location'])
    ];
    $k = $db->insert('store', $data);
    if(intval($k)) $msg = 'store added successful';
    else  $msg = 'store add failed';
}
$store = $db->select('store','store_id,name')->fetchALL();

//var_dump('<pre>',$store);
echo helper::find_template('stores', ['store'=>$store, 'db'=>$db]);