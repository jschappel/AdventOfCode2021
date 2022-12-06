use std::collections::VecDeque;

#[derive(Debug)]
struct Instruction {
    mv: usize,
    from: usize,
    to: usize,
}

fn init_stack() -> Vec<VecDeque<char>> {
    let mut res = Vec::<VecDeque<char>>::new();
    for _ in 0..10 {
        let tmp = VecDeque::new();
        res.push(tmp);
    }
    res
}

fn parse_top(line: &str) -> Vec<(usize, char)> {
    line.chars()
        .skip(1)
        .step_by(2)
        .enumerate()
        .filter(|(_, c)| c.is_alphabetic())
        .collect::<Vec<(usize, char)>>()
}

fn parse_moves(line: &str) -> Instruction {
    let res: Vec<Result<usize, _>> = line
        .split_ascii_whitespace()
        .skip(1)
        .step_by(2)
        .map(|s| s.parse::<usize>())
        .collect();
    match res[..] {
        [Ok(mv), Ok(from), Ok(to)] => Instruction { mv, from, to },
        _ => panic!("Invalid string parse"),
    }
}

fn move_for_instruction(instr: &Instruction, stack: &mut Vec<VecDeque<char>>) {
    for i in 0..instr.mv {
        match stack[instr.from - 1].pop_front() {
            Some(tmp) => stack[instr.to - 1].push_front(tmp),
            None => panic!("Invalid move"),
        }
    }
}

fn compute_tops(stack: &Vec<VecDeque<char>>) -> String {
    let mut ans = String::new();
    for i in 0..stack.len() {
        match stack[i].front() {
            Some(v) => ans.push(*v),
            None => (),
        };
    }

    ans
}

pub fn run(content: &str) -> String {
    let mut stack = init_stack();
    content
        .lines()
        .take_while(|l| *l != "")
        .map(parse_top)
        .flatten()
        .for_each(|(i, c)| stack[(i + 1) / 2].push_back(c));

    let instructions = content
        .lines()
        .skip_while(|l| *l != "")
        .skip(1)
        .map(parse_moves)
        .collect::<Vec<Instruction>>();

    for instruction in instructions {
        move_for_instruction(&instruction, &mut stack);
    }
    println!("{:?}", stack);
    compute_tops(&stack)
}

#[cfg(test)]
mod test {
    use super::*;

    #[test]
    fn day5_pt1_test() {
        let data = include_str!("../data/Day5_test.txt");
        let actual = run(data);
        assert_eq!(actual, "CMZ");
    }

    #[test]
    fn day5_pt2_test() {
        let data = include_str!("../data/Day5_real.txt");
        let actual = run(data);
        assert_eq!(actual, "MQSHJMWNH");
    }
}
