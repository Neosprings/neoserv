<?php
/**
 * neoserv router — lets victims fetch by basename without knowing the folder.
 *
 *   http://$IP/linpeas.sh           ->  linux/linpeas.sh
 *   http://$IP/winPEASx64.exe       ->  windows/winPEASx64.exe
 *   http://$IP/linux/linpeas.sh     ->  also still works (direct hit)
 *
 * Run via:  php -S 0.0.0.0:80 router.php
 */

$path = parse_url($_SERVER['REQUEST_URI'], PHP_URL_PATH);
$root = __DIR__;
$direct = $root . $path;

// 1) Direct hit (file or directory listing). Let PHP serve normally.
if (is_file($direct)) {
    return false;
}
if (is_dir($direct)) {
    return false;
}

// 2) Basename lookup across known subdirs.
$basename = basename($path);
if ($basename === '' || $basename === '/') {
    return false;
}

$dirs = ['linux', 'windows', 'ad', 'shells', 'tunneling',
         'potatoes', 'sysinternals', 'kernel-exploits', 'static-bins'];

foreach ($dirs as $d) {
    $candidate = "$root/$d/$basename";
    if (is_file($candidate)) {
        $mime = mime_content_type($candidate) ?: 'application/octet-stream';
        header("Content-Type: $mime");
        header("Content-Length: " . filesize($candidate));
        header('Content-Disposition: attachment; filename="' . $basename . '"');
        readfile($candidate);
        exit;
    }
}

// 3) Not found.
http_response_code(404);
header('Content-Type: text/plain');
echo "Not found: $basename\n";
