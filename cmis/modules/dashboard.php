 <?php 
$registry = storage::init();

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
