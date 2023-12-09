import SwiftUI

@available(iOS 13, *)
public class Flow {
  
  var navigationController: UINavigationController
  
  public init<C: View>(rootView: C) {
    let hostingController = UIHostingController(rootView: rootView)
    navigationController = UINavigationController(rootViewController: hostingController)
  }
  
  // MARK: Push View
  public func push<C: View>(_ nextView: C) {
    let hostingController = UIHostingController(rootView: nextView)
    navigationController.pushViewController(hostingController, animated: true)
  }
  
  // MARK: Pop View
  public func pop() {
    navigationController.popViewController(animated: true)
  }
  
  // MARK: Pop View to Root
  public func popToRoot() {
    navigationController.popToRootViewController(animated: true)
  }
}
