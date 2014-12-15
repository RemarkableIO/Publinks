// Playground - noun: a place where people can play

import Publinks


// Declare a publink with value type
var stringPublink = Publink<String>()

stringPublink.subscribe({ (name: String) in

    println("Hello, \(name)!")

})

stringPublink.publish("Ryan")


// Declare a publink with optional type
var stringOptionalPublink = Publink<String?>()

stringOptionalPublink.subscribe({ (name: String?) in

    // Publinks with optional type require nil check
    if let name = name {
        println("Hello, \(name)!")
    } else {
        println("Hello, world!")
    }

})

// Publish nil value or empty optional
stringOptionalPublink.publish(nil)
stringOptionalPublink.publish(Optional<String>())

stringOptionalPublink.publish("Alex")
