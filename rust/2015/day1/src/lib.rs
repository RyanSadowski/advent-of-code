pub fn process_part1(input: &str) -> String {
    "works".to_string()

}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn it_works() {
        let result = process_part1("asdf");
        assert_eq!(result, "works");
    }
}
