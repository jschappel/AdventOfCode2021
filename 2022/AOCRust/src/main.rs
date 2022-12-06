mod day5;

fn main() {
    let data = include_str!("../data/Day5_real.txt");
    println!("The Result pt1 is: {}", day5::pt1(data));
    println!("The Result pt2 is: {}", day5::pt2(data));
}
