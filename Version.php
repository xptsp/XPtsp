<?php
define(PHPBB_ROOT_PATH, '../board/');
include('../tools/functions.php');

// Section: Current XPtsp GUI version
print "[XPtsp_v2]\n";
$data = FileInfo(Get_Latest("XPtsp_v*_GUI.exe"));
$ver = str_replace("_GUI.exe", "", str_replace("XPtsp_v", "", $data['file']));
echo 'Program='.$ver."|".$data['size'].'|'.date("omdHis", filemtime($file))."|".$data['md5']."\n";

// Section: Supported GUI Languages
echo "\n[Languages_v2]\n";
foreach (glob("Languages/*.ini") as $file) {
	$Ver = "";
	$data = file($file) or die('Cannot read "'.$file.'"!');
	$data = str_replace(chr(0), '', $data);
	foreach ($data as $line) {
		$item = rtrim(ltrim(substr($line, 0, strpos($line, '='))));
		if ($item == "Version") {
			$Ver = substr($line, strpos($line, '=')+1);
		}
	}
	if ($Ver <> "") {
		echo str_replace("Languages/", "", str_replace(".ini", "", $file))."=";
		echo substr($Ver, 0, strlen($Ver) - 2)."|".date("omdHis", filemtime($file))."\n";
	}
}

// Section: GUI Themes
$info = '';
foreach (glob("*", GLOB_ONLYDIR) as $dir) {
	$file = $dir."/".$dir.".xptsp";
	if (file_exists($file)) {
		$data = FileInfo($file);
		$info = $info . str_replace(".xptsp", "", $dir) . '=' . $data['size'] . '|' . 
			date("omdHis", $data['uploaded']) . '|' . $data['md5'] . '|' .
			(($dir == "NeonBlue") ? "Neon" : "Original") . "\n";
	}
}

// Section: GUI themes v3
echo "\n[Themes_v2]\n".$info;
echo "\n[Themes_v3]\n".$info;

// Section: GUI Extras
$info = '';
echo "\n[Extras_v2]\n";
foreach (glob("*.extra") as $file) {
	$data = FileInfo($file);
	echo str_replace(".extra", "", $file)."=". $data['size'] ."|" . date("omdHis", $data['latest']). "|" . $data['md5'] . "\n";
}

// Section: Drive Space Indicator
echo "\n[DSI]\n";
$data = FileInfo(Get_Latest("../DSI/DriveSpace_v*_Silent.exe"));
$ver = substr($data['file'], stripos($data['file'], "_v") + 2);
$ver = substr($ver, 0, stripos($ver, "_Silent"));
echo 'Latest='.$ver."|".$data['size'].'|'.$data['md5']."\n";

// Sections: Theme Screenshots
foreach (glob("*", GLOB_ONLYDIR) as $dir) {
	$header = 0;
	foreach(glob($dir."/Gallery/*.png") as $file) {
		if ($header == 0) { echo "\n[".$dir."]\n"; }
		$header += 1;
		echo $header."=http://www.xptsp.com/XPtsp/".$file."\n";
	}
	foreach(glob($dir."/Gallery/*.jpg") as $file) {
		if ($header == 0) { echo "\n[".$dir."]\n"; }
		$header += 1;
		echo $header."=http://www.xptsp.com/XPtsp/".$file."\n";
	}
}
?>
