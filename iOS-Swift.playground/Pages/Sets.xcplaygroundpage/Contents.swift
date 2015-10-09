//: ## Sets
//: ----
//: [Previous](@previous)

import Foundation
var result = ""
//: Empty Set

var letters = Set<Character>()
var anyObject = Set<NSObject>()
letters = [] // This is ok because it was defined previously to <Character>

//: Set with an Array Literal

var favoriteGenres: Set<String> = ["Rock", "Classical", "Hip hop"]
var favoriteGenres2: Set = ["Rock", "Classical", "Hip hop"]

//: Set Count

print(favoriteGenres.count)

//: Check if it is Empty

if favoriteGenres.isEmpty {
    result = "The favorite genres set is empty."
} else {
    result = "The favorite genres set is not empty."
}
print(result)

if letters.isEmpty {
    result = "The letters set is empty."
} else {
    result = "The letters set is not empty."
}
print(result)

//: Modifying a Set

favoriteGenres.insert("Jazz")

if let removedGenre = favoriteGenres.remove("Rock") {
    result = "\(removedGenre)? I'm over it."
} else {
    result = "I never much cared for that."
}
print(result)

if favoriteGenres.contains("Funk") {
    result = "I get up on the good foot."
} else {
    result = "It's too funky in here."
}
print(result)

//: Iterating Over a Set

for genre in favoriteGenres {
    print(genre)
}

//: Sorting Sets - Returns Array

var sortFavoriteGenres = favoriteGenres.sort()
sortFavoriteGenres = favoriteGenres.sort({ (a: String, b: String) -> Bool in
    return a > b
})
print(sortFavoriteGenres)

//: Set Operations

let oddDigits: Set = [1, 3, 5, 7, 9]
let evenDigits: Set = [0, 2, 4, 6, 8]
let singleDigitPrimeNumbers: Set = [2, 3, 5, 7]
oddDigits.union(evenDigits).sort()
oddDigits.intersect(evenDigits).sort()
oddDigits.subtract(singleDigitPrimeNumbers).sort()
oddDigits.exclusiveOr(singleDigitPrimeNumbers).sort()

//: Membership and Equality

let allAnimals: Set = ["Dog", "Cat", "Cow", "Horse"]
let houseAnimals: Set = ["Dog", "Cat"]
let farmAnimals: Set = ["Cow", "Horse"]

// Is Equal
print(houseAnimals == farmAnimals)

// Is Subset Of
houseAnimals.isSubsetOf(allAnimals)
houseAnimals.isSubsetOf(houseAnimals)

// Is Superset Of
allAnimals.isSupersetOf(houseAnimals)
farmAnimals.isSupersetOf(houseAnimals)

// Is Disjoint With - does not have any values in common
let wildAnimals: Set = ["Wolf", "Bear"]
allAnimals.isDisjointWith(wildAnimals)
allAnimals.isDisjointWith(houseAnimals)

//: [Next](@next)
