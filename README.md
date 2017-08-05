![N8iveKit](http://n8iveapps.com/opensource/n8ivekit/n8ivekit.png)

A set of frameworks making iOS development more fun, developed by [N8ive Apps](https://n8iveapps.com)

## Frameworks

- [x] InterfaceKit
- [ ] AuthKit
- [ ] NetworkKit

More frameworks to be added, stay tuned :relaxed:

## InterfaceKit

#### NKViewController:
The base type replacement for [UIViewController](https://developer.apple.com/documentation/uikit/uiviewcontroller) that adds `N8iveKit` supporting logic.

#### NKNavigationController:
Replaces [UINavigationController](https://developer.apple.com/documentation/uikit/uinavigationcontroller) by adding more features:
- Ability to have different NavigationBar height for each viewController (navigation bar size interactively changes during transitions).
- Ability to enable/disable `Sloppy swiping` (swipe back gesture to be started from anywhere on the screen, not only from the left edge).

To access the NavigationBar, just call `adaptableNavigationBar` property of the `NKNavigationController`.

#### NKTabBarController:
Replaces [UITabBarController](https://developer.apple.com/documentation/uikit/uitabbarcontroller) by adding more features:
- Ability to automatically position the `TabBar` vertically if the screen width exceeds a certain limit (you can also choose whether to make it on the right or left of the screen).
- Ability to implement your own `TabBar` layout.
- In case of vertical `TabBar`, `NavigationBar` of selected tab (in case it was `NKNavigationController`) is positioned on top of the `TabBar`.

To access the TabBar, just call `adaptableTabBar` property of the `NKTabBarController`.

## Requirements
- iOS 10.0+
- Xcode 9.0
- Swift 4.0

## Installation
### Manually

N8iveKit can be integrated manually into your project, dependency managers support coming soon.

#### Embedded Framework

- Add N8iveKit as a git [submodule](http://git-scm.com/docs/git-submodule) by running the following command:

  ```bash
  $ git submodule add https://github.com/n8iveapps/N8iveKit.git
  ```

- Open the `N8iveKit` folder, and drag the needed kit (currently, only `InterfaceKit.xcodeproj` available) into the Project Navigator of your application's Xcode project.

- Navigate to the target configuration window by clicking on the blue project icon, and selecting the application target under the "Targets" heading in the sidebar.
- In the tab bar at the top of that window, open the "General" panel.
- Click on the `+` button under the "Embedded Binaries" section.
- Select the framework (currently `InterfaceKit.framework`).
- Enjoy  :relaxed:

## Usage

You can use Interface builder and change the element type to your desired one, or you can simple initialize the elements in code.

## Communication

- If you **found a bug**, open an issue.
- If you **have a feature request**, open an issue.
- If you **want to contribute**, submit a pull request.

## License

N8iveKit is released under the MIT license. [See LICENSE](https://github.com/n8iveapps/N8iveKit/blob/master/LICENSE) for details.


