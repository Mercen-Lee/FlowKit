import SwiftUI

@available(iOS 13, *)
public struct FlowPresenter<C: View>: View {
  
  @ObservedObject var flow: FlowProvider
  
  public init(rootView: C) {
    flow = FlowProvider(rootView: rootView)
  }
  
  public var body: some View {
    flow.presenter
      .environmentObject(flow)
  }
}
