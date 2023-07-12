<?php 

$db = db::get_connection(storage::init()->system_config->database);
$msg = '';
$ok = false;

$request = $_SERVER['REQUEST_URI'];
//var_dump($_REQUEST);
if(isset($_POST['basic_salary'])){
    $data = [
        'employee'=>$_POST['employee'], 
        'basic_salary'=>$_POST['basic_salary'], 
        'payee'=>$_POST['payee'], 
        'health_insurance_fund'=>$_POST['health_insurance_fund'], 
        'social_security_fund'=>$_POST['social_security_fund'], 
        'worker_compasion_fund'=>$_POST['worker_compasion_fund'], 
        'education_fund'=>$_POST['education_fund'], 
        'allowance'=>$_POST['allowance'], 
        'bonus'=>$_POST['bonus'], 
        'other_deduction'=>$_POST['other_deduction'],
        'create_date'=>date('Y-m-d H:i:s')
        
    ];
    $k = $db->insert('salary_slip', $data);
    //var_dump($db->error());
   
    if(!$db->error() && $k) {
        $msg = 'Salary slip added successful';
        $ok =true;
    }
    else $msg = 'Error adding salary slip';
   //var_dump($db->error());
}
$slips = $db->select('salary_slip')
            ->join('user','salary_slip.employee=user.user_id')
            ->order_by('slip_id', 'desc')->fetchAll();

$employee = $db->select('user')
            ->where(1)
            ->fetchAll();

$data = ['salary_slips'=>$slips,'msg'=>$msg, 'status'=>$ok,'request_uri'=>$request,'employees'=>$employee];
echo helper::find_template('salary_slip', $data);