<?php 

$db = db::get_connection(storage::init()->system_config->database);
$ok = false;
$msg = '';
if(isset($_POST['customer_name'])){
    $data = [
        'customer_name'=>$_POST['customer_name'], 
        'phone_number'=>$_POST['phone'], 
        'email'=>$_POST['email'], 
        'physical_adress'=>$_POST['address'], 
        'tin_number'=>$_POST['tin'], 
        'vrn_number'=>$_POST['vrn'], 
        'created_time'=>date('Y-m-d H:i:s')
    ];
    $k = $db->insert('customer', $data);
    if(!$db->error() && $k) {
        $msg = 'Customer added successful';
        $ok =true;
    }
    else $msg = 'Error adding customer';
}
if(isset($_POST['stock_batch'])){
    $data = [
        'stock_ref'=>0, 
        'product'=>intval($_POST['product']), 
        'store'=>intval($_POST['store']), 
        'stock_quantity'=>intval($_POST['product_quantity']), 
        'stock_batch'=>$_POST['stock_batch'], 
        'buying_price'=>intval($_POST['buying_price']),  
        'selling_price'=>intval($_POST['selling_price']), 
        'stock_expenses'=>intval($_POST['stock_expenses']), 
        'create_date'=>date('Y-m-d H:i:s'), 
        'stock_supplier'=>intval($_POST['supplier']), 
        'stock_receiver'=>helper::init()->get_session_user('user_id')
    ];
    $k = $db->insert('stock', $data);
    if(!$db->error() && $k) {
        $msg = 'Customer added successful';
        $ok ='ok';
    }
    else $msg = 'Error recording stock';
}
$data = ['msg'=>$msg, 'status'=>$ok];
$data['product'] = $db->select('product')->fetchAll();
$data['supplier'] = $db->select('supplier')->fetchAll();
$data['store'] = $db->select('store')->fetchAll();

//$fields = "*, (SELECT sum(stock_quantity) from stock WHERE stock_type='out' AND stock_batch='') as stock_out";
$data['stock'] = $db->select('stock', 'stock.*,product.*,store.*,supplier.*,user.*,sum(outgoing.stock_quantity) as stock_out')
                    ->join('product', 'product_id=stock.product')
                    ->join('stock as outgoing', 'outgoing.stock_ref=stock.stock_id', 'left')
                    ->join('store', 'store.store_id=stock.store')
                    ->join('supplier', 'supplier.supplier_id=stock.stock_supplier')
                    ->join('user', 'user.user_id=stock.stock_receiver')
                    ->where('stock.stock_ref < 1')
                    ->group_by('stock_id')
                    ->fetchAll();
//var_dump($db->error());
echo helper::find_template('Stock', $data);