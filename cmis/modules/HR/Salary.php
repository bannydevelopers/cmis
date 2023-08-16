<?php 

$db = db::get_connection(storage::init()->system_config->database);
$msg = '';
$ok = 'fail';

$request = $_SERVER['REQUEST_URI'];
if(isset($_POST['add-slip'])){
    if($helper->user_can('can_add_salary_slip')){
        $addData = [
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
        $k = $db->insert('salary_slip', $addData);
    
        if(!$db->error() && $k) {
            $msg = 'Salary slip added successful';  $status = 'success';
            $ok =true;
        }
        else $msg = 'Error adding salary slip';  $status = 'fail';
    }
    else $msg = 'Sorry, permission denied!';
}

if(isset($_POST['update-slip'])){
    if($helper->user_can('can_edit_salary_slip')){
        $upData = [
            'slip_id'=>$_POST['slip_id'],
            //'employee'=>$_POST['employee'], 
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
        $k = $db->update('salary_slip', $upData)->where(['slip_id'=>$upData['slip_id']])->commit();
    
        if(!$db->error() && $k) {
            $msg = "Salary slip updated successful for {$_POST['full_name']}";
            $ok =true;
        }
        else $msg = 'Error updating salary slip'; 
             $status = 'fail';
    }
    else $msg = 'Sorry, permission denied!';
}
$data = ['msg'=>$msg, 'status'=>$ok,'request_uri'=>$request,'currency'=>storage::init()->system_config->system_currency];
$me = $db->select('staff')->where(['user_reference'=>helper::init()->get_session_user('user_id')])->fetch();
if(!isset($req[3]) && $helper->user_can('can_view_salary_slip')){
    $slips = $db->select('salary_slip')
                ->join('user','salary_slip.employee=user.user_id')
                ->order_by('slip_id', 'desc')->fetchAll();

    $employee = $db->select('user')
                ->where(1)
                ->fetchAll();

    $data['salary_slips']=$slips;
    $data['employees']=$employee;

    $template = 'salary_slip';
}
else{
    $payroll = $db->select('payroll')
              ->where("payment_slips like '%\"employee\": {$me['staff_id']},%'")
              ->order_by('payroll_id', 'desc')->fetchAll();

    //var_dump($db->error());
    foreach($payroll as $k=>$v){
        $v['payment_slips'] = json_decode($v['payment_slips'], true);
        foreach($v['payment_slips'] as $ps){
            if($ps['employee'] != $me['staff_id']) continue;
            $ps['gross'] = array_sum([$ps['bonus'], $ps['allowance'], $ps['basic_salary']]);
            $ps['deductions'] = array_sum([$ps['payee'], $ps['education_fund'], $ps['other_deduction'], $ps['social_security_fund'], $ps['health_insurance_fund'], $ps['worker_compasion_fund']]);
            $ps['net'] = $ps['gross'] - $ps['deductions'];
            $v['payment_slips'] = $ps;
        }
        $payroll[$k] = $v;
    }
    $data['payroll'] = $payroll;
    $template = 'my_salary_slips';
}
echo helper::find_template($template, $data);