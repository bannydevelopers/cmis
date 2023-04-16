<?php 
$children = ['Expenses','Debts',"Revenues","Business_partners","Banks"];
$req = storage::init()->request;
if(!isset($req[2])){
    echo helper::find_template('Accounts', []);
}
else{
    if(in_array($req[2], $children)){
        // Work the thing
        include "{$req[2]}.php";
    }
}