//: ## Predicates
//: ----
//: [Previous](@previous)

import Foundation

class Country: NSObject {
    var name: String
    init(name: String) {
        self.name = name
    }
}

class Manufacturer: NSObject {
    var name: String
    var country: Country
    init(name: String, country: Country) {
        self.name = name
        self.country = country
    }
}

class Car: NSObject {
    var name: String
    var manufacturer: Manufacturer
    var price: Float
    init(name: String, manufacturer: Manufacturer, price: Float) {
        self.name = name
        self.manufacturer = manufacturer
        self.price = price
    }
}

let usa = Country(name: "United States of America")
let germany = Country(name: "Germany")

let ford = Manufacturer(name: "Ford", country: usa)
let volkswagen = Manufacturer(name: "Volkswagen", country: germany)
let porsche = Manufacturer(name: "Porsche", country: germany)

let fiesta = Car(name: "Fiesta", manufacturer: ford, price: 15000)
let mustang = Car(name: "Mustang", manufacturer: ford, price: 25000)
let golf = Car(name: "Golf", manufacturer: volkswagen, price: 25000)
let touareg = Car(name: "Touareg", manufacturer: volkswagen, price: 45000)
let boxster = Car(name: "Boxster", manufacturer: porsche, price: 55000)
let panamera = Car(name: "Panamera", manufacturer: porsche, price: 75000)

let cars: NSArray = [fiesta, mustang, golf, touareg, boxster, panamera]

//: Equal

let usaPredicate = NSPredicate(format: "manufacturer.country = %@", usa)
let carsFromUsa = cars.filteredArrayUsingPredicate(usaPredicate)

let germanyPredicate = NSPredicate(format: "manufacturer.country.name = %@", germany.name)
let carsFromGermany = cars.filteredArrayUsingPredicate(germanyPredicate)

//: Not

let anyCarsNotFromGermanyPredicate = NSPredicate(format: "NOT manufacturer.country.name = %@", germany.name)
let anyCarsNotFromGermany = cars.filteredArrayUsingPredicate(anyCarsNotFromGermanyPredicate)

//: Less

let cheapCarsPredicate = NSPredicate(format: "price < 20000")
let cheapCars = cars.filteredArrayUsingPredicate(cheapCarsPredicate)

//: Variables Substitution

let expensiveCarsPredicate = NSPredicate(format: "price >= $expensivePrice")
let expensiveCars = cars.filteredArrayUsingPredicate(expensiveCarsPredicate.predicateWithSubstitutionVariables(["expensivePrice" : 45000]))

//: Between

let goodPriceCarsPredicate = NSPredicate(format: "price BETWEEN { 0, 30000 }")
let goodPriceCars = cars.filteredArrayUsingPredicate(goodPriceCarsPredicate)

//: Compound Predicates

// AND/OR
let goodPriceCarsFromGermanyPredicate = NSPredicate(format: "price BETWEEN { 0, 30000 } AND manufacturer.country = %@", germany)
let goodPriceCarsFromGermany = cars.filteredArrayUsingPredicate(goodPriceCarsFromGermanyPredicate)

// NSCompoundPredicate
let cheapCarsFromUsaPredicate = NSCompoundPredicate(type: .AndPredicateType, subpredicates: [usaPredicate, cheapCarsPredicate])
let cheapCarsFromUsa = cars.filteredArrayUsingPredicate(cheapCarsFromUsaPredicate)

//: String BEGINSWITH

// "name BEGINSWITH 'bó'" is case sensitive and without a glyph
// "name BEGINSWITH[c] 'bó'" is not case sensitive and without a glyph
// "name BEGINSWITH[cd] 'bó'" is not case sensitive and can have glyphs

let carsThatBeginsWithLetterBPredicate = NSPredicate(format: "name BEGINSWITH[cd] 'bó'")
let carsThatBeginsWithLetterB = cars.filteredArrayUsingPredicate(carsThatBeginsWithLetterBPredicate)

//: String CONTAINS

let carsWithLetterRPredicate = NSPredicate(format: "name CONTAINS[cd] 'r'")
let carsWithLetterR = cars.filteredArrayUsingPredicate(carsWithLetterRPredicate)

//: String ENDSWITH

let carsThatEndsWithLetterAPredicate = NSPredicate(format: "name ENDSWITH[cd] 'a'")
let carsThatEndsWithLetterA = cars.filteredArrayUsingPredicate(carsThatEndsWithLetterAPredicate)

//: String LIKE

let carsWithSTLettersPredicate = NSPredicate(format: "name LIKE[cd] 'M?ST*G'")
let carsWithSTLetters = cars.filteredArrayUsingPredicate(carsWithSTLettersPredicate)

//: String MATCHES

// ICU v3 Regular Expressions: http://userguide.icu-project.org/strings/regexp
let images: NSArray = ["top.png", "sprite001.png", "sprite002.png", "sprite003.png", "background.png"]
let spriteImagesPredicate = NSPredicate(format: "SELF MATCHES %@", "sprite\\d{3}.png") // has 3 numbers in the middle
let spriteImages = images.filteredArrayUsingPredicate(spriteImagesPredicate)

//: IN

let carsInListPredicate = NSPredicate(format: "name IN {'Golf','Boxster','Fiesta'}")
let carsInList = cars.filteredArrayUsingPredicate(carsInListPredicate)

//: Block Predicate

// Cannot be used for Core Data fetch requests backed by a SQLite store
let carsWithShortNamePredicate = NSPredicate { (car, _) -> Bool in
    return car.name.characters.count <= 4
}
let carsWithShortName = cars.filteredArrayUsingPredicate(carsWithShortNamePredicate)

//: [Next](@next)
