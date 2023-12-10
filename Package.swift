// swift-tools-version: 5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "FlowKit",
  platforms: [.iOS(.v13)],
  products: [
    .library(
      name: "FlowKit",
      targets: ["FlowKit"]),
  ],
  dependencies: [
  ],
  targets: [
    .target(
      name: "FlowKit",
      dependencies: [])
  ]
)
