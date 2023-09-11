<?php 

$db = db::get_connection(storage::init()->system_config->database);
$ok = false;
$msg = '';

$request = $_SERVER['REQUEST_URI'];
if(isset($_POST['tool_name'])){
    $data = [
        'tool_name'=>$_POST['tool_name'], 
        'tool_description'=>$_POST['tool_description'], 
        'tool_quantity'=>$_POST['tool_quantity'], 
        'create_time'=>date('Y-m-d H:i:s')
        //`tool_name`, `tool_description`, `tool_status`, `tool_date_purchased`, `create_time`
    ];
    if(isset($_POST['tool_id']) && intval($_POST['tool_id']) > 0){
        $k = $db->update('tools', $data)->where(['tool_id'=>$_POST['tool_id']])->commit();
        $k = intval($_POST['tool_id']);
    }
    else {
        $k = $db->insert('tools', $data);
    }
    if(isset($_FILES['tool_photo']) && is_readable($_FILES['tool_photo']['tmp_name'])){ 
        $dir = realpath(__DIR__.'/../../system/assets/uploads/tools/');
        $src = $_FILES['tool_photo']['tmp_name'];
        $dst = "{$dir}/tool_{$k}.jpg";
        $width = 450;
        $height = 450;
        $dst = helper::image_upload_resize($src, $dst, $width, $height);
        $l = $db->update('tools', ['tool_img' => "tool_{$k}.jpg"])->where(['tool_id'=>$k])->commit();
        header('Clear-Site-Data: "cache"');
    }
    
   
    if(!$db->error() && $k) {
        $msg = 'tool added successful';
        $ok =true;
    }
    else $msg = 'Error adding tool';
   //var_dump($db->error());
}
if(isset($_POST['ajax_del_tool'])){
    $db->delete('tools')->where(['tool_id'=>$_POST['ajax_del_tool']])->commit();
    if(!$db->error()){
        $json = json_encode([
            'status'=>'success',
            'msg'=>'tool deleted successful'
        ]);
    }
    else{
        $json = json_encode([
            'status'=>'fail',
            'msg'=>'Unexpected error occured while deleting tool'
        ]);
    }
    die($json);
}
$tool = $db->select('tools')->order_by('tool_id', 'desc')->fetchAll();
$tools_available = [];
$tools_borrowed = [];
//var_dump($tool);
$data = [
    'tool'=>$tool,
    'tools_available'=>$tools_available,
    'tools_borrowed'=>$tools_borrowed,
    'msg'=>$msg, 
    'status'=>$ok,
    'request_uri'=>$request
];
echo helper::find_template('tools', $data);