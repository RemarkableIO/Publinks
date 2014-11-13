# Publinks!

Publinks is a dead simple implementation of the publish-subscribe pattern in Swift, for those times when ReactiveCocoa is just a bit too heavy.

# Example

Publinks can be used anywhere, but I like to use them on ViewModels to be able to tell Views when to update:

`ViewModel` holds the publink to which `MyTableViewCell` will subscribe.`ViewModel` holds a reference to the `Model`. Once this model has been set, we want to format data and publish the `ViewModel` to publink subscribers.
```
class ViewModel {
  var publink = Publink()

  var model: Model {
    didSet {
      reload() // Properly formats and sets data properties based on new model
      publink.publish(self) // Sends the newly formatted ViewModel to any subscribers
    }
  }
}
```

`MyTableViewCell` holds a reference to the `ViewModel`. As soon as this `ViewModel` is set, we will subscribe to its publink, setting the values of out text label in the subscription block.
```
class MyTableViewCell: UITableViewCell {
  var viewModel: ViewModel! {
    willSet {

      // Subscribe in property observer, newValue is thew new noteViewModel
      newValue.publink.subscribe { (object: AnyObject?) -> () in

        if let newNoteViewModel = object as? NoteViewModel {
          // Set text label
          self.textLabel.text = newNoteViewModel.text
        }

      } // subscribe
    } // willSet
  }
}
