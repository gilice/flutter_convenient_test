# [flutter_convenient_test](https://github.com/fzyzcjy/flutter_convenient_test): Write and debug tests easily, built on `integration_test`

[![Flutter Package](https://img.shields.io/pub/v/convenient_test.svg)](https://pub.dev/packages/convenient_test)
[![CI](https://github.com/fzyzcjy/flutter_convenient_test/actions/workflows/ci.yaml/badge.svg)](https://github.com/fzyzcjy/flutter_convenient_test/actions/workflows/ci.yaml)
[![Post-release](https://github.com/fzyzcjy/flutter_convenient_test/actions/workflows/post_release.yaml/badge.svg)](https://github.com/fzyzcjy/flutter_convenient_test/actions/workflows/post_release.yaml)
[![Codacy Badge](https://api.codacy.com/project/badge/Grade/45204254806b4790a2d6403b81156e42)](https://app.codacy.com/gh/fzyzcjy/flutter_convenient_test?utm_source=github.com&utm_medium=referral&utm_content=fzyzcjy/flutter_convenient_test&utm_campaign=Badge_Grade_Settings)

## 🚀 Advantages

* **Full action history**: Gain insight on what has happened to the tests - View all actions/assertions taken in the tests, with friendly descriptions.
* **Time travel, with screenshots**: What did the UI look like when that button was tapped 50 steps ago? Now you know everything.
* **Rapid re-execution**: Edit code, save, run - done within seconds, not minutes.
* **Videos recorded**: Watch what has happened, in full detail.
* **Being interactive**: Play with the app interactively, again within seconds.
* **Isolation mode**: One test will no longer destroy environment of other tests - run each with full isolation (optionally).

And also...

* **`integration_test` still there**: Freely use everything from `integration_test`, `mockito`,  `test`, etc.
* **Flaky test awareness**: No false alarms, while no blindly ignoring.
* **Simpler and shorter code**: No manual `pump`, wait or retry.
* **Suitable for CI**: Run headlessly, with logs to be visualized when needed. 
* **Miscellaneous**: Visually see target regions, run single test/group within seconds, raw logs...

## 📷 Quick demo

<!--README_VIDEO_REPLACEMENT_PLACEHOLDER_ONE-->

<!--README_VIDEO_REPLACEMENT_PLACEHOLDER_TWO-->

https://user-images.githubusercontent.com/5236035/167066810-d0aa36ba-0113-4140-92f9-cec0a9e77ed1.mov

## Have questions?

Though used in production environment in my own 200kloc Flutter app, this package - especially the doc - is surely not yet perfect. Just [create an issue](https://github.com/fzyzcjy/flutter_convenient_test/issues) and I usually reply quite quickly.

## 📚 Features

### Full action history

> See actions/taps/assertions taken in the tests, with friendly descriptions (in the left panel)

![](https://raw.githubusercontent.com/fzyzcjy/flutter_convenient_test/master/doc/gif/a_action_history.gif)

<br>

### Time travel with screenshots

> Tap an action to see its screenshots

![](https://raw.githubusercontent.com/fzyzcjy/flutter_convenient_test/master/doc/gif/b_time_travel_screenshot.gif)

<br>

### Rapid re-execution

> Edit code, save, run - within seconds

![](https://raw.githubusercontent.com/fzyzcjy/flutter_convenient_test/master/doc/gif/c_rapid_execute.gif)

<br>

### Videos recorded

> Watch what has happened in full detail (in right panel)

![](https://raw.githubusercontent.com/fzyzcjy/flutter_convenient_test/master/doc/gif/d_video_record.gif)

P.S. Highlighted action is in sync with the playing video. Tap action to seek video.

<br>

### Being interactive

> Temporarily play with the app, interactively. (Flutter originally cannot interact with app in test mode)

![](https://raw.githubusercontent.com/fzyzcjy/flutter_convenient_test/master/doc/gif/e_interactive.gif)

<br>

### Isolation mode

One test will no longer destroy environment of other tests - now you can run run each with full isolation.

This is especially helpful in big projects (such as mine), when an end-to-end setup is not easy to tear down, and one failed test can cause all subsequent tests to have damaged execution environment and thus fail.

Technical details: If this mode is enabled, a hot restart will be performed after each attempt of each test.

### `integration_test` is still there

You can still use everything from `integration_test`, `mockito`,  `test`, etc. This package is not a reinvented wheel, and has exposed the underlying `integration_test` to you.

If you want to migrate to this package from raw `integration_test`, have a look at Getting Started section below.

### Flaky tests awareness

Flaky is flaky, and we are aware of it. It is neither failed nor success, so you will not be alarmed by false positives, and not completely ignore it.

<!--[TODO screenshot: Several tests, one failed, one flaky, one success]-->

### Simpler and shorter code

* No manual `pump`
* No manual wait and retry

```dart
await t.get(find.byTooltip('Fetch Data From Backend')).tap();
// OK even if "fetch data" needs undeterministic time interval. Will automatically pump, wait and retry.
await t.get(find.text('New Data')).should(findsOneWidget);
```

More in quickstart and tutorials below.

### CI / headless mode

This tool can be run without GUI and only produce log data and exit code, making it suitable to be run in a CI. If you want to examine the details with GUI, just open the generated artifact in the GUI using `Open File` button.

### Run single test/group

Tap "Run" icon button after each test or group to re-run *only* that test/group, without running anything else. All within seconds - no need to recompile like what the original test package did.

### Visually see target regions

Useful when replaying videos and screenshots

* `Mark`s have colored borders
* Gestures have visual feedbacks

### Raw logs

Tap "Raw Logs" in the right panel to see raw outputs of a test.

## Tutorial: Run examples

1. Clone this repository and enter the `packages/convenient_test/example` folder.
2. Run the example app (e.g. using iOS simulator) via `flutter run /path/to/flutter_convenient_test/packages/convenient_test/example/integration_test/main_test.dart --host-vmservice-port 9753 --disable-service-auth-codes --dart-define CONVENIENT_TEST_APP_CODE_DIR=/path/to/this/app`. Can also be run via VSCode or Android Studio with similar commands.
3. Run the GUI located in `packages/convenient_test_manager`. It is nothing but a normal Flutter Windows/MacOS/Linux app, so run it follow Flutter official doc. Or run via `flutter profile` mode to speed up. Or execute `cd macos && fastlane build` and use the generated (release-version) application.
4. Enjoy the GUI!

## Getting started

1. In `pubspec.yaml`, add `convenient_test: ^1.0.0` to the `dependencies` section, and `convenient_test_dev: ^1.0.0` to the `dev_dependencies` section. As normal, we need to `flutter pub get`.
2. Create `integration_test/main_test.dart` file in your app. Fill it like `void main() => convenientTestMain(MyConvenientTestSlot(), () { ... the normal test code you write });`. See [the example package](https://github.com/fzyzcjy/flutter_convenient_test/blob/master/packages/convenient_test/example/integration_test/main_test.dart) for demonstration.
3. Run your app (e.g. using iOS simulator) via `flutter run /path/to/your/app/integration_test/main_test.dart --host-vmservice-port 9753 --disable-service-auth-codes --dart-define CONVENIENT_TEST_APP_CODE_DIR=/path/to/this/app`. Can also be run via VSCode or Android Studio with similar commands.
4. Run the GUI located in `packages/convenient_test_manager`. It is nothing but a normal Flutter Windows/MacOS/Linux app, so run it follow Flutter official doc. Or run via `flutter profile` mode to speed up. Or execute `cd macos && fastlane build` and use the generated (release-version) application.
5. Enjoy the GUI!

---

Thanks for testing frameworks in JavaScript, especially `Cypress`, for giving inspirations!

