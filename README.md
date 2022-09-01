# Qyre Test Assignment

### Requirements

* Create a screen with an input for person's name
* Fetch the nationality prediction from the [Nationalize](https://nationalize.io/)
  API. (Note that there might be more than one predictions, all of them should
  be displayed with percentages)
* After fetching the nationality, load an "avatar" for the user's name
  from [Dog API](https://dog.ceo/dog-api/).
* Show some kind of loading animation while the nationality result and
  the image are loading
* Add a "Save" button that will locally store the current result (should
  be disabled)
* Add a "History" button that will navigate to a page with locally
  saved results
* Upload your code to a public repository and add a demo video of your
  working application

### Constraints

* Use the [flutter_bloc](https://pub.dev/packages/flutter_bloc) package for
  state management
* Use anything but `shared_preferences` and `flutter_secure_storage` for
  locally storing the data
* Use [Dio](https://pub.dev/packages/dio) for HTTP requests

### Advices

* Keep the code as clean as possible.
* Extract everything that can be considered reusable
* Compose the UI ergonomically
* Be satisfied with the result and don't forget to have fun!