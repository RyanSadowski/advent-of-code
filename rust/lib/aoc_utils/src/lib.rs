use std::error::Error;
use std::fs::File;
use std::io::{BufRead, BufReader};

pub fn read_file_to_vec(file_path: &str) -> Vec<String> {
    match File::open(file_path) {
        Ok(file) => {
            let reader = BufReader::new(file);
            let lines: Vec<String> = reader
                .lines()
                .filter_map(|line| line.ok())
                .collect();

            lines
        }
        Err(_) => {
            eprintln!("Error opening or reading the file.");
            Vec::new()
        }
    }
}
