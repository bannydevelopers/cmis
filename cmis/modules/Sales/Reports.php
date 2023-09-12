<?php 

$db = db::get_connection(storage::init()->system_config->database);

$request = $_SERVER['REQUEST_URI'];
$data = ['msg'=>'', 'status'=>false,'request_uri'=>$request];

$supported = ['customers', 'sales', 'products'];
if(isset(storage::init()->request[3])){
    $req = storage::init()->request[3];

    $template = '404';
    if(in_array(storage::init()->request[3], $supported)){
        $template = "{$req}_report";
        if($req == 'customers'){
            $customers = $db->select('invoice', 'customer.*, COUNT(invoice_id) as frequence')
                        ->join('customer', 'customer.customer_id=invoice.customer')
                        ->where(['invoice_type'=>'tax'])
                        ->group_by('customer_id')
                        ->order_by('frequence', 'DESC')
                        //->limit(30)
                        ->fetchAll();

            $data['customers'] = $customers;
        }
    } 
}
else{
    $customers = $db->select('invoice', 'customer.customer_name, COUNT(invoice_id) as frequence')
                ->join('customer', 'customer.customer_id=invoice.customer')
                ->where(['invoice_type'=>'tax'])
                ->group_by('customer_id')
                ->order_by('frequence', 'DESC')
                ->limit(10)
                ->fetchAll();
    $data['customers'] = $customers;
    $template = 'reports';
}
echo helper::find_template($template, $data);