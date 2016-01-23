<?php
$dir    = '../media';
$files = scandir($dir);
$returnValue = array();

foreach ($files as $file){
	if( strpos($file, 'mp4') == 9){
		array_push($returnValue, $file);
		}
}

echo json_encode(array('files' => $returnValue));
?>
