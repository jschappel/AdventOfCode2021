const fs = require('fs');

type fuel = number;
type fuel_calculator = (accum: number, diff: number) => number;


const parsed_input: [number] = fs.readFileSync('./files/crab.txt', 'utf8').split(',').map((x: string) => parseInt(x));

function calcFuel(val: number, data: [number], fn: fuel_calculator): fuel {
  return data.map(x => Math.abs(x - val)).reduce(fn);
}

function getFuelAmountPt1(accum: number, diff: number) {
  return diff + accum;
}

function getFuelAmountPt2(accum: number, diff: number): fuel {
  let total = 0;
  for (let i = 0; i < diff; i++) {
    total += i + 1;
  }
  return total + accum;
}

function calcShortest(data_list: [number], fn: fuel_calculator): fuel {
  let shortest: [fuel, number] = [Number.MAX_VALUE, 0]; 

  for(let val = 0; val < Math.max(...data_list); val++) {
    const total_fuel = calcFuel(val, data_list, fn);
    if (total_fuel < shortest[0]) {
      shortest = [total_fuel, val];
    }
  }
  return shortest[0];
}


//Note: x is the difference
const pt1_ans = calcShortest(parsed_input, getFuelAmountPt1);
const pt2_ans = calcShortest(parsed_input, getFuelAmountPt2);

console.log(`Total fuel spent for pt1: ${pt1_ans}`);
console.log(`Total fuel spent for pt2: ${pt2_ans}`);