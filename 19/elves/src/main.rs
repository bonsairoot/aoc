fn josephus(elves: i32) -> i32 {
    let mut bin = format!("{:b}", elves);
    bin.push('1');
    i32::from_str_radix(&bin[1..], 2).unwrap()
}
fn josephus_across(elves: i32) -> i32 {
    let mut pos = 1;
    while 3 * pos <= elves {
        pos *= 3;
    }
    let marg = elves - 2 * pos;
    elves - pos + if marg > 0 { marg } else { 0 }
}
fn main() {
    println!("Part I: {}", josephus(3017957));
    println!("Part II: {}", josephus_across(3017957));
}
