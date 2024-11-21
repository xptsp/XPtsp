<?php
$update = true;
$ini = parse_ini_file("Version.txt", true);

// Section: Current XPtsp GUI version
print "[XPtsp_v2]\n";
$latest = "";
$tstamp = 0;
foreach (glob("../../XPtsp_v*_GUI.exe") as $file) {
	if (filemtime($file) > $tstamp) { 
		$tstamp = filemtime($file); 
		$latest = $file;
	}
}
echo "Program=".str_replace("../../", "", str_replace("_GUI.exe", "", str_replace("XPtsp_v", "", $latest)));
echo "|".filesize($latest)."|".date("omdHis", filemtime($file))."\n";

// Section: Supported GUI Languages
echo "\n[Languages]\n";
foreach (glob("../../Languages/*.ini") as $file) {
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
		echo str_replace("../../", "", str_replace("Languages/", "", str_replace(".ini", "", $file)));
		echo "=".substr($Ver, 0, strlen($Ver) - 2)."|".date("omdHis", filemtime($file))."\n";
	}
}

// Section: Theme Information
echo "\n[Themes]\n";
foreach ($ini['Theme'] as $k => $v)
{
	echo $k . '=' . $v . "\n";
}

// Section: Information about Update Files (Professional)
echo "\n[Pro]\n";
foreach (glob("*.7z") as $file)
{
	$val = ",,,1";
	$fname = str_replace(".7z", "", $file);
	if (isset($ini['Pro'][$fname])) { $val = $ini['Pro'][$fname]; }
	$line = explode(",", $val);
	$current = date("omdHis", filemtime($file));
	if ($current <> $line[2]) {
		if ($line[3]) { $line[0] = md5_file($file); }
		$line[1] = filesize($file);
		$line[2] = $current;
		$ini['Pro'][$fname] = $line[0].','.$line[1].','.$line[2].",1";
		$update = true;
	}
	echo $file.'='.str_replace(",", "|", $ini['Pro'][$fname])."\n";
}

// Section: Information about Update Files (Home Edition)
echo "\n[Home]\n";
foreach ($ini['Home'] as $k => $v)
{
	echo $k . '=' . $v . "\n";
}

// Section: Information about Update Files (Media Center)
echo "\n[MCE]\n";
foreach ($ini['MCE'] as $k => $v)
{
	echo $k . '=' . $v . "\n";
}

// Handle updating the Version.ini with new info if required:
if ($update) {
	$fh = fopen('Version.txt', 'w') or die('Could not open "Version.ini" for write access!');
	flock($fh, LOCK_EX);
	foreach ($ini as $a => $arr)
	{
		fwrite($fh, "[".$a."]\n");
		foreach ($arr as $k => $v)
		{
			fwrite($fh, $k . '=' . $v . "\n");
		}
		fwrite($fh, "\n");
	}
	flock($fh, LOCK_UN);
	fclose($fh);
}
?>