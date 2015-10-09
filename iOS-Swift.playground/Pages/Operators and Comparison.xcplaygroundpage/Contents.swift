//: ## Operators and Comparison
//: ----
//: [Previous](@previous)

import Foundation
var result = ""

//: Assignment

var a = 11
var b = 4
let (x, y) = (1, 2)

//: Arithmetic

let addition = a + b
let subtraction = a - b
let multiplication = a * b
let division = a / b
let remainder = a % b
let concatenation = "hello " + "world"

//: Increment and Decrement

b = 10
a = ++b
a = b++
a = --b
a = b--
a = b

//: Unary Minus

a = -b

//: Compound Assignment

a = 0
a += b
a -= b
a = 5
a *= b
a /= b

//: Binary Comparison

if a == b {
    result = "equal"
} else if a > b {
    result = "greater"
} else if a <= b {
    result = "less or equal"
} else {
    result = "something is wrong!"
}

print(result)

//: Logical NOT

if a != 10 {
    result = "a is not 10"
} else {
    result = "a is 10"
}
print(result)

var check = false

if !check {
    result = "check is false"
} else {
    result = "check is true"
}
print(result)

//: Logical AND

if a >= 5 && b <= 10 {
    print("a >= 5 AND b <= 10")
}

//: Logical OR

if a == 5 || b == 10 {
    print("a == 5 OR b == 10")
}

//: Compound

if (a != 10 || b == 5) && !check {
    print("Complex comparison")
}

//: Ternary Conditional

var isTrue = true
a = (isTrue ? 10 : 20)
isTrue = false
a = (isTrue ? 10 : 20)

//: Switch
//: "break" is not really needed, only if you want to break in the middle of the block

var letter = "a"

switch letter {
case "b":
    result = "letter = b"
case "a":
    result = "letter = a"
    if letter == "a" {
        break
    }
    result = "never shown"
default:
    result = "not expected"
}
print(result)

//: Switch With Interval Matching

var number = 42

switch number {
case 0:
    result = "it is zero"
case 1..<50:
    result = "less then 50%"
case 50:
    result = "it is 50%"
case 51..<100:
    result = "greater than 50%"
case 100:
    result = "it is 100%"
default:
    result = "other values"
}

print(result)

//: Switch With Tuples

let somePoint = (1, 1)

switch somePoint {
case (0, 0):
    result = "(0, 0) is at the origin"
case (_, 0):
    result = "(\(somePoint.0), 0) is on the x-axis"
case (0, _):
    result = "(0, \(somePoint.1)) is on the y-axis"
case (-2...2, -2...2):
    result = "(\(somePoint.0), \(somePoint.1)) is inside the box"
default:
    result = "(\(somePoint.0), \(somePoint.1)) is outside of the box"
}

print(result)

//: Switch Value Bindings

let anotherPoint = (2, 0)

switch anotherPoint {
case (let x, 0):
    result = "on the x-axis with an x value of \(x)"
case (0, let y):
    result = "on the y-axis with a y value of \(y)"
case let (x, y): // default
    result = "somewhere else at (\(x), \(y))"
}

print(result)

//: Switch Where

let yetAnotherPoint = (1, -1)

switch yetAnotherPoint {
case let (x, y) where x == y:
    result = "(\(x), \(y)) is on the line x == y"
case let (x, y) where x == -y:
    result = "(\(x), \(y)) is on the line x == -y"
case let (x, y):
    result = "(\(x), \(y)) is just some arbitrary point"
}

print(result)

//: Switch Fallthrough

a = 1

switch a {
case 1:
    result = "a == 1"
    fallthrough
case 2:
    result = "a == 2?"
case 3:
    result = "a == 3?"
default:
    result = "another number"
}

print(result)

//: Checking API Availability

if #available(iOS 9, OSX 10.10, *) {
    result = "Use iOS 9 APIs on iOS, and use OS X v10.10 APIs on OS X"
} else {
    result = "Fall back to earlier iOS and OS X APIs"
}

print(result)

//: [Next](@next)
