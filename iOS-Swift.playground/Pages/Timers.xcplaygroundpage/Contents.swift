//: ## Timers
//: ----
//: [Previous](@previous)

import Foundation

class CustomClass {
    
    var count = 0
    
    func handleTimer() {
        print("timer ticked!")
    }
    
    func handleTimerWithRepetition(timer: NSTimer) {
        print("timer ticked!")
        if timer.valid {
            if ++count >= 3 {
                timer.invalidate() // Stops the Timer
            }
        }
    }
}

let customClass = CustomClass()

//: Scheduled Timer on the current NSRunLoop

let scheduledTimer = NSTimer.scheduledTimerWithTimeInterval(1.0,
    target: customClass,
    selector: "handleTimer",
    userInfo: "any data",
    repeats: false
)

//: Scheduled Timer With Repetition

let scheduledTimerWithRepetition = NSTimer.scheduledTimerWithTimeInterval(1.0,
    target: customClass,
    selector: "handleTimerWithRepetition:",
    userInfo: nil,
    repeats: true
)

//: Scheduling Timers Manually

let selfScheduledTimer = NSTimer(timeInterval: 1.0,
    target: customClass,
    selector: "handleTimer",
    userInfo: nil,
    repeats: false
)
NSRunLoop.currentRunLoop().addTimer(selfScheduledTimer, forMode: NSDefaultRunLoopMode)

//: Scheduling Timers Manually With Fire Date

let fireDate = NSDate(timeIntervalSinceNow: 3.0)
let selfScheduledTimerWithFireDate = NSTimer(fireDate: fireDate,
    interval: 1.0,
    target: customClass,
    selector: "handleTimer",
    userInfo: nil,
    repeats: false
)
NSRunLoop.currentRunLoop().addTimer(selfScheduledTimerWithFireDate, forMode: NSDefaultRunLoopMode)

//: Firing Timers Manually

let timerToFire = NSTimer(timeInterval: 3.0, target: customClass, selector: "handleTimer", userInfo: nil, repeats: true)
func fireTimer() {
    timerToFire.fire() // auto invalidate timer if it is a non-repeating timer
    timerToFire.fire()
    timerToFire.fire()
}

//: [Next](@next)
