import Foundation
import SParserLibs
fileprivate func eval0Exp(term: Parser.TermType) -> Parser.ExpType {
  return term
}

extension Parser {
  public typealias ExpType = Double
  private func recursivelyRead(exp: ExpType) throws -> ExpType? {
    return exp
  }
  public func readExp() throws -> ExpType? {
    if let term = try readTerm() {
      return try recursivelyRead(exp: eval0Exp(term: term))
    }
    return nil
  }
}

fileprivate func eval0Term(term: Parser.TermType, factor: Parser.FactorType) -> Parser.TermType {
  return term + factor
}

fileprivate func eval1Term(term: Parser.TermType, factor: Parser.FactorType) -> Parser.TermType {
  return term - factor
}

fileprivate func eval2Term(factor: Parser.FactorType) -> Parser.TermType {
  return factor
}

extension Parser {
  public typealias TermType = Double
  private func recursivelyRead(term: TermType) throws -> TermType? {
    if matches(string: "+") {
      if let factor = try readFactor() {
        return try recursivelyRead(term: eval0Term(term: term, factor: factor))
      }
      try throwError(message:"error parsing term. expect factor")
    }
    if matches(string: "-") {
      if let factor = try readFactor() {
        return try recursivelyRead(term: eval1Term(term: term, factor: factor))
      }
      try throwError(message:"error parsing term. expect factor")
    }
    return term
  }
  public func readTerm() throws -> TermType? {
    if let factor = try readFactor() {
      return try recursivelyRead(term: eval2Term(factor: factor))
    }
    return nil
  }
}

fileprivate func eval0Factor(factor: Parser.FactorType, number: Parser.NumberType) -> Parser.FactorType {
  return factor * number
}

fileprivate func eval1Factor(factor: Parser.FactorType, number: Parser.NumberType) -> Parser.FactorType {
  return factor / number
}

fileprivate func eval2Factor(number: Parser.NumberType) -> Parser.FactorType {
  return number
}

extension Parser {
  public typealias FactorType = Double
  private func recursivelyRead(factor: FactorType) throws -> FactorType? {
    if matches(string: "*") {
      if let number = try readNumber() {
        return try recursivelyRead(factor: eval0Factor(factor: factor, number: number))
      }
      try throwError(message:"error parsing factor. expect number")
    }
    if matches(string: "/") {
      if let number = try readNumber() {
        return try recursivelyRead(factor: eval1Factor(factor: factor, number: number))
      }
      try throwError(message:"error parsing factor. expect number")
    }
    return factor
  }
  public func readFactor() throws -> FactorType? {
    if let number = try readNumber() {
      return try recursivelyRead(factor: eval2Factor(number: number))
    }
    return nil
  }
}

fileprivate func eval0Number(float: Parser.FloatType) -> Parser.NumberType {
  return float
}

fileprivate func eval1Number(number: Parser.NumberType) -> Parser.NumberType {
  return +number
}

fileprivate func eval2Number(number: Parser.NumberType) -> Parser.NumberType {
  return -number
}

fileprivate func eval3Number(exp: Parser.ExpType) -> Parser.NumberType {
  return exp
}

fileprivate func eval4Number(exp: Parser.ExpType) -> Parser.NumberType {
  return sin(exp)
}

fileprivate func eval5Number(exp: Parser.ExpType) -> Parser.NumberType {
  return cos(exp)
}

fileprivate func eval6Number(exp: Parser.ExpType) -> Parser.NumberType {
  return tan(exp)
}

fileprivate func eval7Number() -> Parser.NumberType {
  return Double.pi
}

extension Parser {
  public typealias NumberType = Double
  private func recursivelyRead(number: NumberType) throws -> NumberType? {
    return number
  }
  public func readNumber() throws -> NumberType? {
    if let float = try readFloat() {
      return try recursivelyRead(number: eval0Number(float: float))
    }
    if matches(string: "+") {
      if let number = try readNumber() {
        return try recursivelyRead(number: eval1Number(number: number))
      }
      try throwError(message:"error parsing number. expect number")
    }
    if matches(string: "-") {
      if let number = try readNumber() {
        return try recursivelyRead(number: eval2Number(number: number))
      }
      try throwError(message:"error parsing number. expect number")
    }
    if matches(string: "(") {
      if let exp = try readExp() {
        if matches(string: ")") {
          return try recursivelyRead(number: eval3Number(exp: exp))
        }
        try throwError(message:"error parsing number. expect \")\"")
      }
      try throwError(message:"error parsing number. expect exp")
    }
    if matches(string: "sin(") {
      if let exp = try readExp() {
        if matches(string: ")") {
          return try recursivelyRead(number: eval4Number(exp: exp))
        }
        try throwError(message:"error parsing number. expect \")\"")
      }
      try throwError(message:"error parsing number. expect exp")
    }
    if matches(string: "cos(") {
      if let exp = try readExp() {
        if matches(string: ")") {
          return try recursivelyRead(number: eval5Number(exp: exp))
        }
        try throwError(message:"error parsing number. expect \")\"")
      }
      try throwError(message:"error parsing number. expect exp")
    }
    if matches(string: "tan(") {
      if let exp = try readExp() {
        if matches(string: ")") {
          return try recursivelyRead(number: eval6Number(exp: exp))
        }
        try throwError(message:"error parsing number. expect \")\"")
      }
      try throwError(message:"error parsing number. expect exp")
    }
    if matches(string: "pi") {
      return try recursivelyRead(number: eval7Number())
    }
    return nil
  }
}

