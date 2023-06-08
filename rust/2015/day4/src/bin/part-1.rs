use day4::process_part1; 
use std::fs;

fn main(){
    let file = fs::read_to_string("input.txt").unwrap();
    process_part1(file);

}
