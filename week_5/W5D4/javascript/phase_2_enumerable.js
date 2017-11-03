// Array#myEach(callback) - receives a callback function and executes the
// callback for each element in the array
// Note that JavaScript's forEach function has no return value (returns undefined)

Array.prototype.myEach = function(callback) {
  for (let i = 0; i < this.length; i++) {
    callback(this[i]);
  }
};

function printMe(el) {
  console.log(el);
}

[1,2,3].myEach(printMe);

// Array#myMap(callback) - receives a callback function, returns a new array
// of the results of calling the callback function on each element of the array
// should use myEach and a closure

Array.prototype.myMap = function(callback) {
  for (let i = 0; i < this.length; i++) {
    this[i] = callback(this[i]);
  }
  return this;
};

function timesThree(n) {
  return n * 3;
}

console.log([1,2,3].myMap(timesThree));

// Array#myReduce(callback[, initialValue]) - (like Ruby's Array#inject)
// receives a callback function, and optional initial value, returns an
// accumulator by applying the callback function to each element and the
// result of the last invocation of the callback (or initial value if supplied)

Array.prototype.myReduce = function(callback, initialValue) {
  // empty array case
  if (this === []) return;
  // set initial accumulator
  // let accumulator = (initialValue) ? initialValue : this[0];
  if (initialValue === undefined) {
    return this.slice(1).myReduce(callback, this[0]);
  }
  let accumulator = initialValue;
  this.myEach( (el) => {
    accumulator = callback(accumulator, el);
  } );
  // iterate through array and use callback on each element & accumulator
  return accumulator;
};

function addThings(a, b) {
  return a + b;
}

function timesThings(a, b) {
  return a * b;
}

console.log([1,2,3].myReduce(addThings));
console.log([1,2,3].myReduce(addThings, 40));
console.log([1,2,3].myReduce(timesThings, 0));
