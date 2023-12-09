import SwiftUI

@available(iOS 13, *)
public struct FlowView: UIViewControllerRepresentable {
  
  private var flow: Flow
  
  public init(flow: Flow) {
    self.flow = flow
  }
  
  public func makeUIViewController(context: Context) -> UINavigationController {
    return flow.navigationController
  }
  
  public func updateUIViewController(_ uiViewController: UINavigationController, context: Context) {
  }
}
