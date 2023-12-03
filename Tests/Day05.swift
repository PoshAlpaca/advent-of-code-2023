import XCTest

@testable import AdventOfCode

final class Day05Tests: XCTestCase {
  // Smoke test data provided in the challenge question
  let testData = """
    """

  func test_part1() {
    let challenge = Day05(data: testData)
    XCTAssertEqual(String(describing: challenge.part1()), "Todo")
  }

  func test_part2() {
    let challenge = Day05(data: testData)
    XCTAssertEqual(String(describing: challenge.part2()), "Todo")
  }
}
