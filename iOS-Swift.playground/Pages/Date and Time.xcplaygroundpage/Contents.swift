//: ## Date and Time
//: ----
//: [Previous](@previous)

import Foundation

//: Creating Date Objects

let now = NSDate()
let secondsPerDay: NSTimeInterval = 24 * 60 * 60
let tomorrow = NSDate(timeIntervalSinceNow: secondsPerDay)
let yesterday = NSDate(timeIntervalSinceNow: -secondsPerDay)
let afterTomorrow = tomorrow.dateByAddingTimeInterval(secondsPerDay)
let beforeYesterday = NSDate(timeInterval: -secondsPerDay, sinceDate: yesterday)
let aDaySince1970 = NSDate(timeIntervalSince1970: secondsPerDay)
let aDaySince2001 = NSDate(timeIntervalSinceReferenceDate: secondsPerDay)

//: Test Equal Dates

let anotherDaySince1970 = NSDate(timeIntervalSince1970: secondsPerDay)
if aDaySince1970.isEqualToDate(anotherDaySince1970) {
    print("equal dates!")
} else {
    print("not the same")
}

let a = NSDate()
let b = NSDate()
if a.isEqualToDate(b) {
    print("equal dates!")
} else {
    print("not the same")
}

//: Test Earlier Date

let earlierDate = yesterday.earlierDate(now)
if earlierDate.isEqualToDate(yesterday) {
    print("the earlier is yesterday")
} else {
    print("the earlier is now")
}

//: Test Later Date

let laterDate = yesterday.laterDate(now)
if laterDate.isEqualToDate(yesterday) {
    print("the later is yesterday")
} else {
    print("the later is now")
}

//: Test if the difference is less than 60 seconds

if abs(tomorrow.timeIntervalSinceDate(now)) < 60 {
    print("difference is less than 1 minute")
} else {
    print("difference is equal or greater than 1 minute")
}

//: Calendar Basics

let currentCalendar = NSCalendar.currentCalendar()
let japaneseCalendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierJapanese) // There are a lot more

//: Create a Date from Components

let components = NSDateComponents()
components.day = 3
components.month = 12
components.year = 1985
let someDate = currentCalendar.dateFromComponents(components)

//: Extracting Components from Date

let gregorian = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)
let flags: NSCalendarUnit = [.Day, .Weekday]
let weekdayComponents = gregorian?.components(flags, fromDate: now)
let day = weekdayComponents?.day
let weekDay = weekdayComponents?.weekday
let month = weekdayComponents?.month // Have to add .Month in flags

//: Converting from One Calendar to Another

let hebrew = NSCalendar(calendarIdentifier: NSCalendarIdentifierHebrew)
let unitFlags: NSCalendarUnit = [.Day, .Month, .Year]
let dateComponents = hebrew?.components(unitFlags, fromDate: someDate!)
let hebrewDay = dateComponents?.day
let hebrewMonth = dateComponents?.month
let hebrewYear = dateComponents?.year

//: Adding Components to a Date

let offsetComponents = NSDateComponents()
offsetComponents.hour = 1
offsetComponents.minute = 30
let date1h30mAhead = gregorian?.dateByAddingComponents(offsetComponents, toDate: now, options: [])

//: Getting the difference between two dates

let differenceComponents = gregorian?.components([.Day, .Month, .Year], fromDate: now, toDate: tomorrow, options: [])
let diffDay = differenceComponents?.day
let diffMonth = differenceComponents?.month
let diffYear = differenceComponents?.year

//: Creating Time Zones

let timeZoneNames = NSTimeZone.knownTimeZoneNames()

//: Changing Time Zone

gregorian?.timeZone = NSTimeZone(abbreviation: "GMT")!

//: Daylight Saving Time

let brtTimeZone = NSTimeZone(abbreviation: "BRT")!
if brtTimeZone.isDaylightSavingTimeForDate(now) {
    print("its daylight saving time!")
} else {
    print("its not daylight saving time!")
}

//: Date Formatter

let dateFormatter = NSDateFormatter()
dateFormatter.dateFormat = "dd-MM-yyyy'T'HH:mm:ss"
let todayString = dateFormatter.stringFromDate(now)
let oneMoreDate = dateFormatter.dateFromString("31-12-2015T23:59:59")

//: [Next](@next)
