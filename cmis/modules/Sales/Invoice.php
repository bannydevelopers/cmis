<?php 

$db = db::get_connection(storage::init()->system_config->database);
$ok = false;
$msg = '';

$request = $_SERVER['REQUEST_URI'];
if(isset($_POST['invoice_name'])){
    $data = [
        'invoice_name'=>$_POST['invoice_name'], 
        'invoice_type'=>$_POST['invoice_type'], 
        'ref_number'=>$_POST['ref_number'],
        'invoice_amount'=>$_POST['invoice_amount'],
        'invoice_expire_date'=>$_POST['invoice_expire_date'],
        'created_time'=>date('Y-m-d H:i:s')
        
    ];
    //var_dump($db->error());
    $k = $db->insert('invoice', $data);
   
    if(!$db->error() && $k) {
        $msg = 'invoice added successful';
        $ok =true;
    }
    else $msg = 'Error adding invoice';
    //var_dump($db->error());
}
$invoice = $db->select('invoice')->order_by('invoice_id', 'desc')->fetchAll();
$data = ['invoice'=>$invoice,'msg'=>$msg, 'status'=>$ok,'request_uri'=>$request];
echo helper::find_template('invoices', $data);