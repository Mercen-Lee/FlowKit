import SwiftUI

@available(iOS 13, *)
@propertyWrapper
public struct Flow: DynamicProperty {
  
  @EnvironmentObject private var object: FlowProvider
  
  public var wrappedValue: FlowProvider {
    object
  }
  
  public init() { }
}
