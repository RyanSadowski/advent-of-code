use std::{vec};

pub fn process_part1(input: &str) -> i32 {
    let mut sum = 0;
    for line in input.lines() {
        let dimensions = get_dimensions_from_string(line);
        let wrapping_paper = get_wrapping_paper(&dimensions);  
        println!("dim {:?} = {:?}", dimensions, wrapping_paper);
        sum += wrapping_paper;
    }

    return sum;
}


fn get_dimensions_from_string(input: &str) -> Vec<i32> {
    return input.split('x').map(|num| num.parse().unwrap()).collect()
}

fn get_wrapping_paper(dimensions: &[i32]) -> i32 {
    // dimensions (length l, width w, and height h) of each present
    let l = dimensions[0];
    let w = dimensions[1];
    let h = dimensions[2];

    // required wrapping paper for each gift a little easier: find the surface area of the box, which is 2*l*w + 2*w*h + 2*h*l
    let paper = 2 * l * w + 2 * w * h + 2 * h * l;

    // little extra paper for each present: the area of the smallest side.
    let slack = std::cmp::min(l * w, std::cmp::min(w * h, h * l));

    // total square feet of wrapping paper
    let total_paper = paper + slack;

    return total_paper
}

fn get_ribon_from_dimensions(dimensions: &[i32]) -> i32 {
    // dimensions (length l, width w, and height h) of each present
    let l = dimensions[0];
    let w = dimensions[1];
    let h = dimensions[2];

    let perimeter1 = 2 * (l + w);
    let perimeter2 = 2 * (l + h);
    let perimeter3 = 2 * (h + w);

    let min_perimeter = perimeter1.min(perimeter2).min(perimeter3);
    let cubic_ft = l * w * h;

    return min_perimeter + cubic_ft;
}

pub fn process_part2(input: &str) -> i32 {
  
    let mut sum = 0;
    for line in input.lines() {
        let dimensions = get_dimensions_from_string(line);
        let wrapping_paper = get_wrapping_paper(&dimensions);  
        let ribon = get_ribon_from_dimensions(&dimensions);
         println!("{:?} = {:?} + {:?}", dimensions, wrapping_paper, ribon);
        sum += ribon;
    }

    return sum;

}


