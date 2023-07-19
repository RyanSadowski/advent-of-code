use std::str;

pub fn process_part2(input: &str) -> bool {

}

pub fn process_part1(input: Vec<&str>) -> bool {
    let cols = 1000;
    let rows = 1000;
    let mut light_matrix: Vec<Vec<i32>> = vec![vec![0; cols]; rows];
    

    for command in input {
        let stuff = parseCommand(command);
    }

    


}


enum Command{
    on,
    off,
    toggle
}

struct LightCommand {
    //toggle, on, off
    // !, 1 , 0
    cmd: Command,
    minX: i32,
    maxX: i32,
    minY: i32,
    maxY: i32

}

fn parseCommand(input: &str) -> Option<LightCommand> {
    
}


fn getCommandEnum(input: &str) -> Command {
    if(input.contains("turn off")){
        Command::off
    } else if (input.contains("turn on")){
        Command::on
    } else if (input.contains("toggle")){
        Command::toggle
    } else {
        Command::toggle
    }
}

