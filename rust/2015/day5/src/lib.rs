pub fn process_part2(input: &str) -> bool {
    //
    //    It contains a pair of any two letters that appears at least twice in the string without overlapping, like xyxy (xy) or aabcdefgaa (aa), but not like aaa (aa, but it overlaps).
    //  It contains at least one letter which repeats with exactly one letter between them, like xyx, abcdefeghi (efe), or even aaa.
    //
    if input.len() < 3 {
        return false;
    }
    let chars: Vec<char> = input.chars().collect();
    let mut prev = chars[1];
    let mut prev_prev = chars[0];
    let mut sec_condition = false;
    let mut first_condition = false;

    let mut dubz: Vec<&str> = Vec::new();

    // list of doubles and a lagging pointer?

    for (i, char) in chars.iter().enumerate().skip(2) {
        let current = *char;

        if prev_prev == current && prev != current {
            sec_condition = true;
        }

        {
            if prev_prev != current && prev == current {
                let seg = String::from(prev) + &String::from(current);
                let seg_ref: &str = Box::leak(seg.into_boxed_str());
                if dubz.iter().any(|&s| s == seg_ref) {
                    first_condition = true;
                } else {
                    dubz.push(seg_ref);
                }
            }
        } // End of the scope block

        prev_prev = prev;
        prev = current;
    }

    return sec_condition && first_condition;
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
