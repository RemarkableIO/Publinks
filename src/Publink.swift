//
//  Publink.swift
//
//  Created by Giles Van Gruisen on 11/12/14.
//  Copyright (c) 2014 Giles Van Gruisen. All rights reserved.
//

/** A block that accepts an optional object as an argument */
typealias SubscriptionBlock = (AnyObject?) -> ()

/** Link objects with a publisher-subscription relationship */
class Publink {

    /** Subscription blocks to be called with object on `publish(subscriptionBlock)` */
    var subscriptionBlocks: [SubscriptionBlock]

    /** The last object passed to `publish(object: AnyObject?)`, to be passed to a block upon subscription if `callsLast` is set to true */
    var lastObject: AnyObject?

    /** If set to true, blocks will be called with lastObject immediately upon subscription. Default value is true */
    var callsLast = true

    /** The number of times publish has been called */
    private var publishCount = 0

    /** Initializes a Publink with any number of subscription blocks */
    init(newSubscriptionBlocks: [SubscriptionBlock]) {
        subscriptionBlocks = newSubscriptionBlocks
    }

    /** Initializes a Publink with an empty subscriptions array */
    convenience init() {
        self.init(newSubscriptionBlocks: [])
    }

    /** Called by subscriber, passing a SubscriptionBlock to be called with an optional object when publish(object: AnyObject?) is called */
    func subscribe(newSubscriptionBlock: SubscriptionBlock) {

        // Call new subscription block with lastObject is callsLast is set to true
        if callsLast && publishCount > 0 { newSubscriptionBlock(lastObject) }

        // Add subscription block
        subscriptionBlocks += [newSubscriptionBlock]

    }

    /** Called by publisher with optional object. Calls every block in subscriptionBlocks */
    func publish(object: AnyObject?) {

        // Increment publishCount
        publishCount += 1

        // Set the last object to be passed into new subscription blocks if callsLast is true
        lastObject = object

        // Enumerate subscription blocks and pass optional object to each
        for subscriptionBlock in subscriptionBlocks {
            subscriptionBlock(object)
        }

    }

}
