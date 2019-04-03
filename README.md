# Learnalist on the mobile

# Aim

- Make it easy to add lists.
- Make it easy to play with lists.
- Trigger the user to learn with the lists.
- Interact with the learnalist api.


# Notes

- Currently focused on getting it up and running on iOS as I do not own an android device.


# Development

Working with the json models, will require a rebuld if changes are made.

```
flutter packages pub run build_runner build
```

# Testing

To test, use the ide or the via the command line.

## Command line
### Run a specific test within a file.

```
flutter test --no-pub --plain-name="Test list v1" test/models_learnalist.dart
```

# Links

- [Learnalist api](https://github.com/freshteapot/learnalist-api)
- [How to use state from a widget](https://stackoverflow.com/questions/50818770/passing-data-to-a-stateful-widget)
- [Making a nice popupmenu](https://flutter.dev/docs/catalog/samples/basic-app-bar) [on github](https://github.com/flutter/flutter/blob/master/examples/catalog/lib/basic_app_bar.dart)
- [Icons](https://docs.flutter.io/flutter/material/Icons-class.html)