//: ## Core Data
//: ----
//: [Previous](@previous)

import Foundation
import CoreData

//: Entities

var countryEntity = NSEntityDescription()
countryEntity.name = "Country"

var manufacturerEntity = NSEntityDescription()
manufacturerEntity.name = "Manufacturer"

var carEntity = NSEntityDescription()
carEntity.name = "Car"

//: Attributes

func newAttribute(name: String, type: NSAttributeType) -> NSAttributeDescription {
    let attribute = NSAttributeDescription()
    attribute.name = name
    attribute.attributeType = type
    attribute.optional = false
    attribute.indexed = false
    return attribute
}

let countryNameAttribute = newAttribute("name", type: NSAttributeType.StringAttributeType)
let manufacturerNameAttribute = newAttribute("name", type: NSAttributeType.StringAttributeType)
let carNameAttribute = newAttribute("name", type: NSAttributeType.StringAttributeType)
let carPriceAttribute = newAttribute("price", type: NSAttributeType.FloatAttributeType)

//: Relationships

func newRelationship(name: String, toEntity: NSEntityDescription, toMany: Bool, deleteCascade: Bool) -> NSRelationshipDescription {
    let relationship = NSRelationshipDescription()
    relationship.name = name
    relationship.destinationEntity = toEntity
    relationship.minCount = 0
    if toMany {
        relationship.maxCount = 0
    } else {
        relationship.maxCount = 1
    }
    if deleteCascade {
        relationship.deleteRule = NSDeleteRule.CascadeDeleteRule
    } else {
        relationship.deleteRule = NSDeleteRule.NullifyDeleteRule
    }
    return relationship
}

let countryRelationshipToManufacturer = newRelationship("manufacturers", toEntity: manufacturerEntity, toMany: true, deleteCascade: true)
let manufacturerRelationshipToCountry = newRelationship("country", toEntity: countryEntity, toMany: false, deleteCascade: false)
countryRelationshipToManufacturer.inverseRelationship = manufacturerRelationshipToCountry
manufacturerRelationshipToCountry.inverseRelationship = countryRelationshipToManufacturer

let manufacturerRelationshipToCar = newRelationship("cars", toEntity: carEntity, toMany: true, deleteCascade: true)
let carRelationshipToManufacturer = newRelationship("manufacturer", toEntity: manufacturerEntity, toMany: false, deleteCascade: false)
manufacturerRelationshipToCar.inverseRelationship = carRelationshipToManufacturer
carRelationshipToManufacturer.inverseRelationship = manufacturerRelationshipToCar

//: Entities Properties

countryEntity.properties = [countryNameAttribute, countryRelationshipToManufacturer]
manufacturerEntity.properties = [manufacturerNameAttribute, manufacturerRelationshipToCountry, manufacturerRelationshipToCar]
carEntity.properties = [carNameAttribute, carPriceAttribute, carRelationshipToManufacturer]

//: Managed Object Model

var model = NSManagedObjectModel()
model.entities = [countryEntity, manufacturerEntity, carEntity]

//: Persistent Store Coordinator

let persistentStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel:model)

do {
    try persistentStoreCoordinator.addPersistentStoreWithType(NSInMemoryStoreType, configuration: nil, URL: nil, options: nil)
}
catch {
    print("error creating persistent store coordinator: \(error)")
}

//: Managed Object Context

var managedObjectContext = NSManagedObjectContext(concurrencyType: NSManagedObjectContextConcurrencyType.MainQueueConcurrencyType)
managedObjectContext.persistentStoreCoordinator = persistentStoreCoordinator

//: Child Managed Object Context for Multithreading

var childManagedObjectContext = NSManagedObjectContext(concurrencyType: NSManagedObjectContextConcurrencyType.MainQueueConcurrencyType)
childManagedObjectContext.parentContext = managedObjectContext

//: Managed Objects

func newCountry(name: String) -> NSManagedObject {
    let country = NSEntityDescription.insertNewObjectForEntityForName(countryEntity.name!, inManagedObjectContext: managedObjectContext)
    country.setValue(name, forKey: countryNameAttribute.name)
    return country
}

func newManufacturer(name: String, country: NSManagedObject) -> NSManagedObject {
    let manufacturer = NSManagedObject(entity: manufacturerEntity, insertIntoManagedObjectContext: managedObjectContext)
    manufacturer.setValue(name, forKey: manufacturerNameAttribute.name)
    manufacturer.setValue(country, forKey: manufacturerRelationshipToCountry.name)
    return manufacturer
}

func newCar(name: String, manufacturer: NSManagedObject, price: Float) -> NSManagedObject {
    let car = NSManagedObject(entity: carEntity, insertIntoManagedObjectContext: managedObjectContext)
    car.setValue(name, forKey: carNameAttribute.name)
    car.setValue(price, forKey: carPriceAttribute.name)
    car.setValue(manufacturer, forKey: carRelationshipToManufacturer.name)
    return car
}

let usa = newCountry("United States of America")
let germany = newCountry("Germany")

let ford = newManufacturer("Ford", country: usa)
let volkswagen = newManufacturer("Volkswagen", country: germany)
let porsche = newManufacturer("Porsche", country: germany)

let fiesta = newCar("Fiesta", manufacturer: ford, price: 15000)
let mustang = newCar("Mustang", manufacturer: ford, price: 25000)
let golf = newCar("Golf", manufacturer: volkswagen, price: 25000)
let touareg = newCar("Touareg", manufacturer: volkswagen, price: 45000)
let boxster = newCar("Boxster", manufacturer: porsche, price: 55000)
let panamera = newCar("Panamera", manufacturer: porsche, price: 75000)

//: Notification When Did Save

class NotificationListener: NSObject {
    func handleDidObjectsDidChangeNotification(notification:NSNotification) {
        print("objects did change notification received: \(notification)")
    }
    func handleWillSaveNotification(notification:NSNotification) {
        print("will save notification received: \(notification)")
    }
    func handleDidSaveNotification(notification:NSNotification) {
        print("did save notification received: \(notification)")
    }
}

let delegate = NotificationListener()
NSNotificationCenter.defaultCenter().addObserver(delegate, selector: "handleDidObjectsDidChangeNotification:", name: NSManagedObjectContextObjectsDidChangeNotification, object: nil)
NSNotificationCenter.defaultCenter().addObserver(delegate, selector: "handleWillSaveNotification:", name: NSManagedObjectContextWillSaveNotification, object: nil)
NSNotificationCenter.defaultCenter().addObserver(delegate, selector: "handleDidSaveNotification:", name: NSManagedObjectContextDidSaveNotification, object: nil)

//: Saving Context

do {
    try managedObjectContext.save()
}
catch {
    print("error saving context: \(error)")
}

//: Fetch Request

var fetchRequest = NSFetchRequest(entityName: carEntity.name!)
fetchRequest.predicate = NSPredicate(format: "price > %d", 15000)
do {
    let results = try managedObjectContext.executeFetchRequest(fetchRequest) as! [NSManagedObject]
    for result in results {
        print(result.valueForKey(carNameAttribute.name))
    }
}
catch {
    print("error executing fetch request: \(error)")
}

//: Subclassing

class Country: NSManagedObject {
    @NSManaged var name: String?
    @NSManaged var manufacturers: NSSet?
}

class Manufacturer: NSManagedObject {
    @NSManaged var name: String?
    @NSManaged var cars: NSSet?
    @NSManaged var country: Country?
}

class Car: NSManagedObject {
    @NSManaged var name: String?
    @NSManaged var price: NSNumber?
    @NSManaged var manufacturer: Manufacturer?
}

//: [Next](@next)
