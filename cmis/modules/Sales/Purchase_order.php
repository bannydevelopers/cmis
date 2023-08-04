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
    $prods = $db->select('product', 'product_id, product_name, stock.selling_price as product_price')
                ->join('stock','stock.product=product.product_id')
                ->where("product_id IN ({$ilist})")->fetchAll();
    
    $total = 0;
    $items = [];
    $qty = [];
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
        $qty[$id] = $_POST['item_quantity'][$k];
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
    $save_invoice = true;
    if(strtolower($data['invoice_type']) == 'tax'){

        $prods = $db->select('stock', 'product.product_id, stock.*, sum(outgoing.stock_quantity) as stock_out')
                    ->join('product', 'product_id=stock.product')
                    ->join('stock as outgoing', 'outgoing.stock_ref=stock.stock_id', 'left')
                    ->where("stock.stock_ref < 1 AND product_id IN ({$ilist})")
                    ->group_by('stock.stock_id')
                    ->fetchAll();
        
        // Just a check to be sure whether a genius called hacker got a way there...
        $scount = 0;
        $keyz = [];
        foreach($prods as $prod){
            if((intval($prod['stock_out']) + $qty[intval($prod['product_id'])]) < intval($prod['stock_quantity'])){
                //update stock
                $prod['stock_ref'] = $prod['stock_id'];
                $prod['stock_supplier'] = helper::init()->get_session_user('user_id');
                $prod['stock_receiver'] = $data['customer'];
                $prod['stock_quantity'] = $qty[intval($prod['product_id'])];
                unset($prod['stock_id']);
                unset($prod['product_id']);
                unset($prod['stock_out']);
                $k = $db->insert('stock', $prod);
                $keyz[] = $k;
                ++$scount;
                //var_dump($db->error());
            }
        }
        //var_dump($keyz);die;
        if($scount !== count($prods)){
            // Roll back! Whether stock ran out between the time or somehow a genius tampered with the system
            $keyzz = implode(',', $keyz);
            $db->delete('stock')->where("product IN ({$keyzz})")->commit();
            $msg = 'Stock is not enough for the order';
            $save_invoice = false;
        }
    }
    if($save_invoice) $k = $db->insert('invoice', $data);
    else $k = false;
   
    if(!$db->error() && $k) {
        $msg = 'Invoice created successful';
        $ok = 'ok';
    }
    else {
       if(empty($msg)) $msg = 'Error adding invoice';
    }
    //var_dump($db->error());
}
$data = ['msg'=>$msg, 'status'=>$ok, 'company'=>$settings->config->company_profile];
$data['supplier'] = $db->select('supplier')->fetchALL();


$data['orders'] = $db->select('invoice')
                     ->join('customer','invoice.customer=customer.customer_id')
                     ->join('user','invoice.sale_represantative=user.user_id')
                     ->order_by('invoice_id', 'desc')->fetchAll();

$data['products'] = $db ->select('stock', 'product.*, stock.stock_quantity, stock.selling_price as product_price,sum(outgoing.stock_quantity) as stock_out')
                        ->join('product', 'product_id=stock.product')
                        ->join('stock as outgoing', 'outgoing.stock_ref=stock.stock_id', 'left')
                        ->where("stock.stock_ref < 1")
                        ->group_by('stock.stock_id')
                        ->fetchAll();

echo helper::find_template('purchase_order', $data);