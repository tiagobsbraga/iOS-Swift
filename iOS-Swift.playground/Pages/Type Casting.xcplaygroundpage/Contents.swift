//: ## Type Casting
//: ----
//: [Previous](@previous)

import Foundation
var result = ""

//: Defining a Class Hierarchy for Type Casting

class MediaItem {
    var name: String
    init(name: String) {
        self.name = name
    }
}

class Movie: MediaItem {
    var director: String
    init(name: String, director: String) {
        self.director = director
        super.init(name: name)
    }
}

class Song: MediaItem {
    var artist: String
    init(name: String, artist: String) {
        self.artist = artist
        super.init(name: name)
    }
}

let library = [
    Movie(name: "Casablanca", director: "Michael Curtiz"),
    Song(name: "Blue Suede Shoes", artist: "Elvis Presley"),
    Movie(name: "Citizen Kane", director: "Orson Welles"),
    Song(name: "The One And Only", artist: "Chesney Hawkes"),
    Song(name: "Never Gonna Give You Up", artist: "Rick Astley")
]
print(library)

//: Checking Type

var movieCount = 0
var songCount = 0

for item in library {
    if item is Movie {
        ++movieCount
    } else if item is Song {
        ++songCount
    }
}

print("Media library contains \(movieCount) movies and \(songCount) songs")

//: Downcasting

for item in library {
    if let movie = item as? Movie {
        result = "Movie: '\(movie.name)', dir. \(movie.director)"
    } else if let song = item as? Song {
        result = "Song: '\(song.name)', by \(song.artist)"
    } else {
        result = "Another class"
    }
    print(result)
}

//: Type Casting for AnyObject

let someObjects: [AnyObject] = [
    Movie(name: "2001: A Space Odyssey", director: "Stanley Kubrick"),
    Movie(name: "Moon", director: "Duncan Jones"),
    Movie(name: "Alien", director: "Ridley Scott")
]
print(someObjects)

for object in someObjects {
    let movie = object as! Movie
    print("Movie: '\(movie.name)', dir. \(movie.director)")
}

for movie in someObjects as! [Movie] {
    print("Movie: '\(movie.name)', dir. \(movie.director)")
}

//: Type Casting for Any

var things = [Any]()

things.append(0)
things.append(0.0)
things.append(42)
things.append(3.14159)
things.append("hello")
things.append((3.0, 5.0))
things.append(Movie(name: "Ghostbusters", director: "Ivan Reitman"))
things.append({ (name: String) -> String in "Hello, \(name)" })

print(things)

for thing in things {
    switch thing {
    case 0 as Int:
        result = "zero as an Int"
    case 0 as Double:
        result = "zero as a Double"
    case let someInt as Int:
        result = "an integer value of \(someInt)"
    case let someDouble as Double where someDouble > 0:
        result = "a positive double value of \(someDouble)"
    case is Double:
        result = "some other double value that I don't want to print"
    case let someString as String:
        result = "a string value of \"\(someString)\""
    case let (x, y) as (Double, Double):
        result = "an (x, y) point at \(x), \(y)"
    case let movie as Movie:
        result = "a movie called '\(movie.name)', dir. \(movie.director)"
    case let stringConverter as String -> String:
        result = stringConverter("Michael")
    default:
        result = "something else"
    }
    print(result)
}

//: [Next](@next)
