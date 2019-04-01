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