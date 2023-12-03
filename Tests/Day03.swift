import XCTest

@testable import AdventOfCode

final class Day03Tests: XCTestCase {
  // Smoke test data provided in the challenge question
  let testData = """
    467..114..
    ...*......
    ..35..633.
    ......#...
    617*......
    .....+.58.
    ..592.....
    ......755.
    ...$.*....
    .664.598..

    """

  func test_part1() {
    let challenge = Day03(data: testData)
    XCTAssertEqual(String(describing: challenge.part1()), "4361")
  }

  func test_part2() {
    let challenge = Day03(data: testData)
    XCTAssertEqual(String(describing: challenge.part2()), "467835")
  }

  func test_numbersCloseTo() {
    let line: [(range: ClosedRange<Int>, token: Day03.Token)] = [
      (0...2, .number(value: 123)),
      (4...5, .number(value: 99)),
    ]

    let numbers = line.numbers(closeTo: 3...3, line: 0)

    XCTAssertEqual(
      numbers,
      [
        .init(number: 123, line: 0, range: 0...2),
        .init(number: 99, line: 0, range: 4...5),
      ]
    )
  }

  func test_numbersAdjacentToSymbols() {
    let line: [(range: ClosedRange<Int>, token: Day03.Token)] = [
      (0...0, .symbol),
      (1...2, .number(value: 44)),
      (3...3, .symbol),
      (4...5, .number(value: 99)),
    ]

    let numbers = line.numbersAdjacentToSymbols(line: 0)

    XCTAssertEqual(
      numbers,
      [
        .init(number: 44, line: 0, range: 1...2),
        .init(number: 99, line: 0, range: 4...5),
      ]
    )
  }

  func test_numbersAdjacentToSymbols_() {
    let line: [(range: ClosedRange<Int>, token: Day03.Token)] = [
      (0...2, .number(value: 617)),
      (3...3, .symbol),
    ]

    let numbers = line.numbersAdjacentToSymbols(line: 0)

    XCTAssertEqual(
      numbers,
      [
        .init(number: 617, line: 0, range: 0...2),
      ]
    )
  }
}
