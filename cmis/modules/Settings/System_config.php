<?php 
$conf = storage::init()->system_config;
$data = [
    'configs'=>$conf
];  
if(isset($_POST['system_name'])){
    foreach($_POST as $key=>$value){
        if(isset($conf->$key)){
            if(is_object($value)){
                foreach($value as $k=>$v) $conf->$key->$k = $v;
            }
            else $conf->$key = $value;
        }
    }
    $json = json_encode($conf, JSON_PRETTY_PRINT);
    $fn = realpath(__DIR__.'/../../config/conf.json');
    file_put_contents($fn, $json);
    header("Location: ./");
}

if(isset($_POST['update-repo'])){
    $repoDir = './';
    $branch = 'main';  // or 'master', depending on your setup

    // Navigate to the repo directory
    chdir($repoDir);

    // Fetch the latest changes from the remote repository
    //$output = shell_exec('git fetch --all');
    $output = shell_exec('git pull');

    // Reset to the latest commit on the specified branch
    //$output .= shell_exec('git reset --hard origin/' . $branch);

    $data['msg'] = nl2br($output);
}

echo helper::find_template('system_config', $data);