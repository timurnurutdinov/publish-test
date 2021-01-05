// swift-tools-version:5.2

import PackageDescription

let package = Package(
    name: "PublishTest",
    products: [
        .executable(
            name: "PublishTest",
            targets: ["PublishTest"]
        )
    ],
    dependencies: [
        .package(name: "Publish", url: "https://github.com/johnsundell/publish.git", from: "0.6.0"),
        .package(name: "Surge", url: "https://github.com/Jounce/Surge.git", from: "2.3.0")
    ],
    targets: [
        .target(
            name: "PublishTest",
            dependencies: ["Publish", "Surge"]
        ),
    ]
)
