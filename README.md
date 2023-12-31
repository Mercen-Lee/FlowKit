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
flow.replace([FirstView(), SecondView()])
```
- **Reload View**
```swift
flow.reload()
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
