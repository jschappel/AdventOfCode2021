use std::collections::HashSet;

fn not_unique<I: Iterator<Item = char>>(iter: &mut I) -> bool {
    let mut seen: HashSet<char> = HashSet::new();
    for c in iter {
        if seen.contains(&c) {
            return true;
        }
        seen.insert(c);
    }
    false
}

fn find_sequence(data: &str, num_of_unique: usize) -> usize {
    let res = data
        .chars()
        .enumerate()
        .skip_while(|(i, c)| {
            let mut peek_iter = data.chars().skip(*i).take(num_of_unique);
            not_unique(&mut peek_iter)
        })
        .take(num_of_unique + 1)
        .last();

    match res {
        Some((i, _)) => i,
        None => panic!("Nothing Found!!!"),
    }
}

pub fn pt1(data: &str) -> usize {
    find_sequence(data, 4)
}

pub fn pt2(data: &str) -> usize {
    find_sequence(data, 14)
}

#[cfg(test)]
mod test {
    use super::*;

    #[test]
    fn day6_pt1_test() {
        let data = include_str!("../data/Day6_test.txt");
        let actual = pt1(data);
        assert_eq!(actual, 7);
    }

    #[test]
    fn day6_pt1_real() {
        let data = include_str!("../data/Day6_real.txt");
        let actual = pt1(data);
        assert_eq!(actual, 1623);
    }

    #[test]
    fn day6_pt2_test() {
        let data = include_str!("../data/Day6_test.txt");
        let actual = pt2(data);
        assert_eq!(actual, 19);
    }

    #[test]
    fn day6_pt2_real() {
        let data = include_str!("../data/Day6_real.txt");
        let actual = pt2(data);
        assert_eq!(actual, 3774);
    }
}
