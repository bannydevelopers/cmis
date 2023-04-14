 <?php 
$registry = storage::init();
$helper = helper::init();
if(isset($_POST['login']) && isset($_POST['password'])){
    $helper->login_user($_POST);
}
if(isset($_GET['logout'])){
    // Unset session
    $helper->end_user_session();
    // Remove query string
    $url = strtok($_SERVER["REQUEST_URI"], '?');
    header("Location: {$url}");
}
if(!$helper->check_user_session()){
    die($helper::get_sub_template('login'));
}
if(isset($registry->request[1])){
    if(is_readable(__DIR__."/{$registry->request[1]}/index.php")){
        include __DIR__."/{$registry->request[1]}/index.php";
    }
    else
    {
        $storage = storage::init();
        $root = realpath(__DIR__.'/../system/templates/')."";
        $base = trim("{$storage->request_dir}/cmis/system/assets/",'/');
        if(is_readable("{$root}/{$storage->system_config->theme}/404.html"))
        {
            include "{$root}/{$storage->system_config->theme}/404.html";
        }
        else{
            include "{$root}/default/404.html";
        }
    }
}
else include __DIR__.'/default/index.php';
