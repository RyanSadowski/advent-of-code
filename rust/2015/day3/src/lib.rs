use std::collections::HashSet;

pub fn process_part1(input: &str) -> i32 {
    let mut position: [i32;2] = [0,0];
    let mut set:  HashSet<(i32, i32)> = HashSet::new();
    let mut deliveries : i32 = 0;

    for c in input.chars() {
        match c {
            '^' => position[1] += 1,
            '>' => position[0] += 1,
            '<' => position[0] -= 1,
            'v' => position[1] -= 1,
            _ => ()
        }

        let was_inserted = set.insert((position[0], position[1]));
        if was_inserted {
            deliveries += 1;
        }


        println!("{:?}",position);
    }
    return deliveries;
}


pub fn process_part2(input: &str) -> usize {
    let mut position: [i32;2] = [0,0];
    let mut position2: [i32;2] = [0,0];

    let mut set:  HashSet<(i32, i32)> = HashSet::new();

    for (i,c) in input.chars().enumerate() {

        if i% 2 == 0 {

            match c {
                '^' => position[1] += 1,
                '>' => position[0] += 1,
                '<' => position[0] -= 1,
                'v' => position[1] -= 1,
                _ => ()
            }
        } else {

            match c {
                '^' => position2[1] += 1,
                '>' => position2[0] += 1,
                '<' => position2[0] -= 1,
                'v' => position2[1] -= 1,
                _ => ()
            }
        }

        set.insert((position[0], position[1]));
        set.insert((position2[0], position2[1]));
       
        println!(" 1 : {:?}, 2 : {:?}",position, position2);
    }
    return set.len();
}


