import XCTest

@testable import AdventOfCode

final class Day01Tests: XCTestCase {
  // Smoke test data provided in the challenge question
  let part1TestData = """
    1abc2
    pqr3stu8vwx
    a1b2c3d4e5f
    treb7uchet
    """

  let part2TestData = """
    two1nine
    eightwothree
    abcone2threexyz
    xtwone3four
    4nineeightseven2
    zoneight234
    7pqrstsixteen
    """

  func test_part1() {
    let challenge = Day01(data: part1TestData)
    XCTAssertEqual(String(describing: challenge.part1()), "142")
  }

  func test_part2() {
    let challenge = Day01(data: part2TestData)
    XCTAssertEqual(String(describing: challenge.part2()), "281")
  }

  func test_part1CalibrationValue() {
    let answers = [12, 38, 15, 77]
    let challenge = Day01(data: part1TestData)

    for (line, expected) in zip(challenge.lines, answers) {
      XCTAssertEqual(challenge.part1CalibrationValue(for: line), expected)
    }
  }

  func test_part2CalibrationValue() {
    let answers = [29, 83, 13, 24, 42, 14, 76]
    let challenge = Day01(data: part2TestData)

    for (line, expected) in zip(challenge.lines, answers) {
      XCTAssertEqual(challenge.part2CalibrationValue(for: line), expected)
    }
  }
}
