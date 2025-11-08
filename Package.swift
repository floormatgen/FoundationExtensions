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


// MARK: - Targets

var targets: [Target] = [
    .target(
        name: "FoundationExtensions",
        swiftSettings: swiftSettings
    ),
]
#if compiler(>=6.0) // Swift Testing requires at least Swift 6
targets += [
    .testTarget(
        name: "FoundationExtensionsTests",
        dependencies: ["FoundationExtensions"],
        swiftSettings: swiftSettings
    ),
]
#endif // compiler(>=6.0)

// MARK: - Package

let package = Package(
    name: "FoundationExtensions",
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "FoundationExtensions",
            targets: ["FoundationExtensions"]
        ),
    ],
    targets: targets
)
