import Foundation

struct Day03: AdventDay {
  let data: String

  // MARK: - Part 1

  func part1() -> Any {
    var foundNumbers: Set<FoundNumber> = []

    var previousLine: [(range: ClosedRange<Int>, token: Token)] = []
    var currentLine: [(range: ClosedRange<Int>, token: Token)] = []
    var line = 0
    var index = 0

    var currentNumber: Int {
      get {
        if let last = currentLine.last, last.range.upperBound == index - 1, case let .number(value) = last.token {
          return value
        } else {
          return 0
        }
      }
      set {
        if let last = currentLine.last, last.range.upperBound == index - 1, case .number = last.token {
          let lastIndex = currentLine.index(before: currentLine.endIndex)
          let updatedRange = (last.range.lowerBound...index)
          currentLine[lastIndex] = (updatedRange, .number(value: newValue))
        } else {
          currentLine.append((index...index, .number(value: newValue)))
        }
      }
    }

    for char in data {
      if char.isNumber {
        currentNumber = currentNumber * 10 + Int(String(char))!
      } else if char != ".", char.isSymbol || char.isPunctuation {
        currentLine.append((index...index, .symbol))
      } else if char == "\n" {
        line += 1
        index = 0
        foundNumbers.formUnion(previousLine.numbersAdjacentToSymbols(line: line - 1))

        for (range, token) in previousLine where token.isSymbol {
          foundNumbers.formUnion(currentLine.numbers(closeTo: range, line: line))
        }

        for (range, token) in currentLine where token.isSymbol {
          foundNumbers.formUnion(previousLine.numbers(closeTo: range, line: line - 1))
        }

        previousLine = currentLine
        currentLine = []
        continue
      }


      index += 1
    }

    return foundNumbers.reduce(0) { $0 + $1.number }
  }

  // MARK: - Part 2

  func part2() -> Any {
    var foundNumbers: Set<FoundNumber> = []

    var previousLine: [(range: ClosedRange<Int>, token: Token)] = []
    var currentLine: [(range: ClosedRange<Int>, token: Token)] = []
    var line = 0
    var index = 0

    var currentNumber: Int {
      get {
        if let last = currentLine.last, last.range.upperBound == index - 1, case let .number(value) = last.token {
          return value
        } else {
          return 0
        }
      }
      set {
        if let last = currentLine.last, last.range.upperBound == index - 1, case .number = last.token {
          let lastIndex = currentLine.index(before: currentLine.endIndex)
          let updatedRange = (last.range.lowerBound...index)
          currentLine[lastIndex] = (updatedRange, .number(value: newValue))
        } else {
          currentLine.append((index...index, .number(value: newValue)))
        }
      }
    }

    var foundGears: [(line: Int, index: Int)] = []

    for char in data {
      if char.isNumber {
        currentNumber = currentNumber * 10 + Int(String(char))!
      } else if char != ".", char.isSymbol || char.isPunctuation {
        if char == "*" {
          foundGears.append((line, index))
        }
        currentLine.append((index...index, .symbol))
      } else if char == "\n" {
        foundNumbers.formUnion(previousLine.numbersAdjacentToSymbols(line: line - 1))

        for (range, token) in previousLine where token.isSymbol {
          foundNumbers.formUnion(currentLine.numbers(closeTo: range, line: line))
        }

        for (range, token) in currentLine where token.isSymbol {
          foundNumbers.formUnion(previousLine.numbers(closeTo: range, line: line - 1))
        }
        line += 1
        index = 0

        previousLine = currentLine
        currentLine = []
        continue
      }


      index += 1
    }

    var sum = 0
    var numbers: [Int] = []
    for gear in foundGears {
      for number in foundNumbers {
        if ((gear.line - 1)...(gear.line + 1)).contains(number.line), number.range.extended(by: 1).contains(gear.index) {
          numbers.append(number.number)
        }
      }
      if numbers.count == 2 {
        sum += numbers[0] * numbers[1]
      }
      numbers = []
    }

    return sum
  }

//  func part2() -> Any {
//    // [lineNumber: [number]]
//    var numbers: [Int: [RecordedNumber]] = [:]
//    var symbols: [Int: [RecordedSymbol]] = [:]
//
//    var line = 0
//    var index = 0
//    var previousLineSymbols: [RecordedSymbol] = []
//    var currentLineSymbols: [RecordedSymbol] = []
//
//    for char in data {
//      if char.isNumber {
//        let charValue = Int(String(char))!
//        if var currentNumber = numbers[line, default: [:]][index - 1] {
//          currentNumber.value = currentNumber.value * 10 + charValue
//          numbers[line]
//        } else {
//          numbers[line, default: [:]][index] = RecordedNumber(value: charValue, range: index...index, symbols: [])
//        }
//      } else if char != ".", char.isSymbol || char.isPunctuation {
//        currentLineSymbols.append(RecordedSymbol(value: char, index: index))
//      } else if char == "\n" {
//        line += 1
//        index = 0
//
//        // also record symbols from previous lines
//        for symbol in previousLineSymbols {
//          for (lastKnownIndex, recordedNumber) in numbers[line, default: [:]] {
//            if recordedNumber.range.extended(by: 1).contains(symbol.index) {
//              numbers[line, default: [:]][lastKnownIndex]?.symbols.append(symbol)
//            }
//          }
//        }
//
//        previousLineSymbols = currentLineSymbols
//        currentLineSymbols = []
//      }
//    }
//
//
//    let sum = numbers.flatMap {
//      $0.value.compactMap {
//        if $0.value.symbols.contains(where: { $0.value == "*" }) {
//          return $0.value.value
//        }
//        return nil
//      }
//    }
//    .reduce(0, +)
//
//    for (line, rest) in numbers {
//      for (lastKnownIndex, recordedNumber) in rest {
//        if recordedNumber.symbols.contains(where: { $0.value == "*" })
//        for (key, value) in numbers[line - 1, default: [:]] {
//          value.symbols
//        }
//      }
//    }
//
//    return sum
//  }
}




