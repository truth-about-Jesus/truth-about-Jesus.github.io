// swift-tools-version:5.5

import PackageDescription

let package = Package(
    name: "TruthAboutJesusSite",
    platforms: [.macOS(.v12)],
    products: [
        .executable(
            name: "TruthAboutJesusSite",
            targets: ["TruthAboutJesusSite"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/johnsundell/publish.git", "0.8.0"..."0.9.0")
    ],
    targets: [
        .executableTarget(
            name: "TruthAboutJesusSite",
            dependencies: [
                .product(name: "Publish", package: "publish")
            ]
        )
    ]
)
