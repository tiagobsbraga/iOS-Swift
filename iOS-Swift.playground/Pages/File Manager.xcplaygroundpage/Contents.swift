//: ## File Manager
//: ----
//: [Previous](@previous)

import Foundation

//: Bundle Directory [Read-Only] App and Resources

let bundlePath = NSBundle.mainBundle().bundlePath

//: Documents Directory [Read-Write-Delete] User Content

let documentsPath = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.AllDomainsMask, true).first!

//: Documents/Inbox Directory [Read-Delete] Files from outside entities

let inboxPath = documentsPath + "/Inbox"

//: Library Documents [Read-Write-Delete] Content not exposed to User

let libraryPath = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.LibraryDirectory, NSSearchPathDomainMask.AllDomainsMask, true).first!

//: Temporary Dicrectory [Read-Write-Delete] Files that do not need to persist between launches of your app

let tmpPath = NSTemporaryDirectory()

//: File Manager

let fileManager = NSFileManager.defaultManager()

//: Contents of a directory

let fileList = try? fileManager.contentsOfDirectoryAtPath(bundlePath) as NSArray

//: Filter by file extension

let plistFiles = fileList!.filteredArrayUsingPredicate(NSPredicate(format:"pathExtension == 'plist'"))

//: Check if directory or file exists

let dummyFile = documentsPath + "/dummy.txt"
var isDirectory: ObjCBool = false
if fileManager.fileExistsAtPath(dummyFile, isDirectory: &isDirectory) {
    if isDirectory {
        print("Directory exists!")
    } else {
        print("File exists!")
    }
} else {
    print("Directory or File does not exist!")
}

//: Creating a directory

let imagesPath = documentsPath + "/images"
if !fileManager.fileExistsAtPath(imagesPath) {
    try? fileManager.createDirectoryAtPath(imagesPath, withIntermediateDirectories: false, attributes: nil)
    
    let tempImagesPath = imagesPath + "/tmp"
    try? fileManager.createDirectoryAtPath(tempImagesPath, withIntermediateDirectories: false, attributes: nil)
}

//: Writing and Reading String Files

let textFile = documentsPath + "/text.txt"
let text = "This is a simple text file"
try? text.writeToFile(textFile, atomically: false, encoding: NSUTF8StringEncoding)
let reading = try? NSString(contentsOfFile: textFile, encoding: NSUTF8StringEncoding)

//: Deleting a File

do {
    try fileManager.removeItemAtPath(textFile)
    print("File deleted")
} catch let error as NSError {
    print("Error: \(error)")
}

//: Directory or File Attributes

let directoryAttributes = try? fileManager.attributesOfItemAtPath(documentsPath)
if directoryAttributes != nil {
    print(directoryAttributes![NSFileAppendOnly])
    print(directoryAttributes![NSFileBusy])
    print(directoryAttributes![NSFileCreationDate])
    print(directoryAttributes![NSFileOwnerAccountName])
    print(directoryAttributes![NSFileGroupOwnerAccountName])
    print(directoryAttributes![NSFileDeviceIdentifier])
    print(directoryAttributes![NSFileExtensionHidden])
    print(directoryAttributes![NSFileGroupOwnerAccountID])
    print(directoryAttributes![NSFileHFSCreatorCode])
    print(directoryAttributes![NSFileHFSTypeCode])
    print(directoryAttributes![NSFileImmutable])
    print(directoryAttributes![NSFileModificationDate])
    print(directoryAttributes![NSFileOwnerAccountID])
    print(directoryAttributes![NSFilePosixPermissions])
    print(directoryAttributes![NSFileReferenceCount])
    print(directoryAttributes![NSFileSize])
    print(directoryAttributes![NSFileSystemFileNumber])
    print(directoryAttributes![NSFileType])
}

