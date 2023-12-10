import XCTest

@testable import AdventOfCode

final class Day10Tests: XCTestCase {
  // Smoke test data provided in the challenge question
  let testData1 = """
    -L|F7
    7S-7|
    L|7||
    -L-J|
    L|-JF
    """

  let testData2 = """
    7-F7-
    .FJ|7
    SJLL7
    |F--J
    LJ.LJ
    """

  func test_part1_1() {
    let challenge = Day10(data: testData1)
    XCTAssertEqual(String(describing: challenge.part1()), "4")
  }

  func test_canConnect() {
    XCTAssert(Cell(rawValue: "|")!.canConnect(to: Cell(rawValue: "F")!, direction: .north))
    XCTAssert(Cell(rawValue: "|")!.canConnect(to: Cell(rawValue: "7")!, direction: .north))
    XCTAssert(Cell(rawValue: "|")!.canConnect(to: Cell(rawValue: "L")!, direction: .south))
    XCTAssert(Cell(rawValue: "|")!.canConnect(to: Cell(rawValue: "J")!, direction: .south))
    XCTAssert(Cell(rawValue: "S")!.canConnect(to: Cell(rawValue: "L")!, direction: .south))

    XCTAssertFalse(Cell(rawValue: "|")!.canConnect(to: Cell(rawValue: "F")!, direction: .south))
    XCTAssertFalse(Cell(rawValue: "-")!.canConnect(to: Cell(rawValue: "F")!, direction: .south))
    XCTAssertFalse(Cell(rawValue: "S")!.canConnect(to: Cell(rawValue: "F")!, direction: .south))
  }

  func test_adjacentCells() {
    let challenge = Day10(data: testData1)
    print(adjacentCells(for: (0, 0), in: challenge.grid))
  }

  func test_yy() {
    let challenge = Day10(data: testData1)
    let x = connectedCells(for: (1, 1), in: challenge.grid)
    print(x)
  }

  func test_part1_2() {
    let challenge = Day10(data: testData2)
    XCTAssertEqual(String(describing: challenge.part1()), "8")
  }

  func test_part2() {
    let challenge = Day10(data: testData1)
    XCTAssertEqual(String(describing: challenge.part2()), "Todo")
  }
}
