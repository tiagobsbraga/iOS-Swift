//: ## Functional Programming
//: ----
//: [Previous](@previous)

import Foundation

//: Filtering

let evenAndOddNumbers = Array(0..<10)
let onlyEvenNumbers = evenAndOddNumbers.filter { $0 % 2 == 0 }
print(onlyEvenNumbers)

//: Reducing

let purchases = [0.35, 4.82, 8.34, 8.0, 2.4, 5.6, 9.9, 6.3, 4.6, 7.7]
let total = purchases.reduce(0) { $0 + $1 }
print(total)

//: Mapping

let numbers = Array(0..<10)
let strings = numbers.map { "The number is " + String($0) }
print(strings)

//: FlatMap

let nestedArrays = [[0, 1, 2], [3, 4, 5], [6, 7, 8]]
let flatArray = nestedArrays.flatMap { $0 }
print(flatArray)

//: Combining uses

let numbersArray = Array(0..<10)
let stringResult = numbersArray.filter { $0 % 2 == 0 }
                               .map { "[\($0)]" }
                               .reduce("List of even numbers:") { $0 + " " + $1 }
print(stringResult)

//: [Next](@next)
