use std::str;

fn pairs(input: &str) -> bool {
    // check for pair of any two letters that appears at least twice
    let indices: Vec<_> = input.char_indices().map(|(i, _)| i).collect();

    for i in 0..=(indices.len() - 4) {
        let pair = &input[indices[i]..indices[i + 2]];
        let tail = &input[indices[i + 2]..];

        if tail.contains(pair) {
            return true;
        }
    }

    false
}

fn repeat_between(input: &str) -> bool {
    input
        .chars()
        .zip(input.chars().skip(2))
        .any(|(a, b)| a == b)
}


pub fn process_part2(input: &str) -> bool {
    pairs(input) && repeat_between(input)
}

pub fn process_part1(input: &str) -> bool {
    //It contains at least three vowels (aeiou only), like aei, xazegov, or aeiouaeiouaeiou.
    //It contains at least one letter that appears twice in a row, like xx, abcdde (dd), or aabbccdd (aa, bb, cc, or dd).
    //It does not contain the strings ab, cd, pq, or xy, even if they are part of one of the other requirements.

    let valid_vowels = ['a', 'e', 'i', 'o', 'u']; //contains(&value)
    let invalid_slices = ["ab", "cd", "pq", "xy"];
    let mut num_vowels = 0;
    let mut dubz = false;
    let chars = input.chars();
    let mut previous_char = '\0';

    for char in chars {
        if valid_vowels.contains(&char) {
            num_vowels += 1;
        }

        if previous_char == char {
            dubz = true;
        }

        let sequence = previous_char.to_string() + char.to_string().as_str();

        if invalid_slices.contains(&sequence.as_str()) {
            return false;
        }

        previous_char = char;
    }

    if num_vowels >= 3 && dubz {
        return true;
    }

    return false;
}
