mod day5;

fn main() {
    let data = include_str!("../data/Day5_real.txt");
    let res = day5::run(data);
    println!("The Result is: {}", res);
}
