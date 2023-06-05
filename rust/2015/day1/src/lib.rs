pub fn process_part1(input: &str) -> i32 {
    let mut floorz : i32 = 0;
    // https://www.ascii-code.com
    //why can I do byes but not char?
    for c in input.bytes() {
        if c == 41 {
            println!(" 🔽 ");
            floorz -= 1;
        } else if c == 40 {
            println!(" 🔺 ");
            floorz += 1; 
        }
    }
    return floorz; 
}

pub fn process_part2(input: &str) -> i32 {
    let mut floorz : i32 = 0;
    let mut count : i32 = 0;
    // https://www.ascii-code.com
    //why can I do byes but not char?
    for c in input.bytes() {
        count += 1;
        if c == 41 {
            println!(" 🔽 ");
            floorz -= 1;
        } else if c == 40 {
            println!(" 🔺 ");
            floorz += 1; 
        }
        if floorz < 0 {
            return count;
        }
    }
    return floorz;    
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn it_works() {
        let result = process_part1("(())");
        assert_eq!(result, 0);
    }
}
