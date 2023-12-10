import SwiftUI

@available(iOS 13, *)
public final class Flow {
  
  var navigationController: UINavigationController
  private var presenter: Presenter
  
  public init<C: View>(rootView: C) {
    let hostingController = UIHostingController(rootView: rootView)
    navigationController = UINavigationController(rootViewController: hostingController)
    presenter = Presenter(navigationController: navigationController)
  }
  
  public func present() -> some View {
    presenter
  }
  
  private struct Presenter: UIViewControllerRepresentable {
    
    var navigationController: UINavigationController
    
    func makeUIViewController(context: Context) -> UINavigationController {
      return navigationController
    }
    
    func updateUIViewController(_ uiViewController: UINavigationController, context: Context) {
    }
  }
}
