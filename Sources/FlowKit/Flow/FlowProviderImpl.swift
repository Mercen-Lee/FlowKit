import SwiftUI

@available(iOS 13, *)
public extension FlowProvider {
  
  fileprivate func _wrap<C: View>(_ view: C) -> UIViewController {
    UIHostingController(rootView: view)
  }
  
  // MARK: - Push View
  func push<C: View>(_ view: C, animated: Bool = true) {
    navigationController.pushViewController(_wrap(view), animated: animated)
  }
  
  // MARK: - Pop View
  func pop(animated: Bool = true) {
    navigationController.popViewController(animated: animated)
  }
  
  // MARK: - Pop View with Specific Count
  func pop(_ count: Int, animated: Bool = true) {
    let viewControllers = navigationController.viewControllers
    let index = viewControllers[viewControllers.count - count]
    navigationController.popToViewController(index, animated: animated)
  }
  
  // MARK: - Pop View to Root
  func popToRoot(animated: Bool = true) {
    navigationController.popToRootViewController(animated: animated)
  }
  
  // MARK: - Replace View
  func replace<C: View>(_ views: [C], animated: Bool = true) {
    let viewControllers = views.map { _wrap($0) }
    navigationController.setViewControllers(viewControllers, animated: animated)
  }
  
  // MARK: - Reload View
  func reload(animated: Bool = false) {
    let lastViewController = navigationController.topViewController
    var currentViewControllers: [UIViewController] {
      navigationController.viewControllers.dropLast()
    }
    if let lastViewController {
      let viewControllers = currentViewControllers + [lastViewController]
      navigationController.setViewControllers(viewControllers, animated: animated)
    }
  }
  
  // MARK: - Sheet
  func sheet<C: View>(_ view: C, animated: Bool = true) {
    navigationController.present(_wrap(view), animated: animated)
  }
  
  // MARK: - FullScreenCover
  func fullScreenCover<C: View>(_ view: C, animated: Bool = true) {
    let viewController = _wrap(view)
    viewController.modalPresentationStyle = .fullScreen
    navigationController.present(viewController, animated: animated)
  }
  
  // MARK: - Alert
  func alert(_ alert: Alert, animated: Bool = true) {
    navigationController.present(alert.toAlertController(), animated: animated)
  }
}
