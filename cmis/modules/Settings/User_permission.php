<?php 
$db = db::get_connection(storage::init()->system_config->database);
$roles = $db->select('role_permission_list')
            ->join('permission','permission.permission_id=role_permission_list.permission_id')
            ->join('role','role.role_id=role_permission_list.role_id')
            ->order_by('legend')->fetchAll();

$role_tree = [];
foreach($roles as $role){
    if(!isset($role_tree[$role['name']])) {
        $role_tree[$role['name']] = [];
    }
    if(!isset($role_tree[$role['name']][$role['legend']])) {
        $role_tree[$role['name']][$role['legend']] = [];
    }
    $role_tree[$role['name']][$role['legend']][] = [
        'role_id'=>$role['role_id'],
        'permission_id'=>$role['permission_id'],
        'permission_name'=>$role['permission_name']
    ];
}
$designations = $db->select('designation','designation_id,designation_name')->fetchAll();
if(isset($_POST['get_permission'])){
    $permission = $db->select('permission')
                    ->fetchAll();
    $perm_tree = [];
    foreach($permission as $perm){
        if(!isset($perm_tree[$perm['legend']])) {
            $perm_tree[$perm['legend']] = [];
        }
        $checked = false;
        if(isset($role_tree[$_POST['get_permission']])){
            if(isset($role_tree[$_POST['get_permission']][$perm['legend']])){
                foreach($role_tree[$_POST['get_permission']][$perm['legend']] as $p){
                    if($p['permission_id'] == $perm['permission_id']){
                        $checked = true;
                        continue;
                    }
                }
            }
        }
        $perm_tree[$perm['legend']][] = [
            'permission_id'=>$perm['permission_id'],
            'permission_name'=>$perm['permission_name'],
            'checked'=>$checked
        ];
    }
    die(helper::get_sub_template('user_permission_edit', ['permission'=>$perm_tree]));
}

echo helper::find_template(
    'User_permission', 
    [
        'roles' => $role_tree,
        'designations'=>$designations
    ]
);