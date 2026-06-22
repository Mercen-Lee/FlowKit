import SwiftUI
import UIKit

public typealias NavigationControllerSettings = ((UIViewController) -> UINavigationController)

@available(iOS 13, *)
public final class FlowProvider: ObservableObject {

  var navigationController = UINavigationController()
  var navigationBarHidden: Bool
  var deepLinkRoutes: [FlowDeepLink] = []

  public init<C: View>(rootView: C,
                       navigationBarHidden: Bool = false,
                       customNavigationController: NavigationControllerSettings? = nil) {
    self.navigationBarHidden = navigationBarHidden

    let hostingController = UIHostingController(rootView: rootView.flowProvider(self))
    self.navigationController = {
      if let navigationController = customNavigationController?(hostingController) {
        return navigationController
      } else {
        return UINavigationController(rootViewController: hostingController)
      }
    }()
    self.navigationController.setNavigationBarHidden(navigationBarHidden, animated: false)
  }

  public func present() -> some View {
    Presenter(navigationController: navigationController,
              navigationBarHidden: navigationBarHidden)
      .flowProvider(self)
  }

  struct Presenter: UIViewControllerRepresentable {

    var navigationController: UINavigationController
    var navigationBarHidden: Bool

    func makeUIViewController(context: Context) -> UINavigationController {
      navigationController.setNavigationBarHidden(navigationBarHidden, animated: false)
      return navigationController
    }

    func updateUIViewController(_ uiViewController: UINavigationController, context: Context) {
      uiViewController.setNavigationBarHidden(navigationBarHidden, animated: false)
    }
  }
}
