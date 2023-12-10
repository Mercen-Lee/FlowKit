import SwiftUI

@available(iOS 13, *)
public extension Flow {
  
  fileprivate func _wrap<C: View>(_ view: C) -> UIViewController {
    UIHostingController(rootView: view)
  }
  
  // MARK: - Push View
  func push<C: View>(_ view: C) {
    navigationController.pushViewController(_wrap(view), animated: true)
  }
  
  // MARK: - Pop View
  func pop() {
    navigationController.popViewController(animated: true)
  }
  
  // MARK: - Pop View to Root
  func popToRoot() {
    navigationController.popToRootViewController(animated: true)
  }
  
  // MARK: - Sheet
  func sheet<C: View>(_ view: C) {
    navigationController.present(_wrap(view), animated: true)
  }
}
