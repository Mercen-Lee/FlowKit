![FlowKit](https://raw.githubusercontent.com/Mercen-Lee/FlowKit/main/Resources/FlowKitLogo.svg)

![Swift](https://img.shields.io/badge/Swift-5.5_5.6_5.7_5.8-Orange?style=flat-square)
![Platforms](https://img.shields.io/badge/Platforms-iOS-yellowgreen?style=flat-square)
![Swift Package Manager](https://img.shields.io/badge/Swift_Package_Manager-compatible-orange?style=flat-square)
![License](https://img.shields.io/badge/License-MIT-blue?style=flat-square)

> SwiftUI is great. But navigation isn't.

FlowKit is **the ideal navigation library** for SwiftUI.

## Requirements
| Platform | Minimum Swift Version | Installation |
| --- | --- | --- |
| iOS 13.0+ | 5.5 | [Swift Package Manager](#swift-package-manager) |

## Installation
### Swift Package Manager
- `File` -> `Add Packages...` And paste the repository URL.
- Or add it to the `dependencies` value of your `Package.swift`.
```swift
dependencies: [
  .package(url: "https://github.com/Mercen-Lee/FlowKit.git", .branch("main"))
]
```

## Usage
- **Push View**
```swift
flow.push(NextView())
// or
flow.push(NextView(), animated: false)
// Preserve a tab bar when pushing inside tab-based apps.
flow.push(NextView(), preserveTabBar: true)
flow.tabPush(NextView())
```
- **Pop View**
```swift
flow.pop()
flow.pop(3) // 3 Views
```
- **Pop View to Root**
```swift
flow.popToRoot()
```
- **Replace Views**
```swift
flow.replace([StepView(index: 1), StepView(index: 2)])
// Heterogeneous view types can use the builder, variadic overloads, or AnyView.
flow.replace {
  FirstView()
  SecondView()
}
flow.replace(FirstView(), SecondView())
flow.replace([AnyView(FirstView()), AnyView(SecondView())])
```
- **Switch Views**
```swift
flow.switchToView(at: 0)
flow.moveView(from: 0, to: 2)
flow.moveTopView(to: 0)
```
- **Reload View**
```swift
flow.reload()
```
- **Navigation Bar**
```swift
FlowPresenter(rootView: ContentView(), navigationBarHidden: true)
flow.hideNavigationBar()
flow.showNavigationBar()
```
- **Present Sheet**
```swift
flow.sheet(SheetView())
```
- **Present Alert**
```swift
let alert = Alert(title: "Error",
                  message: "Not Found",
                  dismissButton: .default("Ok"))
flow.alert(alert)
```
- **Deep Link**
```swift
flow.registerDeepLink(.init(path: "/details") { url, flow in
  flow.push(DetailView())
})

flow.openDeepLink(URL(string: "myapp://host/details")!)
```

## Example
### App
```swift
import SwiftUI
import FlowKit

@main
struct SampleApp: App {
  var body: some Scene {
    WindowGroup {
      FlowPresenter(rootView: ContentView())
    }
  }
}
```
### View
```swift
struct ContentView: View {
  @Flow var flow
  var body: some View {
    Button {
      flow.push(NextView())
    } label: {
      Text("Push")
    }
  }
}

struct NextView: View {
  @Flow var flow
  var body: some View {
    Button {
      flow.pop()
    } label: {
      Text("Pop")
    }
  }
}
```

`FlowPresenter` injects `FlowProvider` through a weak environment value, so pushed
SwiftUI views can use `@Flow` without retaining the provider as an
`EnvironmentObject`.

## [TCA](https://github.com/pointfreeco/swift-composable-architecture) Example
### Dependency
```swift
struct FlowDependency: DependencyKey {
  static var liveValue: FlowProvider {
    FlowProvider(rootView: ContentView())
  }
}

extension DependencyValues {
  var flow: FlowProvider {
    get { self[FlowDependency.self] }
    set { self[FlowDependency.self] = newValue }
  }
}
```
### Reducer
```swift
struct Content: Reducer {
  @Dependency(\.flow) var flow
  ...
}
```
