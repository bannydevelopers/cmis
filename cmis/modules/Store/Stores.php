<?php 

$db = db::get_connection(storage::init()->system_config->database);
$ok = false;
$msg = '';
$me = helper::init()->get_session_user();
$staff = $db->select('staff','work_location, branch_name, store_id, store_name')
            ->join('branches','branch_id=work_location')
            ->join('store','store.branch=branches.branch_id')
            ->where(['user_reference'=>helper::init()->get_session_user('user_id')])
            ->fetch();
$request = $_SERVER['REQUEST_URI'];
if(isset($_POST['store_name'])){
    $data = [
        'store_name'=>$_POST['store_name'], 
        'store_location'=>$_POST['store_location'], 
        'branch'=>$staff['work_location'],
        'staff_id'=>$me['user_id'],
        'created_time'=>date('Y-m-d H:i:s')
        
    ];
    //var_dump($db->error());
    $k = $db->insert('store', $data);
   
    if(!$db->error() && $k) {
        $msg = 'store added successful';
        $ok =true;
    }
    else $msg = 'Error adding store';
    //var_dump($db->error());
    if(isset($_POST['ajax']) && $_POST['ajax']) {
        die(
            json_encode([
                'id'=>$k,
                'name'=>$_POST['store_name'],
                'status'=>$ok
            ])
        );
    }
}
$staff= $db->select('staff','staff_id,staff_name')->fetchALL();


$store = $db->select('store')
            ->join('user','staff_id=user_id')
            ->order_by('store_id', 'desc')->fetchAll();
$data = ['store'=>$store,'msg'=>$msg, 'status'=>$ok,'request_uri'=>$request];
echo helper::find_template('stores', $data);