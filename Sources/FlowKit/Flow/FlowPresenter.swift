import SwiftUI

@available(iOS 13, *)
public struct FlowPresenter<C: View>: View {
  
  @ObservedObject var flow: FlowProvider
  
  public init(rootView: C, customNavigationController: NavigationControllerSettings? = nil) {
    flow = FlowProvider(rootView: rootView,
                        customNavigationController: customNavigationController)
  }
  
  public var body: some View {
    flow.present()
      .environmentObject(flow)
  }
}
