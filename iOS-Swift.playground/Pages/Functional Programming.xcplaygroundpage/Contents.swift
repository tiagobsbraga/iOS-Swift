//: ## Functional Programming
//: ----
//: [Previous](@previous)

import Foundation

//: Filtering

let completeArray = Array(0..<10)

let evenNumbers = completeArray.filter { $0 % 2 == 0 }

print(evenNumbers)


//: Reducing

let purchases = [0.35, 4.82, 8.34, 8.0, 2.4, 5.6, 9.9, 6.3, 4.6, 7.7]

let total = purchases.reduce(0) { $0 + $1 }

print(total)


//: Mapping

let numbers = Array(0..<10)

let strings = numbers.map { "The number is " + String($0) }

print(strings)


//: [Next](@next)