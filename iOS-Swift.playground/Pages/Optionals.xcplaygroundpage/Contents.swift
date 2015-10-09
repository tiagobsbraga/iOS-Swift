//: ## Optionals
//: ----
//: [Previous](@previous)

import Foundation
var result = ""

//: Declaration

var code: Int?

//: Unwrapping

code = 10
var num: Int = code!

//: Can set nil

code = nil

//: Testing

if code != nil {
    result = "Not nil"
}
if code == nil {
    result = "Is nil"
}

print(result)

num = (code != nil ? code! : 20)
code = 10
num = (code != nil ? code! : 20)

//: Optional Binding

code = nil
if let newCode = code {
    result = "newCode exists, let's do something!"
} else {
    result = "newCode does not exists"
}
print(result)

code = 10
if let newCode = code {
    result = "newCode exists, let's do something!"
} else {
    result = "newCode does not exists"
}
print(result)

//: [Next](@next)
