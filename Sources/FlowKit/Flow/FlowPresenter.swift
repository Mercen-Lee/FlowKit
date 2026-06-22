import SwiftUI

@available(iOS 13, *)
public struct FlowPresenter<C: View>: View {

  @State private var flow: FlowProvider

  public init(rootView: C, customNavigationController: NavigationControllerSettings? = nil) {
    _flow = State(initialValue: FlowProvider(rootView: rootView,
                                             customNavigationController: customNavigationController))
  }

  public init(rootView: C,
              navigationBarHidden: Bool,
              customNavigationController: NavigationControllerSettings? = nil) {
    _flow = State(initialValue: FlowProvider(rootView: rootView,
                                             navigationBarHidden: navigationBarHidden,
                                             customNavigationController: customNavigationController))
  }

  public var body: some View {
    flow.present()
  }
}
