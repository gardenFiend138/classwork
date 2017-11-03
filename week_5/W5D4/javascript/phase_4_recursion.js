// range(start, end) - receives a start and end value, returns an array from start up to end
// if start === end, return end; ||
function range(start, end) {
  if (start > end) {
    return;
  }

  if (start === end) {
    return [end];
  } else {
    return [start].concat(range(start + 1, end));
  }
}


// console.log(range(1,1));

// sumRec(arr) - receives an array of numbers and recursively sums them

function rumRec(arr) {
  if (arr.length <= 1) {
    return arr.pop();
  } else {
    return arr.pop() + rumRec(arr);
  }
}

// console.log(rumRec([1,2,3,4]));
// console.log(rumRec([1]));
// console.log(rumRec([]));

// exponent(base, exp) - receives a base and exponent, returns the base raise
// to the power of the exponent (base ^ exp)
// write two versions:
// # this is math, not Ruby methods.
//
// # version 1
// exp(b, 0) = 1
// exp(b, n) = b * exp(b, n - 1)

function linearExponent(base, n) {
  if (n === 0) {
    return 1;
  } else {
    return base * linearExponent(base, n - 1);
  }
}

// console.log(linearExponent(3,4));
// console.log(linearExponent(3,0));

//
// # recursion 2
// exp(b, 0) = 1
// exp(b, 1) = b
// exp(b, n) = exp(b, n / 2) ** 2             [for even n]
// exp(b, n) = b * (exp(b, (n - 1) / 2) ** 2) [for odd n]
