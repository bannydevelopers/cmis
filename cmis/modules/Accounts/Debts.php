<?php 

$db = db::get_connection(storage::init()->system_config->database);
$ok = false;
$msg = '';

$request = $_SERVER['REQUEST_URI'];
//var_dump($_SERVER['REQUEST_URI']);
if(isset($_POST['debt_amount'])){
    $data = [
        'date'=>$_POST['date'], 
        'debt_description'=>$_POST['debt_description'], 
        'debt_amount'=>$_POST['debt_amount'], 
        'party_type'=>$_POST['party_type'],
        'debty_type'=>$_POST['debty_type'],
        'party'=>$_POST['party'],
        'created_time'=>date('Y-m-d H:i:s')
        
    ];
   //var_dump($db->error());
    $k = $db->insert('debts', $data);
   
    if(!$db->error() && $k) {
        $msg = 'debt added successful';
        $ok =true;
    }
    else $msg = 'Error adding debt';
    //var_dump($db->error());
}
$debt = $db->select('debts')->order_by('debt_id', 'desc')->fetchAll();
//var_dump($db->error());
$data = ['debt'=>$debt,'msg'=>$msg, 'status'=>$ok,'request_uri'=>$request];
echo helper::find_template('debts', $data);
