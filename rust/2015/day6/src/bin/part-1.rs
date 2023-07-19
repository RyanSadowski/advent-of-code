use day6::process_part1;
use aoc_utils::read_file_to_vec;
use std::fs::File;
use std::io::{BufRead, BufReader};

fn main() {
    //let file = File::open("input.txt").expect("Failed to open file");
    match read_file_to_vec("input.txt") {
        Ok(lines) => {
            process_part1(lines);
        }
        Err(err) => {
            eprintln!("Error: {}", err);
        }
    }
    process_part1(&file);
}
