//: ## Grand Central Dispatch
//: ----
//: [Previous](@previous)

import Foundation

//: Global Concurrent Dispatch Queues

let globalQueueDefault: dispatch_queue_t = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
let globalQueueLow = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0)
let globalQueueHigh = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0)
let globalQueueBackground = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0)

//: Getting Main Queue at Runtime

let mainQueue = dispatch_get_main_queue()

//: Creating Serial Dispatch Queues

let serialQueue = dispatch_queue_create("com.ricardorauber.MyQueue", nil)

//: Synchronous Task

dispatch_sync(serialQueue) { () -> Void in
    print("Synchronous task!")
}

//: Asynchronous Task

dispatch_async(serialQueue) { () -> Void in
    print("Asynchronous Task!")
}

//: Barrier Synchronous Task

// Use it only on custom queues
dispatch_barrier_sync(serialQueue) { () -> Void in
    print("Barrier Synchronous Task")
}

//: Barrier Asynchronous Task

// Use it only on custom queues
dispatch_barrier_async(serialQueue) { () -> Void in
    print("Barrier Asynchronous Task")
}

//: Getting back to the main queue

dispatch_async(serialQueue) { () -> Void in
    print("Async")
    dispatch_async(mainQueue, { () -> Void in
        print("Back to main queue!")
    })
}

//: Suspending and Resuming Queues

dispatch_suspend(serialQueue)
dispatch_resume(serialQueue)

//: Dispatch at the specified time

let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(5 * Double(NSEC_PER_SEC)))
dispatch_after(delayTime, mainQueue) { () -> Void in
    print("after some time")
}

//: Dispatch queue for multiple invocations

dispatch_apply(5, serialQueue) { (count) -> Void in
    print("Apply count: \(count)")
}

//: Dispatch once and only once for the lifetime of an application

var once: dispatch_once_t = 0
func showInfo() {
    dispatch_once(&once) { () -> Void in
        print("will run only once in the app's lifetime!")
    }
    print("will run everytime!")
}
showInfo()
showInfo()

//: Using Dispatch Semaphores to Regulate the Use of Finite Resources

let semaphore: dispatch_semaphore_t = dispatch_semaphore_create(0)
dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER)
print("do something")
dispatch_semaphore_signal(semaphore)

//: Waiting on Groups of Queued Tasks

let group = dispatch_group_create()
dispatch_group_async(group, globalQueueDefault) { () -> Void in
    print("do something")
}
dispatch_group_wait(group, DISPATCH_TIME_FOREVER)

//: [Next](@next)