try? text.writeToFile(textFile, atomically: false, encoding: NSUTF8StringEncoding)
let fileAttributes = try? fileManager.attributesOfItemAtPath(textFile)
if fileAttributes != nil {
    print(fileAttributes![NSFileAppendOnly])
    print(fileAttributes![NSFileBusy])
    print(fileAttributes![NSFileCreationDate])
    print(fileAttributes![NSFileOwnerAccountName])
    print(fileAttributes![NSFileGroupOwnerAccountName])
    print(fileAttributes![NSFileDeviceIdentifier])
    print(fileAttributes![NSFileExtensionHidden])
    print(fileAttributes![NSFileGroupOwnerAccountID])
    print(fileAttributes![NSFileHFSCreatorCode])
    print(fileAttributes![NSFileHFSTypeCode])
    print(fileAttributes![NSFileImmutable])
    print(fileAttributes![NSFileModificationDate])
    print(fileAttributes![NSFileOwnerAccountID])
    print(fileAttributes![NSFilePosixPermissions])
    print(fileAttributes![NSFileReferenceCount])
    print(fileAttributes![NSFileSize])
    print(fileAttributes![NSFileSystemFileNumber])
    print(fileAttributes![NSFileType])
}

//: File Manager Delegate - Use a custom File Manager

// Will try methods with URL first, if it's not implemented then will try PATH
class HandleFiles: NSObject, NSFileManagerDelegate {
    func fileManager(fileManager: NSFileManager, shouldCopyItemAtPath srcPath: String, toPath dstPath: String) -> Bool {
        return true
    }
    func fileManager(fileManager: NSFileManager, shouldCopyItemAtURL srcURL: NSURL, toURL dstURL: NSURL) -> Bool {
        return true
    }
    func fileManager(fileManager: NSFileManager, shouldLinkItemAtPath srcPath: String, toPath dstPath: String) -> Bool {
        return true
    }
    func fileManager(fileManager: NSFileManager, shouldLinkItemAtURL srcURL: NSURL, toURL dstURL: NSURL) -> Bool {
        return true
    }
    func fileManager(fileManager: NSFileManager, shouldMoveItemAtPath srcPath: String, toPath dstPath: String) -> Bool {
        return true
    }
    func fileManager(fileManager: NSFileManager, shouldMoveItemAtURL srcURL: NSURL, toURL dstURL: NSURL) -> Bool {
        return true
    }
    func fileManager(fileManager: NSFileManager, shouldProceedAfterError error: NSError, copyingItemAtPath srcPath: String, toPath dstPath: String) -> Bool {
        return true
    }
    func fileManager(fileManager: NSFileManager, shouldProceedAfterError error: NSError, copyingItemAtURL srcURL: NSURL, toURL dstURL: NSURL) -> Bool {
        return true
    }
    func fileManager(fileManager: NSFileManager, shouldProceedAfterError error: NSError, linkingItemAtPath srcPath: String, toPath dstPath: String) -> Bool {
        return true
    }
    func fileManager(fileManager: NSFileManager, shouldProceedAfterError error: NSError, linkingItemAtURL srcURL: NSURL, toURL dstURL: NSURL) -> Bool {
        return true
    }
    func fileManager(fileManager: NSFileManager, shouldProceedAfterError error: NSError, movingItemAtPath srcPath: String, toPath dstPath: String) -> Bool {
        return true
    }
    func fileManager(fileManager: NSFileManager, shouldProceedAfterError error: NSError, movingItemAtURL srcURL: NSURL, toURL dstURL: NSURL) -> Bool {
        return true
    }
    func fileManager(fileManager: NSFileManager, shouldProceedAfterError error: NSError, removingItemAtPath path: String) -> Bool {
        return true
    }
    func fileManager(fileManager: NSFileManager, shouldProceedAfterError error: NSError, removingItemAtURL URL: NSURL) -> Bool {
        return true
    }
    func fileManager(fileManager: NSFileManager, shouldRemoveItemAtPath path: String) -> Bool {
        print("will remove file: \(path)")
        return true
    }
    func fileManager(fileManager: NSFileManager, shouldRemoveItemAtURL URL: NSURL) -> Bool {
        print("will remove file: \(URL)")
        return true
    }
}

let handleFiles = HandleFiles()
let customFileManager = NSFileManager()
customFileManager.delegate = handleFiles
try customFileManager.removeItemAtPath(textFile)

//: [Next](@next)
