//: ## Strings and Characters
//: ----
//: [Previous](@previous)

import Foundation
var result = ""

//: String Literals

var someString = "Some string literal value"

//: Empty String

var emptyString = ""
var anotherEmptyString = String()

if emptyString.isEmpty {
    result = "Nothing to see here"
} else {
    result =  emptyString
}

print(result)

//: Mutability and Concatenation

var theBook = "The book"
var theTable = "the table!"
theBook += " is on " + theTable

//: Interpolation

let multiplier = 3
let message = "\(multiplier) times 2.5 is \(Double(multiplier) * 2.5)"

//: Characters

someString = "abc123"
for character in someString.characters {
    print(character)
}

let exclamationMark: Character = "!"
someString.append(exclamationMark)

//: Counting Characters

someString.characters.count

//: Indices

let greeting = "Good Morning!"
let firstChar = greeting[greeting.startIndex]
let lastChar = greeting[greeting.endIndex.predecessor()]
let sucessorChar = greeting[greeting.startIndex.successor()]
let index = greeting.startIndex.advancedBy(7)
let indexChar = greeting[index]

for index in greeting.characters.indices {
    print(greeting[index])
}

//: Inserting and Removing

var welcome = "hello"
welcome.insert("!", atIndex: welcome.endIndex)
welcome.insertContentsOf(" there".characters, at: welcome.endIndex.predecessor())
welcome.removeAtIndex(welcome.endIndex.predecessor())
let range = welcome.endIndex.advancedBy(-6)..<welcome.endIndex
welcome.removeRange(range)

//: Comparing

let str1 = "hey"
var str2 = "hey"

if str1 == str2 {
    result = "equal strings"
} else {
    result = "different"
}

print(result)

//: Prefix and Suffix Equality

let myBook = "The incredible Story Part 1"

if myBook.hasPrefix("1 -") {
    result = "has prefix!"
} else {
    result = "does not have a prefix!"
}

print(result)

if myBook.hasSuffix("Part 1") {
    result = "has suffix!"
} else {
    result = "does not have a suffix!"
}

print(result)

//: UTF-8, UTF-16 and Scalar Representation

let 😎 = "😎"
for codeUnit in 😎.utf8 {
    print(codeUnit)
}
for codeUnit in 😎.utf16 {
    print(codeUnit)
}
for scalar in 😎.unicodeScalars {
    print(scalar.value)
}

//: [Next](@next)
