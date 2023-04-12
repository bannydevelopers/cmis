<?php 
$children = ["Staff","Leave","Payroll","Salary","Contracts"];
$req = storage::init()->request;
if(!isset($req[2])){
    echo helper::find_template('hr', ['msg'=>'I\'m hr, dude!']);
}
else{
    if(in_array($req[2], $children)){
        // Work the thing
        include "{$req[2]}.php";
    }
}