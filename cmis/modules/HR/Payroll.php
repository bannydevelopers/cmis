<?php 

$db = db::get_connection(storage::init()->system_config->database);
$msg = '';
$ok = false;

$request = $_SERVER['REQUEST_URI'];
//var_dump($_REQUEST);
if(isset($_POST['p_slips'])){
    if($helper->user_can('can_add_payroll')){
        $slist = implode(',', array_values($_POST['p_slips']));
        $slips = $db->select('salary_slip', "salary_slip.*, CONCAT_WS(' ',first_name, middle_name, last_name) AS full_name")
                    ->join('user','salary_slip.employee=user.user_id')
                    ->where("slip_id IN ({$slist})")
                    ->order_by('slip_id', 'desc')->fetchAll();
        $data = [
            'payment_slips'=>json_encode($slips), 
            'payroll_name'=>"{$_POST['payroll_month']}, {$_POST['payroll_year']}", 
            'created_by'=>helper::init()->get_session_user('user_id'),
            'create_date'=>date('Y-m-d H:i:s')
            
        ];
        $k = $db->insert('payroll', $data);
        //var_dump($db->error());
    
        if(!$db->error() && $k) {
            $msg = 'Payroll added successful';
            $ok = true;
        }
        else $msg = 'Error adding payroll';
    }
    else{
        $msg = 'Permission denied!';
        $ok = false;
    }
   //var_dump($db->error());
}
if($helper->user_can('can_delete_payroll')){
    if(isset($_POST['ajax_delete_payroll'])){
        $db->delete('payroll')->where(['payroll_id'=>intval($_POST['ajax_delete_payroll'])])->commit();
        if(!$db->error()) die('ok');
        else die('fail');
    }
}
else{
    $msg = 'Permission denied!';
    $ok = false;
}
$payroll = $db->select('payroll')
              ->order_by('payroll_id', 'desc')->fetchAll();

    //var_dump($db->error());
$employee = $db->select('user')
               ->where(1)
               ->fetchAll();

$slips = $db->select('salary_slip')
            ->join('user','salary_slip.employee=user.user_id')
            ->order_by('slip_id', 'desc')->fetchAll();

$data = ['payroll'=>$payroll,'msg'=>$msg, 'status'=>$ok,'request_uri'=>$request,'employee'=>$employee,'slips'=>$slips];
echo helper::find_template('payroll', $data);