fileprivate func eval0Float(significand: Parser.SignificandType) -> Parser.FloatType {
  return significand
}

fileprivate func eval1Float(significand: Parser.SignificandType, exponent: Parser.ExponentType) -> Parser.FloatType {
  return significand * pow(10.0,exponent)
}

fileprivate func eval2Float(significand: Parser.SignificandType, exponent: Parser.ExponentType) -> Parser.FloatType {
  return significand * pow(10.0,exponent)
}

extension Parser {
  public typealias FloatType = Double
  private func recursivelyRead(float: FloatType) throws -> FloatType? {
    return float
  }
  public func readFloat() throws -> FloatType? {
    if let significand = try readSignificand() {
      if matches(string: "e") {
        if let exponent = try readExponent() {
          return try recursivelyRead(float: eval1Float(significand: significand, exponent: exponent))
        }
        try throwError(message:"error parsing float. expect exponent")
      }
      if matches(string: "E") {
        if let exponent = try readExponent() {
          return try recursivelyRead(float: eval2Float(significand: significand, exponent: exponent))
        }
        try throwError(message:"error parsing float. expect exponent")
      }
      return try recursivelyRead(float: eval0Float(significand: significand))
    }
    return nil
  }
}

fileprivate func eval0Exponent(exponent: Parser.ExponentType, digit: Parser.DigitType) -> Parser.ExponentType {
  return exponent * 10.0 + Double(digit)
}

fileprivate func eval1Exponent(exponent: Parser.ExponentType) -> Parser.ExponentType {
  return -exponent
}

fileprivate func eval2Exponent(exponent: Parser.ExponentType) -> Parser.ExponentType {
  return exponent
}

fileprivate func eval3Exponent() -> Parser.ExponentType {
  return 0.0
}

extension Parser {
  public typealias ExponentType = Double
  private func recursivelyRead(exponent: ExponentType) throws -> ExponentType? {
    if let digit = try readDigit() {
      return try recursivelyRead(exponent: eval0Exponent(exponent: exponent, digit: digit))
    }
    return exponent
  }
  public func readExponent() throws -> ExponentType? {
    if matches(string: "-") {
      if let exponent = try readExponent() {
        return try recursivelyRead(exponent: eval1Exponent(exponent: exponent))
      }
      try throwError(message:"error parsing exponent. expect exponent")
    }
    if matches(string: "+") {
      if let exponent = try readExponent() {
        return try recursivelyRead(exponent: eval2Exponent(exponent: exponent))
      }
      try throwError(message:"error parsing exponent. expect exponent")
    }
    return try recursivelyRead(exponent: eval3Exponent())
  }
}

fileprivate func eval0Significand(wholeSignificand: Parser.WholeSignificandType) -> Parser.SignificandType {
  return wholeSignificand
}

fileprivate func eval1Significand(fractionalSignificand: Parser.FractionalSignificandType) -> Parser.SignificandType {
  return fractionalSignificand
}

fileprivate func eval2Significand(wholeSignificand: Parser.WholeSignificandType, fractionalSignificand: Parser.FractionalSignificandType) -> Parser.SignificandType {
  return wholeSignificand + fractionalSignificand 
}

