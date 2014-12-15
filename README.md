# Publinks!

Publinks is a simple and safe implementation of the publish-subscribe pattern in Swift.

## Examples

Publinks can be used anywhere for broadcasting a value or optional value to a set of subscribers. You can find some example `Publinks-Example.playground`. Please note that you must open the playground from within the Xcode project and build both the module and `Publinks-Example` targets for the playground.

### Explicitly unwrapped type

``` Swift
// Basic Publink with String value type
var stringPublink = Publink<String>()

// Objects can subscribe to the Publink
stringPublink.subscribe() { (name: String) in
  
    // Because the Publink was initialized with an explicit, non-optional type, there is no nil-check or casting required to access the value of the published parameter
    println("Hello, \(name)!")

}

stringPublink.publish("Ryan") // Prints "Hello, Ryan!"
```

### Using an optional type

``` Swift
// Basic Publink with String value type
var stringOptionalPublink = Publink<String?>()

// Objects can subscribe to the Publink
stringOptionalPublink.subscribe() { (name: String?) in
  
    // Because the Publink was initialized with an optional type, you must unwrap the parameter to access the value that will be published
    if let theName = name {
        println("Hello, \(name)!")
    } else {
        println("Hello, world!")
    }

}

stringOptionalPublink.publish("Matt") // Prints "Hello, Matt!"
stringOptionalPublink.publish(nil) // Prints "Hello, world!"
```
