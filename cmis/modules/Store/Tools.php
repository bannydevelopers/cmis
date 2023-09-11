<?php 

$db = db::get_connection(storage::init()->system_config->database);
$ok = false;
$msg = '';

$request = $_SERVER['REQUEST_URI'];
if(isset($_POST['tool_name'])){
    $data = [
        'asset_number'=>$_POST['asset_number'], 
        'tool_name'=>$_POST['tool_name'], 
        'tool_description'=>$_POST['tool_description'], 
        'tool_group'=>$_POST['tool_group'], 
        'tool_status'=>'active', 
        'create_time'=>date('Y-m-d H:i:s')
    ];
    /*$data = [
        'tool_name'=>$_POST['tool_name'], 
        'tool_description'=>$_POST['tool_description'], 
        'tool_quantity'=>$_POST['tool_quantity'], 
        'create_time'=>date('Y-m-d H:i:s')
        //`tool_name`, `tool_description`, `tool_status`, `tool_date_purchased`, `create_time`
    ];*/
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
        //$l = $db->update('tools', ['tool_img' => "tool_{$k}.jpg"])->where(['tool_id'=>$k])->commit();
        header('Clear-Site-Data: "cache"');
    }
    
   
    if(!$db->error() && $k) {
        $msg = 'Tool added successful';
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
            'msg'=>'Tool deleted successful'
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
/*SELECT c.*,
FROM client AS c
LEFT JOIN client_calling_history AS cch ON cch.client_id = c.client_id
WHERE
   cch.cchid = (
      SELECT MAX(cchid)
      FROM client_calling_history
      WHERE client_id = c.client_id AND cal_event_id = c.cal_event_id
   )
   */
$whr = 'tools_out.tools_out_id = (SELECT MAX(tools_out_id) FROM tools_out WHERE 1)';
$tool = $db ->select('tools')
            ->join('tools_out', 'tools.tool_id=tools_out.tool_reference', 'LEFT')
            ->where($whr)
            ->or('tool_reference IS NULL')
            ->order_by('tool_id', 'desc')->fetchAll();


$tools_available = [];
$tools_borrowed = [];
$tools_requests = [];
//var_dump($tool);
$data = [
    'tool'=>$tool,
    'tools_available'=>$tools_available,
    'tools_borrowed'=>$tools_borrowed,
    'tools_requests'=>$tools_requests,
    'msg'=>$msg, 
    'status'=>$ok,
    'request_uri'=>$request
];
echo helper::find_template('tools', $data);