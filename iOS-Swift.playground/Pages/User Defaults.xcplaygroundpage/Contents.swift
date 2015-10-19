//: ## User Defaults
//: ----
//: [Previous](@previous)

import Foundation

//: Shared Instance

let userDefaults = NSUserDefaults.standardUserDefaults()

//: Bool Values

userDefaults.setBool(true, forKey: "boolValue")
let boolValue = userDefaults.boolForKey("boolValue")

//: Integer Values

userDefaults.setInteger(16, forKey: "integerValue")
let integerValue = userDefaults.integerForKey("integerValue")

//: Float Values

userDefaults.setFloat(3.14, forKey: "floatValue")
let floatValue = userDefaults.floatForKey("floatValue")

//: Double Values

userDefaults.setDouble(24.45, forKey: "doubleValue")
let doubleValue = userDefaults.doubleForKey("doubleValue")

//: String Value

userDefaults.setObject("string object", forKey: "stringValue")
let stringValue = userDefaults.valueForKey("stringValue")

//: Array Value

userDefaults.setObject(["First","Second"], forKey: "arrayValue")
let arrayValue = userDefaults.arrayForKey("arrayValue")

//: Dictionary Value

userDefaults.setObject(["1st":"First", "2nd":"Second"], forKey: "dictionaryValue")
let dictionaryValue = userDefaults.dictionaryForKey("dictionaryValue")

//: Data Value

userDefaults.setObject(stringValue?.dataUsingEncoding(NSUTF8StringEncoding), forKey: "dataValue")
let dataValue = userDefaults.dataForKey("dataValue")

//: URL Value

userDefaults.setURL(NSURL(string: "https://github.com/ricardorauber"), forKey: "urlValue")
let urlValue = userDefaults.URLForKey("urlValue")

//: Removing Defaults

userDefaults.removeObjectForKey("urlValue")

//: Synchronyze for Persistence

userDefaults.synchronize()

//: Notifications

class NotificationListener: NSObject {
    func handleDidChangeNotification(notification:NSNotification) {
        print("did change notification received: \(notification)")
    }
}

let delegate = NotificationListener()
NSNotificationCenter.defaultCenter().addObserver(delegate, selector: "handleDidChangeNotification:", name: NSUserDefaultsDidChangeNotification, object: nil)

//: [Next](@next)
