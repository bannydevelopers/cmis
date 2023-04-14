<?php 
$children = ['Expenses','Debts'];
$req = storage::init()->request;
if(!isset($req[2])){
    echo helper::find_template('accounts', []);
}
else{
    if(in_array($req[2], $children)){
        // Work the thing
        include "{$req[2]}.php";
    }
}