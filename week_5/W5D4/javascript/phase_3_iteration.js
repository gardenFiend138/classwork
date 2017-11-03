// Array#bubbleSort - receives an array, returns a sorted array by
// implementing [bubble sort][bubble sort] sorting algorithm

Array.prototype.mutateBubbleSort = function() {
  for (let i = 0; i < this.length; i++) {
    for (let j = 0; j < this.length - i; j++) {
      if (this[j] > this[j + 1]) {
        let stored = this[j];
        this[j] = this[j + 1];
        this[j + 1] = stored;
      }
    }
  }
  console.log(this);
  return this;
};

// Remember to invoke the function (mutateBubbleSort within bubbleSort)
Array.prototype.bubbleSort = function() {
  return this.slice(0).mutateBubbleSort();
};

const unsorted = [4,6,3,3,7,8,6,3,5,7,8];
const empty = [];

console.log(unsorted.bubbleSort());
console.log(empty.bubbleSort());
console.log(unsorted);

// String#substrings - receives a string, returns an array of all substrings
String.prototype.substrings = function() {
  const substrings = [];
  for (let i = 0; i < this.length; i++ ) {
    for (let j = i + 1; j <= this.length; j++ ) {
      substrings.push(this.slice(i,j));
    }
  }
  return substrings;
};

console.log("asdf".substrings());
console.log("".substrings());
