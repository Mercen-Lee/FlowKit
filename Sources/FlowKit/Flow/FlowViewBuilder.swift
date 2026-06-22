import SwiftUI

@available(iOS 13, *)
@resultBuilder
public enum FlowViewBuilder {

  public static func buildBlock(_ components: AnyView...) -> [AnyView] {
    components
  }

  public static func buildExpression<C: View>(_ expression: C) -> AnyView {
    AnyView(expression)
  }

  public static func buildOptional(_ component: [AnyView]?) -> [AnyView] {
    component ?? []
  }

  public static func buildEither(first component: [AnyView]) -> [AnyView] {
    component
  }

  public static func buildEither(second component: [AnyView]) -> [AnyView] {
    component
  }

  public static func buildArray(_ components: [[AnyView]]) -> [AnyView] {
    components.flatMap { $0 }
  }

  public static func buildLimitedAvailability(_ component: [AnyView]) -> [AnyView] {
    component
  }
}
