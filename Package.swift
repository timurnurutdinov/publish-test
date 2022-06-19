// swift-tools-version:5.5

import PackageDescription

let package = Package(
    name: "PublishTest",
    platforms: [
        .macOS(.v12),
    ],
    products: [
        .library(
            name: "PublishTest",
            targets: ["PublishTest"]
        )
    ],
    dependencies: [
        .package(name: "Publish", url: "https://github.com/johnsundell/publish.git", from: "0.6.0"),
        .package(name: "Surge", url: "https://github.com/Jounce/Surge.git", from: "2.3.0"),
        .package(name: "Checksum", url: "https://github.com/rnine/Checksum.git", from: "1.0.2")
    ],
    targets: [
        .target(
            name: "PublishTest",
            dependencies: ["Publish", "Surge", "Checksum"],
            path: "Sources"
        ),
    ]
)
