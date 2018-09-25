// swift-tools-version:4.0
import PackageDescription

let package = Package(
  name: "SParserCalc",
  dependencies: [
    .package(url: "https://github.com/amnykon/SParser.git", from: "1.1.0"),
  ],
  targets: [
    .target(
      name: "SParserCalc",
        dependencies: [
          .product(name: "SParserLibs"),
        ]
    ),
  ]
)

