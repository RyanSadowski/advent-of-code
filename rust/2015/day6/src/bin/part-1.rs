use day5::process_part1;
use std::fs::File;
use std::io::{BufRead, BufReader};

fn main() {
    let file = File::open("input.txt").expect("Failed to open file");
    let reader = BufReader::new(file);
    let mut sum = 0;

    for line in reader.lines() {
        if let Ok(line) = line {
            if process_part1(line.as_str()) {
                sum = sum + 1;
            }
        }
    }
    println!("{}", sum)
}
