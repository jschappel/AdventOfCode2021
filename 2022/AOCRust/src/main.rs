mod day5;
mod day6;
fn main() {
    let day5_data = include_str!("../data/Day5_real.txt");
    println!("Day 5 Result pt1 is: {}", day5::pt1(day5_data));
    println!("Day 5 Result pt2 is: {}", day5::pt2(day5_data));

    let day6_data = include_str!("../data/Day6_real.txt");
    println!("Day 6 Result pt1 is: {}", day6::pt1(day6_data));
    println!("Day 6 Result pt2 is: {}", day6::pt2(day6_data));
}
