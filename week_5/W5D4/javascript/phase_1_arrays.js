// Array#uniq - returns a new array containing only the unique elements of
// the original array the unique elements should be in the order in which
// they first appear should not mutate the original array

Array.prototype.uniq = function() {
  const uniqArray = [];
  this.forEach((el) => {
    if (!uniqArray.includes(el)) {
      uniqArray.push(el);
    }
  });
  return uniqArray;
};

let a = [1,2,3,4,5,5,5,5];
let b = [];
console.log(a.uniq());
console.log(b.uniq());

// Array#twoSum - returns an array of position pairs where the elements
// sum to zero

Array.prototype.twoSum = function() {
  const sumPairs = [];
  for (let startIdx = 0; startIdx < this.length; startIdx++){
    for (let endIdx = startIdx + 1; endIdx < this.length; endIdx++) {
      if (this[startIdx] + this[endIdx] === 0) {
        sumPairs.push([startIdx, endIdx]);
      }
    }
  }
  return sumPairs;
};

let c = [-1, 2, -2, 1, 0];
console.log(c.twoSum());

// Array#transpose - where we have a two-dimensional array representing a matrix. returns the transpose
// should not mutate the original array

Array.prototype.transpose = function() {
  const rowCount = this.length;
  const colCount = this[0].length;
  const transposed = [];
  for (let i = 0; i < colCount; i++) {
    transposed.push(new Array);
    for (let j = 0; j < rowCount; j++) {
      transposed[i][j] = this[j][i];
    }
  }
  return transposed;
};

let e = [[1,2,3],[4,5,6]];
console.log(e.transpose());
