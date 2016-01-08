function PrimePalindrome(maxNumber) {
    this.maxNumber = maxNumber;
};

PrimePalindrome.prototype.isPalindrome = function (number) {
    array = number.toString().split('');
    return array.join('') == array.reverse().join('');
};

PrimePalindrome.prototype.isPrime = function (number) {
    for (var i = 2; i < number; i++) {
        if (number % i == 0)
            return false
    }
    return true
};

PrimePalindrome.prototype.isPrimePalindrome = function (number) {
  return this.isPrime(number) && this.isPalindrome(number);
};

PrimePalindrome.prototype.maxPrimePalindrome = function () {
  for (var i = this.maxNumber - 1; i < this.maxNumber; i--) {
      if (this.isPrimePalindrome(i))
        return i;
  }
};

console.log(new PrimePalindrome(999).maxPrimePalindrome());
