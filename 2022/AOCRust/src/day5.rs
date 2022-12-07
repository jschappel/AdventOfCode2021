use std::collections::VecDeque;

type Stack = Vec<VecDeque<char>>;

#[derive(Debug)]
struct Instruction {
    mv: usize,
    from: usize,
    to: usize,
}

fn init_stack() -> Stack {
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
    let res: Vec<usize> = line
        .split_ascii_whitespace()
        .filter_map(|s| s.parse::<usize>().ok())
        .collect();
    match res[..] {
        [mv, from, to] => Instruction { mv, from, to },
        _ => panic!("Invalid string parse"),
    }
}

fn move_for_instruction_pt1(instr: &Instruction, stack: &mut Stack) {
    for i_ in 0..instr.mv {
        match stack[instr.from - 1].pop_front() {
            Some(tmp) => stack[instr.to - 1].push_front(tmp),
            None => panic!("Invalid move"),
        }
    }
}

fn move_for_instruction_pt2(instr: &Instruction, stack: &mut Stack) {
    let mut tmp = VecDeque::new();
    for _ in 0..instr.mv {
        match stack[instr.from - 1].pop_front() {
            Some(v) => tmp.push_front(v),
            None => panic!("Invalid move"),
        }
    }
    for _ in 0..instr.mv {
        let item = tmp.pop_front().unwrap();
        stack[instr.to - 1].push_front(item);
    }
}

fn compute_tops(stack: &Stack) -> String {
    let mut ans = String::new();
    for i in 0..stack.len() {
        match stack[i].front() {
            Some(v) => ans.push(*v),
            None => (),
        };
    }
    ans
}

pub fn pt1(content: &str) -> String {
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
        move_for_instruction_pt1(&instruction, &mut stack);
    }
    compute_tops(&stack)
}

pub fn pt2(content: &str) -> String {
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
        move_for_instruction_pt2(&instruction, &mut stack);
    }
    compute_tops(&stack)
}

#[cfg(test)]
mod test {
    use super::*;

    #[test]
    fn day5_pt1_test() {
        let data = include_str!("../data/Day5_test.txt");
        let actual = pt1(data);
        assert_eq!(actual, "CMZ");
    }

    #[test]
    fn day5_pt1_real() {
        let data = include_str!("../data/Day5_real.txt");
        let actual = pt1(data);
        assert_eq!(actual, "MQSHJMWNH");
    }

    #[test]
    fn day5_pt2_test() {
        let data = include_str!("../data/Day5_test.txt");
        let actual = pt2(data);
        assert_eq!(actual, "MCD");
    }

    #[test]
    fn day5_pt2_real() {
        let data = include_str!("../data/Day5_real.txt");
        let actual = pt2(data);
        assert_eq!(actual, "LLWJRBHVZ");
    }
}
