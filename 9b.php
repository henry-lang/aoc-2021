<?php
declare(strict_types=1);

class Point {
    public $y;
    public $x;

    public function __construct($y, $x) {
        $this->y = $y;
        $this->x = $x;
    }
}

function parse_input($str) {
    $input = explode("\n", $str);
    foreach($input as &$line) {
        $line = str_split($line);
        foreach($line as &$point) {
            $point = intval($point);
        }
    }
    return $input;
}

function find_low_points($heightmap) {
    $low_points = [];
    foreach($heightmap as $y => &$line) {
        foreach($line as $x => &$point) {
            if($point < ($line[$x - 1] ?? 10) and
               $point < ($line[$x + 1] ?? 10)  and
               $point < ($heightmap[$y - 1][$x] ?? 10) and
               $point < ($heightmap[$y + 1][$x] ?? 10)) {
                $low_points[] = new Point($y, $x);
            }
        }
    }
    return $low_points;
}

function find_basins($heightmap, $low_points) {
    $basins = [];

    foreach($low_points as $i => &$low_point) {
        $to_visit = [$low_point];
        $visited = [];

        while(count($to_visit) > 0) {
            $selected = array_shift($to_visit);
            if(isset($visited[$selected->y][$selected->x])) {
                continue;
            }
            $visited[$selected->y][$selected->x] = true;

            if($heightmap[$selected->y][$selected->x] != 9) {
                $basins[$i] = ($basins[$i] ?? 0) + 1;

                if(isset($heightmap[$selected->y - 1][$selected->x])) {
                    $to_visit[] = new Point($selected->y - 1, $selected->x);
                }

                if(isset($heightmap[$selected->y + 1][$selected->x])) {
                    $to_visit[] = new Point($selected->y + 1, $selected->x);
                }

                if(isset($heightmap[$selected->y][$selected->x - 1])) {
                    $to_visit[] = new Point($selected->y, $selected->x - 1);
                }

                if(isset($heightmap[$selected->y - 1][$selected->x + 1])) {
                    $to_visit[] = new Point($selected->y, $selected->x + 1);
                }
            }
        }
    }
    rsort($basins);
    return $basins;
}

$heightmap = parse_input(file_get_contents("./input/9.txt"));
$low_points = find_low_points($heightmap);
$basins = find_basins($heightmap, $low_points);

echo(array_product(array_slice($basins, 0, 3)) . "\n");
?>