use std::fs;
use std::io::Error;

#[derive(Debug, PartialEq, Copy, Clone)]
struct Point(u32, u32);

#[derive(Debug, PartialEq, Copy, Clone)]
struct Segment(Point, Point);


impl Segment {
    fn parse(input: &String) -> Option<Vec<Segment>> {
        let mut segments = Vec::new();

        for line in input.lines() {
            let mut axes = line.split(" -> ");
            
            let mut begin = axes.next()?.split(',');
            let mut end = axes.next()?.split(',');
            
            let p1 = Point(begin.next()?.parse().ok()?, begin.next()?.parse().ok()?);
            let p2 = Point(end.next()?.parse().ok()?, end.next()?.parse().ok()?);

            if p1.0 == p2.0 || p1.1 == p2.1 {
                segments.push(Segment(p1, p2));
            }
        }

        Some(segments)
    }

    fn get_intersecting(&self) -> Vec<Point> {
        let mut intersecting = Vec::new();
    }
}


fn main() -> Result<(), Error> {
    let input: String = fs::read_to_string("./input/5.txt").unwrap_or_else(|_| panic!("Error reading file."));
    let segments: Vec<Segment> = Segment::parse(&input).unwrap();
    
    for seg in segments {
        
    }

    Ok(())
}