// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Features",
    platforms: [.iOS(.v15)],
    products: [
        .library(
            name: "API",
            targets: ["API"]
        ),
        .library(
            name: "Features",
            targets: ["Features"]
        ),
        .library(
            name: "Today",
            targets: ["Today"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/pointfreeco/swift-composable-architecture.git", from: "0.54.0"),
    ],
    targets: [
        .target(
            name: "API",
            dependencies: [
                .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
            ]
        ),
        .testTarget(
            name: "APITests",
            dependencies: ["API"]
        ),
        .target(
            name: "Features",
            dependencies: ["Today"]
        ),
        .testTarget(
            name: "FeaturesTests",
            dependencies: ["Features"]
        ),
        .target(
            name: "Today",
            dependencies: ["API"]
        ),
        .testTarget(
            name: "TodayTests",
            dependencies: ["Today"]
        ),
    ]
)
