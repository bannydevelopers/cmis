<?php 
$children = ["Staff","Leave","Payroll","Salary","Contracts"];
$req = storage::init()->request;
if(!isset($req[2])){
    $data = []; // coming...
    echo helper::find_template('hr', ['data'=>$data]);
}
else{
    if(in_array($req[2], $children)){
        // Work the thing
        include "{$req[2]}.php";
    }
}