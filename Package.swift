import PackageDescription
 
let package = Package(
  name: "SParserCalc",
  targets: [
    Target(
      name: "SParserCalc"
    ),
  ],
  dependencies: [
    .Package(url: "https://github.com/amnykon/SParser.git", majorVersion: 1, minor: 0),
  ]
)

