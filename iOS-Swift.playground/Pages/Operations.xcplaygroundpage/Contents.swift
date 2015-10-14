//: ## Operations
//: ----
//: [Previous](@previous)

import Foundation

//: Block Operation

let blockOperation = NSBlockOperation(block: { () -> Void in
    print("Block Operation!")
})
blockOperation.name = "blockOperation"

//: Priority and Quality of Service

blockOperation.queuePriority = .VeryLow
blockOperation.qualityOfService = .Background

//: Custom Operation

class CustomOperation: NSOperation {
    override func main() {
        print("Custom Operation!")
        
        if self.asynchronous {
            print("This operation is asynchronous!")
        } else {
            print("This operations is not asynchronous!")
        }
        
        if self.ready {
            print("Ready to go!")
        }
    
        if self.executing {
            print("Executing!")
        }
        
        if self.cancelled {
            print("Cancelled :(")
            return
        }
        
        if self.finished {
            print("Finished!")
        }
        
        print("doing something...")
    }
}
let customOperation = CustomOperation()
customOperation.name = "customOperation"
customOperation.completionBlock = {
    print("completion block!")
}
customOperation.queuePriority = .Low

//: Main and Current Queue

let mainQueue = NSOperationQueue.mainQueue()
let currentQueue = NSOperationQueue.currentQueue()

//: Operation Queue

let operationQueue = NSOperationQueue()
operationQueue.name = "General tasks"
operationQueue.maxConcurrentOperationCount = 1
operationQueue.addOperations([blockOperation,customOperation], waitUntilFinished: true)

//: Cancelling Operations

let secondOperationQueue = NSOperationQueue()
secondOperationQueue.addOperation(CustomOperation())
secondOperationQueue.cancelAllOperations()

//: Dependencies

let firstOperation = NSBlockOperation { () -> Void in
    print("first?")
}
let secondOperation = NSBlockOperation { () -> Void in
    print("second?")
}
firstOperation.addDependency(secondOperation)
let thirdOperationQueue = NSOperationQueue()
thirdOperationQueue.addOperations([firstOperation, secondOperation], waitUntilFinished: false)

//: [Next](@next)
