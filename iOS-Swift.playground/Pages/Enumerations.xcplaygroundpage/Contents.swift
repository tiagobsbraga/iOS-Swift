//: ## Enumerations
//: ----
//: [Previous](@previous)

import Foundation
var result = ""

//: Enumeration Syntax

enum CompassPoint {
    case North
    case South
    case East
    case West
}

enum Planet {
    case Mercury, Venus, Earth, Mars, Jupiter, Saturn, Uranus, Neptune
}

var directionToHead = CompassPoint.West
directionToHead = .East

//: Matching Enumeration Values with a Switch Statement

directionToHead = .South

switch directionToHead {
case .North:
    result = "Lots of planets have a north"
case .South:
    result = "Watch out for penguins"
case .East:
    result = "Where the sun rises"
case .West:
    result = "Where the skies are blue"
}
print(result)

//: Associated Values

enum ProfileType {
    case Simple(String)
    case Complete(String, Int)
}

var userProfile = ProfileType.Simple("John")
userProfile = .Complete("John", 30)

switch userProfile {
case let .Simple(name):
    result = "Simple: \(name)"
case .Complete(let name, let age):
    result = "Complete: \(name) = \(age)"
}
print(result)

//: Raw Values

enum Taxes: Int {
    case PerMonth = 12
    case PerYear = 1
}

var defaultTax = Taxes.PerYear
defaultTax = .PerMonth

print(10 * defaultTax.rawValue)

//: Implicitly Assigned Raw Values

enum Position: Int {
    case First = 1, Second, Third
}

let pilotPosition = Position.Second.rawValue

enum Names: String {
    case John, Mark, Jack
}

let pilotName = Names.Mark.rawValue

//: Initializing from a Raw Value

let possiblePosition = Position(rawValue: 3)

//: Recursive Enumerations

enum ArithmeticExpression {
    case Number(Int)
    indirect case Addition(ArithmeticExpression, ArithmeticExpression)
    indirect case Multiplication(ArithmeticExpression, ArithmeticExpression)
}

func evaluate(expression: ArithmeticExpression) -> Int {
    switch expression {
    case .Number(let value):
        return value
    case .Addition(let left, let right):
        return evaluate(left) + evaluate(right)
    case .Multiplication(let left, let right):
        return evaluate(left) * evaluate(right)
    }
}

// evaluate (5 + 4) * 2
let five = ArithmeticExpression.Number(5)
let four = ArithmeticExpression.Number(4)
let sum = ArithmeticExpression.Addition(five, four)
let product = ArithmeticExpression.Multiplication(sum, ArithmeticExpression.Number(2))
print(evaluate(product))

//: If Case (Enumeration Case Pattern)

enum AgeInput {
    case Integer(Int)
    case Text(String)
}

let ageInteger: AgeInput = .Integer(20)
if case .Integer(let age) = ageInteger {
    print("Age is the integer: \(age)")
}

let ageString: AgeInput = .Text("Ten")
if case .Text(let age) = ageString {
    print("Age is the string: \(age)")
}

let ages: [AgeInput] = [ageString, ageInteger]

for ageInput in ages {
    switch ageInput {
    case .Integer(let age):
        print("Age is the integer: \(age)")
    case .Text(let age):
        print("Age is the string: \(age)")
    }
}


//: [Next](@next)
