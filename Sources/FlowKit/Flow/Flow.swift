import SwiftUI

@available(iOS 13, *)
@propertyWrapper
public struct Flow: DynamicProperty {

  @Environment(\.flowProvider) private var object

  public var wrappedValue: FlowProvider {
    guard let object = object else {
      preconditionFailure("FlowProvider is missing. Use FlowPresenter or apply .flowProvider(_:) to the view hierarchy.")
    }
    return object
  }

  public init() { }
}
