use std::fs;
use std::collections::HashMap;
use std::io::Error;

#[derive(Debug, PartialEq, Hash, Eq, Copy, Clone)]
struct Point {
    x: u32,
    y: u32
}

#[derive(Debug, PartialEq, Eq, Copy, Clone)]
struct Segment(Point, Point);

impl Segment {
    fn parse(input: &String) -> Option<Vec<Segment>> {
        let mut segments = Vec::new();

        for line in input.lines() {
            let mut axes = line.split(" -> ");
            
            let mut begin = axes.next()?.split(',');
            let mut end = axes.next()?.split(',');
            
            let p1 = Point{x: begin.next()?.parse().ok()?, y: begin.next()?.parse().ok()?};
            let p2 = Point{x: end.next()?.parse().ok()?, y: end.next()?.parse().ok()?};
            
            segments.push(Segment(p1, p2));
        }

        Some(segments)
    }

    fn get_points(&self) -> Vec<Point> {
        let mut current = self.0;
        let mut points = vec![current];

        while current != self.1 {
            if current.x > self.1.x {
                current.x -= 1;
            }

            if current.x < self.1.x {
                current.x += 1;
            }

            if current.y > self.1.y {
                current.y -= 1;
            }

            if current.y < self.1.y {
                current.y += 1;
            }

            points.push(current);
        }

        points
    }
}

fn main() -> Result<(), Error> {
    let input: String = fs::read_to_string("./input/5.txt").unwrap_or_else(|_| panic!("Error reading file."));
    let segments: Vec<Segment> = Segment::parse(&input).unwrap();
    let mut map: HashMap<Point, u32> = HashMap::new();
    
    for seg in segments {
        for point in seg.get_points() {
            if map.contains_key(&point) {
                *map.get_mut(&point).unwrap() += 1;
                continue;
            }
            map.insert(point, 1);
        }
    }

    println!("{}", map.iter().filter(|x| x.1 >= &2).count().to_string());

    Ok(())
}