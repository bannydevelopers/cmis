 <?php 

function find_template($template_name, $data = []){
    $registry = storage::init();
    //$dirs = scandir(__DIR__);
    $dirs = storage::init()->system_config->modules;
    $nav = [
                [
                    'name'=>'Dashboard', 
                    'href'=>str_replace('//','/', "/{$registry->request_dir}/{$registry->request[0]}/"),
                    'icon'=>'home'
                ]
            ];
    foreach($dirs as $dir){
        $jfile = __DIR__."/{$dir}/module.json";
        if(!is_readable($jfile)) continue;
        $info = json_decode(file_get_contents($jfile));
        if(!isset($info->nav) or !is_array($info->nav)){
            $info->nav = null;
        }
        $nav[] = [
            'href'=>str_replace('//','/', "/{$registry->request_dir}/{$registry->request[0]}/$dir"),
            'icon'=>$info->icon,
            'name'=>$info->name,
            'children'=>$info->nav
        ];
    }

    $storage = storage::init();
    extract($data);
    ob_start();
    $root = realpath(__DIR__.'/../system/templates/')."/{$storage->system_config->theme}";
    $base = trim("{$storage->request_dir}/cmis/system/assets/",'/');
    if(is_readable($root."/{$template_name}.html")) include $root."/{$template_name}.html";
    else echo '<h1>Template not found</h1>';
    $pdata = ob_get_clean();
    ob_start();
    $site_name = $storage->system_config->system_name;
    $page_title = "Dashboard &raquo; {$template_name}";
    include $root.'/index.html';
}
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
