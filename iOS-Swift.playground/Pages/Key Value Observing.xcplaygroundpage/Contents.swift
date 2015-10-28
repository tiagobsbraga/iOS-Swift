//: ## Key Value Observing
//: ----
//: [Previous](@previous)

import Foundation

//: Contexts

private var PersonNameObserverContext = 0
private var PersonAgeObserverContext = 0

//: Observable Properties

class Person: NSObject {
    
    dynamic var name: String
    dynamic var age: Int
    
    init(withName name: String, age: Int) {
        self.name = name
        self.age = age
    }
}

//: Handle observing

class People: NSObject {
    
    let manager: Person
    
    init(withManager manager: Person) {
        self.manager = manager
        super.init()
        
        self.manager.addObserver(self, forKeyPath: "name", options: [.New, .Old], context: &PersonNameObserverContext)
        self.manager.addObserver(self, forKeyPath: "age", options: [.New, .Old], context: &PersonAgeObserverContext)
    }
    
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        
        switch(context) {
        case &PersonNameObserverContext:
            let oldName = change!["old"]!
            let newName = change!["new"]!
            print("Manager name was \(oldName) and now is \(newName)")
        case &PersonAgeObserverContext:
            let oldAge = change!["old"]!
            let newAge = change!["new"]!
            print("Manager age was \(oldAge) and now is \(newAge)")
        default:
            print("Unhandled KVO: \(keyPath)")
        }
    }
    
    deinit {
        self.manager.removeObserver(self, forKeyPath: "name")
        self.manager.removeObserver(self, forKeyPath: "age")
    }
}

let manager = Person(withName: "John", age: 40)
let team = People(withManager: manager)
manager.name = "Jack"
manager.age = 45

//: [Next](@next)
