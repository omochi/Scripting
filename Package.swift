// swift-tools-version:5.0

import PackageDescription

let package = Package(
    name: "Scripting",
    products: [
        .library(name: "Scripting", targets: ["Scripting"]),
    ],
    dependencies: [
    ],
    targets: [
        .target(name: "Scripting", dependencies: []),
        .testTarget(name: "ScriptingTests", dependencies: ["Scripting"]),
    ]
)
