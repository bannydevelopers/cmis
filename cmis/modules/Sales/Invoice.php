<?php 

$db = db::get_connection(storage::init()->system_config->database);
$ok = 'fail';
$msg = '';

$cps = realpath(__DIR__.'/../Settings');
$settings = json_decode(file_get_contents("{$cps}/module.json"));
$mod_conf = json_decode(file_get_contents(__DIR__.'/module.json'));

$request = $_SERVER['REQUEST_URI'];
if(isset($_POST['invoice_type'])){
    $ilist = trim(implode(',', array_values($_POST['item_name'])),',');
    $prods = $db->select('product','product_id,product_name,product_price')->where("product_id IN ({$ilist})")->fetchAll();
    //var_dump('<pre>',$prods);die;
    $total = 0;
    $items = [];
    foreach($_POST['item_name'] as $k=>$id){
        if(empty($id) or empty($_POST['item_quantity'][$k])) continue;
        $key = array_search($id, array_column($prods, 'product_id'));
        $total += intval($_POST['item_quantity'][$k]) * $prods[$key]['product_price'];
        $items[] = [
            'id'=>$id, 
            'name'=>$prods[$key]['product_name'],
            'qty'=>$_POST['item_quantity'][$k], 
            'price'=>$prods[$key]['product_price']
        ];
    }
    $due_date = date('y-m-d H:i:s', (time() + (60*60*24*14)));
    $data = [
        'invoice_type'=>$_POST['invoice_type'], 
        'due_date'=>$due_date, 
        'invoice_amount'=>$total,
        'customer'=>$_POST['customer'],
        'sale_represantative'=>helper::init()->get_session_user('user_id'),
        'invoice_items'=>json_encode($items),
        'created_time'=>date('Y-m-d H:i:s')
        
    ];
    //var_dump('<pre>',$data);die;
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


$invoice = $db->select('invoice','invoice.*,customer.*, user.first_name, user.middle_name, user.last_name')
              ->join('customer','invoice.customer=customer.customer_id')
              ->join('user','invoice.sale_represantative=user.user_id')
              ->order_by('invoice_id', 'desc')->fetchAll();

$products = $db->select('product')->fetchAll();
//var_dump($products);
$data = [
    'invoice'=>$invoice,
    'customers'=>$customer,
    'products'=>$products,
    'company'=>$settings->config->company_profile,
    'msg'=>$msg, 
    'status'=>$ok,
    'request_uri'=>$request
];
echo helper::find_template('invoiceX', $data);