extern crate crypto;
extern crate regex;

use crypto::md5::Md5;
use crypto::digest::Digest;

#[cfg(test)]
mod tests {
    #[test]
    fn part_one() {
        assert_eq!(22728, get_index(String::from("abc")));
    }
}
fn get_index(salt: String) -> i32 {
    let mut index = 0;

    let mut hasher = Md5::new();
    let input = &(salt + &index.to_string());
    hasher.input_str(input);
    let mut output = hasher.result_str();
    println!("{}", output);
    let i = 32;
    i
}
fn main() {
    get_index("yjdafjpo".to_string());
}
