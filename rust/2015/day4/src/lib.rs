extern crate crypto;

use crypto::md5::Md5;
use crypto::digest::Digest;

use std::collections::HashSet;

pub fn process_part1(input: String) {

    let mut hasher = Md5::new();
    let key = "bgvyzdsv".as_bytes();
    for i in (0..std::u64::MAX) {
        hasher.input(key);
        hasher.input(i.to_string().as_bytes());
        
        let mut output = [0; 16]; // An MD5 is 16 bytes
        hasher.result(&mut output);

        let first_five = output[0] as i32 + output[1] as i32 + (output[2] >> 4) as i32;
        if first_five == 0 {
            println!("{}", i);
            break;
        }
        hasher.reset();
    }    


}


pub fn process_part2() {

let mut hasher = Md5::new();
    let key = "bgvyzdsv".as_bytes();
    for i in (0..std::u64::MAX) {
        hasher.input(key);
        hasher.input(i.to_string().as_bytes());
        
        let mut output = [0; 16]; // An MD5 is 16 bytes
        hasher.result(&mut output);

        let res = hasher.result_str();
        if res.starts_with("000000") {
            println!("{}", i);
        }

        hasher.reset();
    }
}

