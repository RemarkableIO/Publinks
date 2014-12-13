//
//  Publink.swift
//
//  Created by Giles Van Gruisen on 11/12/14.
//  Copyright (c) 2014 Giles Van Gruisen. All rights reserved.
//

/** Link objects with a publisher-subscription relationship */
struct Publink<T> {

    /** A block that accepts an optional value as an argument */
    typealias SubscriptionBlock = (T?) -> ()

    /** Subscription blocks to be called with optional value on `publish(subscriptionBlock)` */
    var subscriptionBlocks: [SubscriptionBlock] = [SubscriptionBlock]() {
        didSet {
            updateAllSubscriptionBlocks()
        }
    }

    /** Named subscription blocks to be called with optional value  on `publish(subscriptionBlock)` */
    var namedSubscriptionBlocks = [String: SubscriptionBlock]()

    /** The last value passed to `publish(value: T?)`, to be passed to a block upon subscription if `callsLast` is set to true */
    var lastValue: T?

    /** If set to true, blocks will be called with lastValue immediately upon subscription. Default value is true */
    var callsLast = true

    /** The number of times publish has been called */
    private var publishCount = 0

    /** A collection of all subscription blocks */
    private var allSubscriptionBlocks: [SubscriptionBlock]

    /** Initializes a Publink with any number of subscription blocks */
    init(newSubscriptionBlocks: [SubscriptionBlock]) {
        subscriptionBlocks = newSubscriptionBlocks
        allSubscriptionBlocks = subscriptionBlocks
    }

    /** Called by subscriber, passing a SubscriptionBlock to be called with an optional value when publish(value: T?) is called */
    mutating func subscribe(newSubscriptionBlock: SubscriptionBlock) {

        // Add subscription block
        subscriptionBlocks.append(newSubscriptionBlock)

        // Try to call with last value
        callLast(newSubscriptionBlock)

    }

    /** Called by subscriber, passing a SubscriptionBlock to be called with an optional value when publish(value: T?) is called */
    mutating func subscribeNamed(name: String, newSubscriptionBlock: SubscriptionBlock) {

        // Add subscription block
        namedSubscriptionBlocks[name] = newSubscriptionBlock

        // Try to call with last value
        callLast(newSubscriptionBlock)

        // Update all blocks
        updateAllSubscriptionBlocks()

    }

    /** Call to unsubscribe a particular subscription block */
    mutating func unsubscribe(name: String) {
        namedSubscriptionBlocks[name] = nil
        updateAllSubscriptionBlocks()
    }

    /** Called by publisher with optional value. Calls every block in subscriptionBlocks */
    mutating func publish(value: T) {

        // Increment publishCount
        publishCount += 1

        // Set the last value to be passed into new subscription blocks if callsLast is true
        lastValue = value

        // Enumerate subscription blocks and pass optional value to each
        for subscriptionBlock in allSubscriptionBlocks {
            subscriptionBlock(value)
        }

    }

    private mutating func updateAllSubscriptionBlocks() {

        // Update all blocks to subscription blocks
        allSubscriptionBlocks = subscriptionBlocks

        // Add each named block
        for (name, block) in namedSubscriptionBlocks {
            allSubscriptionBlocks += [block]
        }
    }

    /** Checks callsLast and, if true, passes lastValue into into subscriptionBlock */
    private func callLast(subscriptionBlock: SubscriptionBlock) {

        // Call new subscription block with lastValue is callsLast is set to true
        if callsLast && publishCount > 0 {
            subscriptionBlock(lastValue)
        }

    }

}
