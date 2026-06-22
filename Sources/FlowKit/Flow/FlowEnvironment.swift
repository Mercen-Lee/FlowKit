import SwiftUI

@available(iOS 13, *)
private final class WeakFlowProviderBox {

  weak var provider: FlowProvider?

  init(_ provider: FlowProvider?) {
    self.provider = provider
  }
}

@available(iOS 13, *)
private struct FlowProviderKey: EnvironmentKey {

  static let defaultValue = WeakFlowProviderBox(nil)
}

@available(iOS 13, *)
public extension EnvironmentValues {

  var flowProvider: FlowProvider? {
    get { self[FlowProviderKey.self].provider }
    set { self[FlowProviderKey.self] = WeakFlowProviderBox(newValue) }
  }
}

@available(iOS 13, *)
public extension View {

  func flowProvider(_ provider: FlowProvider) -> some View {
    environment(\.flowProvider, provider)
  }
}