struct RecordedNumber {
  var value: Int
  var range: ClosedRange<Int>
  var symbols: [RecordedSymbol]
}

struct RecordedSymbol {
  let value: Character
  let index: Int
}

extension Day03 {
  enum Token {
    case number(value: Int)
    case symbol

    var number: Int? {
      if case let .number(value) = self {
        value
      } else {
        nil
      }
    }

    var isSymbol: Bool {
      switch self {
      case .number: false
      case .symbol: true
      }
    }
  }
}

struct FoundNumber: Hashable {
  let number: Int
  let line: Int
  let range: ClosedRange<Int>

  func hash(into hasher: inout Hasher) {
    line.hash(into: &hasher)
    range.hash(into: &hasher)
  }
}

extension [(range: ClosedRange<Int>, token: Day03.Token)] {
  func numbersAdjacentToSymbols(line: Int) -> Set<FoundNumber> {
    var numbers: Set<FoundNumber> = []
    var previous: (range: ClosedRange<Int>, token: Day03.Token)?
    for (range, token) in self {
      if let previous, previous.range.extended(by: 1).overlaps(range) {
        switch (previous.token, token) {
        case let (.number(previousNumber), .symbol):
          numbers.insert(.init(number: previousNumber, line: line, range: previous.range))
        case let (.symbol, .number(number)):
          numbers.insert(.init(number: number, line: line, range: range))
        case (.symbol, .symbol), (.number, .number):
          break
        }
      }

      previous = (range, token)
    }

    return numbers
  }

  func numbers(closeTo range: ClosedRange<Int>, line: Int) -> Set<FoundNumber> {
    var numbers: Set<FoundNumber> = []
    for (tokenRange, token) in self {
      if case let .number(number) = token, range.extended(by: 1).overlaps(tokenRange) {
        numbers.insert(.init(number: number, line: line, range: tokenRange))
      }
    }

    return numbers
  }
}

extension ClosedRange<Int> {
  func extended(by amount: Int) -> ClosedRange<Int> {
    ClosedRange(uncheckedBounds: (lowerBound - amount, upperBound + amount))
  }
}
