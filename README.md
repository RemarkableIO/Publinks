# Publinks!

Publinks is a stupid implementation of the publish-subscribe pattern in Swift, for when ReactiveCocoa is just a bit too heavy.

# Example

Publinks can be used anywhere, but I like to use them on ViewModels to be able to tell Views when to update:

Our `viewModel` holds the publink, to which our table view cell will subscribe. Our `viewModel` holds a reference to the `model`. Once this model has been set, we want to format data and publish the `viewModel` to publink subscribers.
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

`myTableViewCell` holds a reference to the `viewModel`. As soon as this `viewModel` is set, we will subscribe to its publink, setting the values of out text label in the subscription block.
```
class myTableViewCell: UITableViewCell {
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
