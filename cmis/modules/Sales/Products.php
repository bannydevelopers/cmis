<?php 

$db = db::get_connection(storage::init()->system_config->database);
$ok = false;
$msg = '';

$request = $_SERVER['REQUEST_URI'];
if(isset($_POST['product_name'])){
    $data = [
        'product_name'=>$_POST['product_name'], 
        'product_description'=>$_POST['product_description'], 
        'product_unit'=>$_POST['product_unit'], 
        'created_time'=>date('Y-m-d H:i:s')
        
    ];
    //var_dump($db->error());
    if(isset($_POST['product_id']) && intval($_POST['product_id']) > 0){
        $k = $db->update('product', $data)->where(['product_id'=>$_POST['product_id']])->commit();
        $k = intval($_POST['product_id']);
    }
    else $k = $db->insert('product', $data);
   
    if(!$db->error() && $k) {
        $msg = 'Product saved successful';
        $ok =true;
    }
    else $msg = 'Error adding product';
    //var_dump($db->error());
    if(isset($_POST['ajax']) && $_POST['ajax']) {
        die(
            json_encode([
                'id'=>$k,
                'name'=>$_POST['product_name'],
                'status'=>$ok
            ])
        );
    }
}
$product = $db->select('product')->order_by('product_id', 'desc')->fetchAll();
$data = ['product'=>$product,'msg'=>$msg, 'status'=>$ok,'request_uri'=>$request];
echo helper::find_template('products', $data);