extension Parser {
  public typealias SignificandType = Double
  private func recursivelyRead(significand: SignificandType) throws -> SignificandType? {
    return significand
  }
  public func readSignificand() throws -> SignificandType? {
    if let wholeSignificand = try readWholeSignificand() {
      if matches(string: ".") {
        if let fractionalSignificand = try readFractionalSignificand() {
          return try recursivelyRead(significand: eval2Significand(wholeSignificand: wholeSignificand, fractionalSignificand: fractionalSignificand))
        }
        try throwError(message:"error parsing significand. expect fractionalSignificand")
      }
      return try recursivelyRead(significand: eval0Significand(wholeSignificand: wholeSignificand))
    }
    if matches(string: ".") {
      if let fractionalSignificand = try readFractionalSignificand() {
        return try recursivelyRead(significand: eval1Significand(fractionalSignificand: fractionalSignificand))
      }
      try throwError(message:"error parsing significand. expect fractionalSignificand")
    }
    return nil
  }
}

fileprivate func eval0WholeSignificand(wholeSignificand: Parser.WholeSignificandType, digit: Parser.DigitType) -> Parser.WholeSignificandType {
  return wholeSignificand * 10.0 + Double(digit)
}

fileprivate func eval1WholeSignificand(digit: Parser.DigitType) -> Parser.WholeSignificandType {
  return Double(digit)
}

extension Parser {
  public typealias WholeSignificandType = Double
  private func recursivelyRead(wholeSignificand: WholeSignificandType) throws -> WholeSignificandType? {
    if let digit = try readDigit() {
      return try recursivelyRead(wholeSignificand: eval0WholeSignificand(wholeSignificand: wholeSignificand, digit: digit))
    }
    return wholeSignificand
  }
  public func readWholeSignificand() throws -> WholeSignificandType? {
    if let digit = try readDigit() {
      return try recursivelyRead(wholeSignificand: eval1WholeSignificand(digit: digit))
    }
    return nil
  }
}

fileprivate func eval0FractionalSignificand(digit: Parser.DigitType, fractionalSignificand: Parser.FractionalSignificandType) -> Parser.FractionalSignificandType {
  return (fractionalSignificand + Double(digit)) / 10.0
}

fileprivate func eval1FractionalSignificand() -> Parser.FractionalSignificandType {
  return 0.0
}

extension Parser {
  public typealias FractionalSignificandType = Double
  private func recursivelyRead(fractionalSignificand: FractionalSignificandType) throws -> FractionalSignificandType? {
    return fractionalSignificand
  }
  public func readFractionalSignificand() throws -> FractionalSignificandType? {
    if let digit = try readDigit() {
      if let fractionalSignificand = try readFractionalSignificand() {
        return try recursivelyRead(fractionalSignificand: eval0FractionalSignificand(digit: digit, fractionalSignificand: fractionalSignificand))
      }
      try throwError(message:"error parsing fractionalSignificand. expect fractionalSignificand")
    }
    return try recursivelyRead(fractionalSignificand: eval1FractionalSignificand())
  }
}

fileprivate func eval0Digit() -> Parser.DigitType {
  return 0
}

fileprivate func eval1Digit() -> Parser.DigitType {
  return 1
}

fileprivate func eval2Digit() -> Parser.DigitType {
  return 2
}

fileprivate func eval3Digit() -> Parser.DigitType {
  return 3
}

fileprivate func eval4Digit() -> Parser.DigitType {
  return 4
}

fileprivate func eval5Digit() -> Parser.DigitType {
  return 5
}

fileprivate func eval6Digit() -> Parser.DigitType {
  return 6
}

fileprivate func eval7Digit() -> Parser.DigitType {
  return 7
}

fileprivate func eval8Digit() -> Parser.DigitType {
  return 8
}

fileprivate func eval9Digit() -> Parser.DigitType {
  return 9
}

extension Parser {
  public typealias DigitType = Int
  private func recursivelyRead(digit: DigitType) throws -> DigitType? {
    return digit
  }
  public func readDigit() throws -> DigitType? {
    if matches(string: "0") {
      return try recursivelyRead(digit: eval0Digit())
    }
    if matches(string: "1") {
      return try recursivelyRead(digit: eval1Digit())
    }
    if matches(string: "2") {
      return try recursivelyRead(digit: eval2Digit())
    }
    if matches(string: "3") {
      return try recursivelyRead(digit: eval3Digit())
    }
    if matches(string: "4") {
      return try recursivelyRead(digit: eval4Digit())
    }
    if matches(string: "5") {
      return try recursivelyRead(digit: eval5Digit())
    }
    if matches(string: "6") {
      return try recursivelyRead(digit: eval6Digit())
    }
    if matches(string: "7") {
      return try recursivelyRead(digit: eval7Digit())
    }
    if matches(string: "8") {
      return try recursivelyRead(digit: eval8Digit())
    }
    if matches(string: "9") {
      return try recursivelyRead(digit: eval9Digit())
    }
    return nil
  }
}
