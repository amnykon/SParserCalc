import SParserLibs

let exp = CommandLine.arguments.dropFirst().joined()
let stream: Stream = StringStream(from: exp)
let parser = Parser(stream: stream)
do {
  if let number = try parser.readExp() {
    print(number)
  } else {
    print("error while reading exp")
  }
} catch let error as ParserError {
  print(error.message)
}

