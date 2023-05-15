<?php 

$db = db::get_connection(storage::init()->system_config->database);
$msg = '';
$ok = false;

$request = $_SERVER['REQUEST_URI'];
//var_dump($_REQUEST);
if(isset($_POST['gross_salary'])){
    $data = [
        'employee_name'=>$_POST['employee_name'], 
        'gross_salary'=>$_POST['gross_salary'], 
        'payee'=>$_POST['payee'],
        'health_insurance_fund'=>$_POST['health_insurance_fund'],
        'social_security_fund'=>$_POST['social_security_fund'],
        'worker_compasion_fund'=>$_POST['social_security_fund'],
        'education_fund'=>$_POST['education_fund'],
        'payroll_bonus'=>$_POST['payroll_bonus'],
        'net_salary'=>$_POST['net_salary'],
        'create_date'=>date('Y-m-d H:i:s')
        
    ];
    $k = $db->insert('payroll', $data);
    //var_dump($db->error());
   
    if(!$db->error() && $k) {
        $msg = 'payroll added successful';
        $ok =true;
    }
    else $msg = 'Error adding payroll';
   //var_dump($db->error());
}
$payroll = $db->select('payroll','payroll.*,user.first_name')
            ->join('user','payroll.employee_name=user.user_id')
            ->order_by('payroll_id', 'desc')->fetchAll();

    //var_dump($db->error());
$employee = $db->select('user')
            ->where(1)
            ->fetchAll();

$data = ['payroll'=>$payroll,'msg'=>$msg, 'status'=>$ok,'request_uri'=>$request,'employee'=>$employee];
echo helper::find_template('Payroll', $data);