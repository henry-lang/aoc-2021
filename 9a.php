<?php
declare(strict_types=1);

$heightmap = explode("\n", file_get_contents("./input/9.txt"));
foreach($heightmap as &$line) {
    $line = str_split($line);
    foreach($line as &$point) {
        $point = intval($point);
    }
}

$count = 0;

foreach($heightmap as $i => &$line) {
    foreach($line as $j => &$point) {
        if($point < ($line[$j - 1] ?? 10) and
           $point < ($line[$j + 1] ?? 10)  and
           $point < ($heightmap[$i - 1][$j] ?? 10) and
           $point < ($heightmap[$i + 1][$j] ?? 10)) {
               $count += $point + 1;
        }
    }
}
echo($count . "\n");

?>