use std::error::Error;
use std::fs::File;
use std::io::{BufRead, BufReader};

pub fn read_file_to_vec(file_path: &str) -> Result<Vec<&str>, Box<dyn Error>> {
    let file = File::open(file_path)?;
    let reader = BufReader::new(file);

    let lines: Vec<&str> = reader.lines().filter_map(|line| line.ok()).collect();

    Ok(lines)
}

