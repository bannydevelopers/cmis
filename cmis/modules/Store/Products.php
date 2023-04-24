<?php 
$db = db::get_connection(storage::init()->system_config->database);

//var_dump($_POST);
if(isset($_POST['product_name'])){
    $data = [
        'product_name'=>addslashes($_POST['product_name']),
        'product_description'=>addslashes($_POST['product_description']),
        'product_unit'=>addslashes($_POST['unit']),
        'product_quantity'=>addslashes($_POST['quantity']),
        'product_purchase_price'=>addslashes($_POST['purchase_price']),
        'product_selling_price'=>addslashes($_POST['selling_price']),
        'product_suppliers'=>addslashes($_POST['supplier']),
        'product_store'=>addslashes($_POST['store']),
    ];
   
$user = $db->select('user','user_id,user_name')->fetchALL();
$store = $db->select('store','store_id,store_name')->fetchALL();
$staff = $db->select('staff')
            ->join('user','user.user_id=staff.user_reference')
            ->join('user', 'user_id=user','LEFT')
            ->fetchAll();

$k = $db->insert('product', $data);
if(intval($k)) $msg = 'product added successful';
    else  $msg = 'product add failed';
}
$product = $db->select('product','product_id,name')->fetchALL();
        
    //var_dump('<pre>',$product);
    echo helper::find_template('products', ['product'=>$product, 'db'=>$db]);
        