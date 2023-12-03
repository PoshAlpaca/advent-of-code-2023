import Foundation

struct Day03: AdventDay {
  let data: String

  // MARK: - Part 1

//  func xx() -> Any {
//    var sum = 0
//
//    var currentNumber = 0
//    var hadSymbol = false
//
//    var stringIndex = data.startIndex
//    while stringIndex < data.endIndex {
//      let char = data[stringIndex]
//
//      if char.isNumber {
//        currentNumber = currentNumber * 10 + Int(String(char))!
//      } else if char.isSymbol {
//        sum += currentNumber
//        currentNumber = 0
//        hadSymbol = true
//      } else {
//        currentNumber = 0
//      }
//
//
//      data.formIndex(after: &stringIndex)
//    }
//
//    return sum
//  }

//  func xx() -> Any {
//    var previousLine: [Token] = []
//    var currentLine: [Token] = []
//
//    for char in data {
//      if char.isNumber {
//        current
//        currentNumber = currentNumber * 10 + Int(String(char))!
//      } else if char != ".", char.isSymbol || char.isPunctuation {
//        currentLine.append((index...index, .symbol))
//      }
//    }
//
//    return ""
//  }

  func part1() -> Any {
    var foundNumbers: Set<FoundNumber> = []

    let x = """
      467..114..
      ...*......
      ..35..633.
      """

    let y = """
      ..7$.114..
      ...*7.....
      ..35..633.
      """

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

    print(Set(data).map { ($0, $0.isNumber || $0.isSymbol || $0.isPunctuation || $0.isNewline)})

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
//        print("current line:", currentLine.compactMap(\.token.number))
//        print(currentLine)

        let adjacent = currentLine.numbersAdjacentToSymbols(line: line - 1)
//        print("adjacent:", adjacent)


        previousLine = currentLine
        currentLine = []
        continue
      }


      index += 1
    }

//    print(foundNumbers.map(\.number))

    return foundNumbers.reduce(0) { $0 + $1.number }
  }

  // MARK: - Part 2

  func part2() -> Any {
    "Todo"
  }
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
