# Publinks!

Publinks is a stupid implementation of the publish-subscribe pattern in Swift, for when ReactiveCocoa is just a bit too heavy.

# Example

Publinks can be used anywhere, but I like to use them on ViewModels to be able to tell Views when to update:

```
class ViewModel {
  var publink = Publink()

  ... // Formatted data properties

  var model: Model {
    didSet {
      reload() // Properly formats and sets data properties based on new model
      publink.publish(self) // Sends the newly formatted ViewModel to any subscribers
    }
  }
}

class myTableViewCell: UITableViewCell {
  var viewModel: ViewModel! {
    willSet {

      // Subscribe in property observer, newValue is thew new noteViewModel
      newValue.publink.subscribe { (object: AnyObject?) -> () in

        if let newNoteViewModel = object as? NoteViewModel {
          // Set text label
          self.textLabel.text = newNoteViewModel.text
        }

      }

    }
  }

  ...
}
