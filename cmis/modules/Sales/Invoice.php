<?php 

$db = db::get_connection(storage::init()->system_config->database);
$ok = 'fail';
$msg = '';

$cps = realpath(__DIR__.'/../Settings');
$settings = json_decode(file_get_contents("{$cps}/module.json"));
$mod_conf = json_decode(file_get_contents(__DIR__.'/module.json'));

$request = $_SERVER['REQUEST_URI'];
if(isset($_POST['invoice_type'])){
    $total = 0;
    $items = [];

    $data = [
        'invoice_type'=>$_POST['invoice_type'], 
        'due_date'=>$due_date, 
        'invoice_amount'=>$total,
        'customer'=>$_POST['customer'],
        'sale_represantative'=>helper::init()->get_session_user('user_id'),
        'invoice_items'=>json_encode($items),
        'created_time'=>date('Y-m-d H:i:s')
        
    ];
    $k = 0;//$db->insert('invoice', $data);
    //var_dump($db->error());
   
    if(!$db->error() && $k) {
        $msg = 'Invoice created successful';
        $status = 'ok';
    }
    else $msg = 'Error adding invoice';
    //var_dump($db->error());
}
 $customer= $db->select('customer')
               ->fetchALL();


$invoice = $db->select('invoice','invoice.*,customer.customer_name')
              ->join('customer','invoice.customer_id=customer.customer_id')
              ->order_by('invoice_id', 'desc')->fetchAll();

$products = $db->select('product')->fetchAll();
//var_dump($products);
$data = [
    'invoice'=>$invoice,
    'customers'=>$customer,
    'products'=>$products,
    'msg'=>$msg, 
    'status'=>$ok,
    'request_uri'=>$request
];
echo helper::find_template('invoiceX', $data);