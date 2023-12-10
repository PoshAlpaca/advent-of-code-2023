import XCTest

@testable import AdventOfCode

final class Day06Tests: XCTestCase {
  // Smoke test data provided in the challenge question
  let testData = """
    Time:      7  15   30
    Distance:  9  40  200
    """

  func test_part1() throws {
    let challenge = Day06(data: testData)
    XCTAssertEqual(String(describing: try challenge.part1()), "288")
  }

  func test_part2() throws {
    let challenge = Day06(data: testData)
    XCTAssertEqual(String(describing: try challenge.part2()), "71503")
  }
}
