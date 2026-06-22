import SwiftUI

@available(iOS 13, *)
public struct FlowDeepLink {

  private let matcher: (URL) -> Bool
  private let action: (URL, FlowProvider) -> Void

  public init(matcher: @escaping (URL) -> Bool,
              action: @escaping (URL, FlowProvider) -> Void) {
    self.matcher = matcher
    self.action = action
  }

  public init(path: String,
              action: @escaping (URL, FlowProvider) -> Void) {
    let normalizedPath = path.hasPrefix("/") ? path : "/" + path
    self.init(matcher: { $0.path == normalizedPath },
              action: action)
  }

  public init(host: String,
              path: String? = nil,
              action: @escaping (URL, FlowProvider) -> Void) {
    let normalizedPath = path.map { $0.hasPrefix("/") ? $0 : "/" + $0 }
    self.init(matcher: { url in
      guard url.host == host else { return false }
      guard let normalizedPath = normalizedPath else { return true }
      return url.path == normalizedPath
    }, action: action)
  }

  func canOpen(_ url: URL) -> Bool {
    matcher(url)
  }

  func open(_ url: URL, flow: FlowProvider) {
    action(url, flow)
  }
}

@available(iOS 13, *)
public extension FlowProvider {

  func registerDeepLink(_ deepLink: FlowDeepLink) {
    deepLinkRoutes.append(deepLink)
  }

  func registerDeepLinks(_ deepLinks: [FlowDeepLink]) {
    deepLinkRoutes.append(contentsOf: deepLinks)
  }

  func removeDeepLinks() {
    deepLinkRoutes.removeAll()
  }

  @discardableResult
  func openDeepLink(_ url: URL) -> Bool {
    guard let deepLink = deepLinkRoutes.first(where: { $0.canOpen(url) }) else {
      return false
    }
    deepLink.open(url, flow: self)
    return true
  }
}
