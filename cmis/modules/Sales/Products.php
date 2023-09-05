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
        if(isset($_FILES['product_photo'])){ 
            $dir = realpath(__DIR__.'/../../system/assets/uploads/products');
            $src = $_FILES['product_photo']['tmp_name'];
            $dst = "{$dir}/product_{$k}.jpg";
            $width = 450;
            $height = 450;
            helper::image_upload_resize($src, $dst, $width, $height);
            $l = $db->update('product', ['product_img' => "product_{$k}.jpg"])->where(['product_id'=>$k])->commit();
            header('Clear-Site-Data: "cache"');
        }
    }
    else {
        $k = $db->insert('product', $data);
        if(isset($_FILES['product_photo'])){
            $dir = realpath(__DIR__.'/../../system/assets/uploads/products/');
            $src = $_FILES['product_photo']['tmp_name'];
            $k = intval($k);
            $dst = "{$dir}/product_{$k}.jpg";
            $width = 450;
            $height = 450;
            helper::image_upload_resize($src, $dst, $width, $height);
            $l = $db->update('product', ['product_img' => "product_{$k}.jpg"])->where(['product_id'=>$k])->commit();
            header('Clear-Site-Data: "cache"');
        }
    }
   
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