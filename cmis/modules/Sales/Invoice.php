<?php 

$db = db::get_connection(storage::init()->system_config->database);
$ok = 'fail';
$msg = '';

$cps = realpath(__DIR__.'/../Settings');
$mod_config = json_decode(file_get_contents("{$cps}/module.json"));

$request = $_SERVER['REQUEST_URI'];
if(isset($_POST['invoice_date'])){
    $data = [
        'invoice_date'=>$_POST['invoice_date'], 
        'invoice_type'=>$_POST['invoice_type'], 
        'ref_number'=>$_POST['ref_number'],
        'invoice_amount'=>$_POST['invoice_amount'],
        'invoice_expire_date'=>$_POST['invoice_expire_date'],
        'customer_id'=>$_POST['customer_id'],
        'invoice_items'=>json_encode($_POST['invoice_items']),
        'created_time'=>date('Y-m-d H:i:s')
        
    ];
    $k = $db->insert('invoice', $data);
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

$data = [
    'invoice'=>$invoice,
    'customers'=>$customer,
    'products'=>$products,
    'msg'=>$msg, 
    'status'=>$ok,
    'request_uri'=>$request
];
echo helper::find_template('invoiceX', $data);