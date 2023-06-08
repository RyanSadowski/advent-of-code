use day4::process_part2; 
use std::fs;

fn main(){
    let file = fs::read_to_string("input.txt").unwrap();
    process_part2();
}
