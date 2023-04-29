<?php 
$db = db::get_connection(storage::init()->system_config->database);
$my = helper::init()->get_session_user();
//var_dump($_POST);
if(isset($_POST['project_name'])){
    if($helper::init()->user_can('can_add_project')){
        $staff = $db->select('staff','staff_id')
                    ->where(['user_reference'=>$my['user_id']])
                    ->fetch();
        $data = [
            'project_name'=>addslashes($_POST['project_name']), 
            'project_starting_date'=>helper::format_time($_POST['project_starting_date'],'Y-m-d H:i:s'), 
            'project_ending_date'=>helper::format_time($_POST['project_ending_date'],'Y-m-d H:i:s'), 
            'project_description'=>addslashes($_POST['project_description']), 
            'project_burget'=>addslashes($_POST['project_burget']), 
            'staff_id'=>$staff['staff_id'], 
            'created_time'=>date('Y-m-d H:i:s')
        ];
        $k = $db->insert('project', $data);
        if(!$db->error() && $k){
            $msg = 'Project created successful';
        }
        else{
            $msg = 'Project create error';
        }
    }
    else $msg = 'Permission denied';
}
$project = $db->select('project', 'project.*,user.first_name,user.middle_name,user.last_name')
              ->join('staff','staff.staff_id=project.staff_id')
              ->join('user','staff.user_reference=user.user_id')
              ->fetchALL();
        
//var_dump('<pre>',$project);
$data = ['project'=>$project];
echo helper::find_template('projects', ['project'=>$project]);
        