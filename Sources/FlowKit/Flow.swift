import SwiftUI

@available(iOS 13, *)
public class Flow {
  
  var navigationController: UINavigationController
  
  public init<C: View>(rootView: C) {
    let hostingController = UIHostingController(rootView: rootView)
    navigationController = UINavigationController(rootViewController: hostingController)
  }
  
  fileprivate func _wrap<C: View>(_ view: C) -> UIViewController {
    UIHostingController(rootView: view)
  }
  
  // MARK: - Push View
  public func push<C: View>(_ view: C) {
    navigationController.pushViewController(_wrap(view), animated: true)
  }
  
  // MARK: - Pop View
  public func pop() {
    navigationController.popViewController(animated: true)
  }
  
  // MARK: - Pop View to Root
  public func popToRoot() {
    navigationController.popToRootViewController(animated: true)
  }
  
  // MARK: - Sheet
  public func sheet<C: View>(_ view: C) {
    navigationController.present(_wrap(view), animated: true)
  }
}
