import SwiftUI
import UIKit

@available(iOS 13, *)
public extension FlowProvider {

  fileprivate func _wrap<C: View>(_ view: C) -> UIViewController {
    UIHostingController(rootView: view.flowProvider(self))
  }

  fileprivate func _navigationController(from sourceViewController: UIViewController? = nil,
                                         preferSelectedTab: Bool = false) -> UINavigationController {
    if let navigationController = sourceViewController?.navigationController {
      return navigationController
    }

    if preferSelectedTab,
       let tabBarController = navigationController.tabBarController {
      if let selectedNavigationController = tabBarController.selectedViewController as? UINavigationController {
        return selectedNavigationController
      }
      if let selectedNavigationController = tabBarController.selectedViewController?.navigationController {
        return selectedNavigationController
      }
    }

    return navigationController
  }

  // MARK: - Push View
  func push<C: View>(_ view: C,
                     animated: Bool = true,
                     preserveTabBar: Bool = true) {
    push(view,
         from: nil,
         animated: animated,
         preserveTabBar: preserveTabBar)
  }

  func push<C: View>(_ view: C,
                     from sourceViewController: UIViewController?,
                     animated: Bool = true,
                     preserveTabBar: Bool = true) {
    let viewController = _wrap(view)
    viewController.hidesBottomBarWhenPushed = !preserveTabBar
    _navigationController(from: sourceViewController)
      .pushViewController(viewController, animated: animated)
  }

  func tabPush<C: View>(_ view: C, animated: Bool = true) {
    let viewController = _wrap(view)
    viewController.hidesBottomBarWhenPushed = false
    _navigationController(preferSelectedTab: true)
      .pushViewController(viewController, animated: animated)
  }

  // MARK: - Pop View
  func pop(animated: Bool = true) {
    navigationController.popViewController(animated: animated)
  }

  // MARK: - Pop View with Specific Count
  func pop(_ count: Int, animated: Bool = true) {
    let viewControllers = navigationController.viewControllers
    if count > 0, count < viewControllers.count {
      let index = viewControllers[viewControllers.count - count]
      navigationController.popToViewController(index, animated: animated)
    }
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

  func replace(_ views: [AnyView], animated: Bool = true) {
    let viewControllers = views.map { _wrap($0) }
    navigationController.setViewControllers(viewControllers, animated: animated)
  }

  func replace(animated: Bool = true,
               @FlowViewBuilder _ views: () -> [AnyView]) {
    replace(views(), animated: animated)
  }

  func replace<C0: View, C1: View>(_ first: C0,
                                   _ second: C1,
                                   animated: Bool = true) {
    replace([AnyView(first), AnyView(second)], animated: animated)
  }

  func replace<C0: View, C1: View, C2: View>(_ first: C0,
                                             _ second: C1,
                                             _ third: C2,
                                             animated: Bool = true) {
    replace([AnyView(first), AnyView(second), AnyView(third)], animated: animated)
  }

  func replace<C0: View, C1: View, C2: View, C3: View>(_ first: C0,
                                                       _ second: C1,
                                                       _ third: C2,
                                                       _ fourth: C3,
                                                       animated: Bool = true) {
    replace([AnyView(first), AnyView(second), AnyView(third), AnyView(fourth)], animated: animated)
  }

  func replace<C0: View, C1: View, C2: View, C3: View, C4: View>(_ first: C0,
                                                                 _ second: C1,
                                                                 _ third: C2,
                                                                 _ fourth: C3,
                                                                 _ fifth: C4,
                                                                 animated: Bool = true) {
    replace([AnyView(first), AnyView(second), AnyView(third), AnyView(fourth), AnyView(fifth)], animated: animated)
  }

  // MARK: - Switch Views
  @discardableResult
  func moveView(from sourceIndex: Int,
                to destinationIndex: Int,
                animated: Bool = true) -> Bool {
    var viewControllers = navigationController.viewControllers
    guard viewControllers.indices.contains(sourceIndex) else { return false }
    guard destinationIndex >= 0, destinationIndex <= viewControllers.count else { return false }

    let viewController = viewControllers.remove(at: sourceIndex)
    let insertionIndex = min(destinationIndex, viewControllers.count)
    viewControllers.insert(viewController, at: insertionIndex)
    navigationController.setViewControllers(viewControllers, animated: animated)
    return true
  }

  @discardableResult
  func moveViewToTop(at index: Int, animated: Bool = true) -> Bool {
    moveView(from: index,
             to: navigationController.viewControllers.count - 1,
             animated: animated)
  }

  @discardableResult
  func moveTopView(to index: Int, animated: Bool = true) -> Bool {
    moveView(from: navigationController.viewControllers.count - 1,
             to: index,
             animated: animated)
  }

  @discardableResult
  func switchToView(at index: Int, animated: Bool = true) -> Bool {
    moveViewToTop(at: index, animated: animated)
  }

  // MARK: - Reload View
  func reload(animated: Bool = false) {
    let lastViewController = navigationController.topViewController
    var currentViewControllers: [UIViewController] {
      navigationController.viewControllers.dropLast()
    }
    if let lastViewController = lastViewController {
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

  // MARK: - Navigation Bar
  func setNavigationBarHidden(_ hidden: Bool, animated: Bool = true) {
    navigationBarHidden = hidden
    navigationController.setNavigationBarHidden(hidden, animated: animated)
  }

  func hideNavigationBar(animated: Bool = true) {
    setNavigationBarHidden(true, animated: animated)
  }

  func showNavigationBar(animated: Bool = true) {
    setNavigationBarHidden(false, animated: animated)
  }
}
