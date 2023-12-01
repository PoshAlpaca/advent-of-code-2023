import Foundation

struct Day01: AdventDay {
  let data: String

  var lines: [String] {
    data
      .trimmingCharacters(in: .newlines)
      .components(separatedBy: .newlines)
  }

  // MARK: - Part 1

  func part1() -> Any {
    lines
      .map(part1CalibrationValue(for:))
      .reduce(0, +)
  }

  func part1CalibrationValue(for line: String) -> Int {
    guard
      let firstDigit = line.first(where: \.isNumber).flatMap({ Int(String($0)) }),
      let lastDigit = line.last(where: \.isNumber).flatMap({ Int(String($0)) })
    else {
      fatalError("Line '\(line)' did not contain any digits.")
    }

    return firstDigit * 10 + lastDigit
  }

  // MARK: - Part 2

  func part2() -> Any {
    lines
      .map(part2CalibrationValue(for:))
      .reduce(0, +)
  }

  func part2CalibrationValue(for line: String) -> Int {
    guard
      let firstDigit = firstDigit(in: line),
      let lastDigit = lastDigit(in: line)
    else {
      fatalError("Line '\(line)' did not contain any digits.")
    }

    return firstDigit * 10 + lastDigit
  }

  private func firstDigit(in line: String) -> Int? {
    var index = line.startIndex
    while index < line.endIndex {
      // Check for number
      let nextCharacter = line[index]
      if nextCharacter.isNumber {
        return Int(String(nextCharacter))!
      }

      // Check for spelled out digits
      let remainingLine = line[index..<line.endIndex]
      for (digit, value) in spelledOutDigits where remainingLine.hasPrefix(digit) {
        return value
      }

      line.formIndex(after: &index)
    }

    return nil
  }

  private func lastDigit(in line: String) -> Int? {
    var index = line.endIndex
    while index > line.startIndex {
      line.formIndex(before: &index)

      // Check for number
      let nextCharacter = line[index]
      if nextCharacter.isNumber {
        return Int(String(nextCharacter))!
      }

      // Check for spelled out digits
      let remainingLine = line[line.startIndex...index]
      for (digit, value) in spelledOutDigits where remainingLine.hasSuffix(digit) {
        return value
      }
    }

    return nil
  }
}

private let spelledOutDigits = [
  "one": 1,
  "two": 2,
  "three": 3,
  "four": 4,
  "five": 5,
  "six": 6,
  "seven": 7,
  "eight": 8,
  "nine": 9,
]
