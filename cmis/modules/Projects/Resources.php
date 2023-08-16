<?php 

$db = db::get_connection(storage::init()->system_config->database);
$my = helper::init()->get_session_user();
$ok = false;
$me = $db->select('staff')->where(['user_reference'=>$my['user_id']])->fetch();
$msg = '';

$request = $_SERVER['REQUEST_URI'];
$storage = storage::init();
/*
SELECT
DISTINCT
project_resources.*,
details.*,
CASE project_resources.resource_type WHEN 'deliverables' THEN 'product' WHEN 'tools' THEN 'tools' END AS res_type
FROM
project_resources
INNER JOIN (
  SELECT DISTINCT tool_id as res_id, tool_name as res_name FROM tools
  UNION
  SELECT DISTINCT product_id as res_id, product_name as res_name FROM product
) AS details ON details.res_id = project_resources.resource_reference;
*/
$qry = "SELECT project_resources.*, details.*, 
        CASE project_resources.resource_type WHEN 'tools' THEN 'tools' ELSE 'product' END 
        AS res_type FROM project_resources 
        INNER JOIN ( SELECT tool_id as res_id, tool_name as res_name FROM tools 
        UNION SELECT product_id as res_id, product_name as res_name FROM product ) 
        AS details ON details.res_id = project_resources.resource_reference";
        
$resources = $db->select('project_resources')
                ->join('project','')
                ->fetchAll();

$resources = $db->query($qry)->fetchAll();
echo helper::find_template('resources', ['resources'=>$resources]);