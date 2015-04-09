// Playground - noun: a place where people can play

import Publinks

// MARK: Publink with String value type
var stringPublink = Publink<String>()

stringPublink.subscribe() { (name: String) in

    println("Hello, \(name)!")

}

stringPublink.publish("Ryan")


// MARK: Publink with optional String value type
var stringOptionalPublink = Publink<String?>()

stringOptionalPublink.subscribe() { (name: String?) in

    // Publinks with optional type require nil check
    if let name = name {
        println("Hello, \(name)!")
    } else {
        println("Hello, world!")
    }

}

// Publish nil value or empty optional
stringOptionalPublink.publish(nil)
stringOptionalPublink.publish(Optional<String>())

stringOptionalPublink.publish("Alex")


// MARK: Publink with named subscriptions
var anotherStringPublink = Publink<String>()

anotherStringPublink.subscribeNamed("some-identifier") { (name: String) in

    println("Hello, \(name)!")

}

// The following is immediately published to one subscriber
anotherStringPublink.publish("Matt")

// The following unsubscribes the subscriber with "some-identifier"
anotherStringPublink.unsubscribe("some-identifier")

// The following is immediately published to zero subscribers
anotherStringPublink.publish("Lulu")

// The following will be called immediately upon subscription with "Lulu" (the last published value)
anotherStringPublink.subscribe() { (name: String) in
    println("Hello, \(name)!")
}

// Prevent subscription being called immediately with last value
anotherStringPublink.callsLast = false

// The following will not be called immediately upon subscription because callsLast is now set to false
anotherStringPublink.subscribe() { (name: String) in
    println("Hello, \(name)!")
}

