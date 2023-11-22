// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "DataLayer",
    platforms: [.iOS(.v16)],
    products: [
        .library(
            name: "DataLayer",
            targets: ["DataLayer"]),
    ],
    dependencies: [
        .package(path: "../DomainLayer")
    ],
    targets: [
        .target(
            name: "DataLayer",
            dependencies: ["DomainLayer"]
        ),
    ]
)
