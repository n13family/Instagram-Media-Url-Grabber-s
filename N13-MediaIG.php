<?php
// Coded By N31
error_reporting(0);
$username = $argv[1];
if(!isset($username)){
	die('Usage php N13-MediaIG.php YourIgUsername');
}
function check($s1, $s2, $s3){
	$d = explode($s2, $s1);
	$dc = explode($s3, $d[1]);
	return $dc[0];
}
function grab($url){
$ch = curl_init();
curl_setopt($ch, CURLOPT_URL, "https://www.instagram.com/$url/");
curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
$res = curl_exec($ch);
curl_close($ch);
return $res;
}
$a = grab($username);
$b = check($a, '<script type="text/javascript">window._sharedData = ',';</script>');

$d = json_decode($b, true);
$x = $d['entry_data']['ProfilePage']['0']['graphql']['user']['edge_owner_to_timeline_media']['edges'];
$w = count($x);
for($x = 0; $x <= $w-1	; $x++){
	
$c = $d['entry_data']['ProfilePage']['0']['graphql']['user']['edge_owner_to_timeline_media']['edges'][$x]['node']['shortcode'];
$k = fopen('log.txt', 'a');
fwrite($k, "https://www.instagram.com/p/$c");
fclose($k);
echo "\nSuccess Retrieving https://www.instagram.com/p/$c";
}
echo "\nLog saved to Log.txt";	
?>