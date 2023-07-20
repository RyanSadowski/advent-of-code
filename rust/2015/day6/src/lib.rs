use std::str;

pub fn process_part2(input: &str) -> bool {
    return false;
}

pub fn process_part1(input: Vec<String>) -> bool {
    let cols = 1000;
    let rows = 1000;
    let mut light_matrix: Vec<Vec<i32>> = vec![vec![0; cols]; rows];

    for command in input {
        let stuff = parse_command(command);
        match stuff {
            Some(stuff) => println!("{:?}", stuff),
            None => println!("Nothing")
        }
    }
    false
}

#[derive(Debug)]
enum Command {
    On,
    Off,
    Toggle,
}
#[derive(Debug)]
struct LightCommand {
    cmd: Command,
    min_x: i32,
    max_x: i32,
    min_y: i32,
    max_y: i32,
}

fn parse_command(input: String) -> Option<LightCommand> {
    let cmd_enum = get_command_enum(input.clone());
    if let Some((min_x, min_y, max_x, max_y)) = get_coordinates(input) {
        Some(LightCommand {
            cmd: cmd_enum,
            min_x,
            max_x,
            min_y,
            max_y,
        })
    } else {
        None
    }
}

fn get_command_enum(input: String) -> Command {
    if input.contains("turn off") {
        Command::Off
    } else if input.contains("turn on") {
        Command::On
    } else if input.contains("toggle") {
        Command::Toggle
    } else {
        Command::Toggle
    }
}

fn get_coordinates(input: String) -> Option<(i32, i32, i32, i32)> {
    
    // Implement this function to extract min_x, min_y, max_x, max_y from the input
    // It will depend on the format of the input string.
    // For example, you could use regex or string splitting to extract the values.
    // For simplicity, I'm skipping the implementation here.
    return Some((1, 2, 3, 4));
}
