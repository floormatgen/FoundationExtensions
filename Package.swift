// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription


// MARK: - Lanaguage Feature Migration

var swiftSettings: [SwiftSetting] = [
    .enableUpcomingFeature("ExistentialAny"),
    .enableUpcomingFeature("MemberImportVisibility"),
    .enableUpcomingFeature("StrictConcurrency"),
    .enableUpcomingFeature("NonisolatedNonsendingByDefault"),
]
#if compiler(<6.0)
swiftSettings += [
    .enableExperimentalFeature("StrictConcurrency"),
]
#endif // compiler(<6.0)

/// To use previews, uncomment this line
/// This is because SwiftUI previews don't work properly before iOS 13.0
/// and other aligned releases
//swiftSettings.append(.define("FMG_SWIFT_PREVIEWS"))


// MARK: - Targets

var targets: [Target] = [
    .target(
        name: "FoundationExtensions",
        swiftSettings: swiftSettings
    ),
]

// Apple Ecosystem Targets
#if canImport(Darwin)
targets += [
    .target(
        name: "UIKitExtensions",
        swiftSettings: swiftSettings
    ),
]
#endif // canImport(Darwin)

// Test targets
#if compiler(>=6.0) // Swift Testing requires at least Swift 6
targets += [
    .testTarget(
        name: "FoundationExtensionsTests",
        dependencies: ["FoundationExtensions"],
        swiftSettings: swiftSettings
    ),
]
#endif // compiler(>=6.0)


// MARK: - Products

var products: [Product] = [
    // Products define the executables and libraries a package produces, making them visible to other packages.
    .library(
        name: "FoundationExtensions",
        targets: ["FoundationExtensions"]
    ),
    .library(
        name: "UIKitExtensions",
        targets: ["FoundationExtensions", "UIKitExtensions"]
    ),
]


// MARK: - Package

let package = Package(
    name: "SDKExtensions",
    products: products,
    dependencies: [
        .package(url: "https://github.com/apple/swift-docc-plugin", from: "1.0.0"),
    ],
    targets: targets
)
