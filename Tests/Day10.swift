import XCTest

@testable import AdventOfCode

final class Day10Tests: XCTestCase {
//  .....
//  .F-7.
//  .|.|.
//  .L-J.
//  .....
  let testData1 = """
    -L|F7
    7S-7|
    L|7||
    -L-J|
    L|-JF
    """

//  ..F7.
//  .FJ|.
//  FJ.L7
//  |F--J
//  LJ...
  let testData2 = """
    7-F7-
    .FJ|7
    SJLL7
    |F--J
    LJ.LJ
    """

  let testData3 = """
    ...........
    .S-------7.
    .|F-----7|.
    .||.....||.
    .||.....||.
    .|L-7.F-J|.
    .|..|.|..|.
    .L--J.L--J.
    ...........
    """

  let testData4 = """
    .F----7F7F7F7F-7....
    .|F--7||||||||FJ....
    .||.FJ||||||||L7....
    FJL7L7LJLJ||LJ.L-7..
    L--J.L7...LJS7F-7L7.
    ....F-J..F7FJ|L7L7L7
    ....L7.F7||L7|.L7L7|
    .....|FJLJ|FJ|F7|.LJ
    ....FJL-7.||.||||...
    ....L---J.LJ.LJLJ...
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

  func test_part2_1() {
    let challenge = Day10(data: testData1)
    XCTAssertEqual(String(describing: challenge.part2()), "1")
  }

  func test_part2_2() {
    let challenge = Day10(data: testData2)
    XCTAssertEqual(String(describing: challenge.part2()), "1")
  }

  func test_part2_3() {
    let challenge = Day10(data: testData3)
    XCTAssertEqual(String(describing: challenge.part2()), "4")
  }

  func test_part2_4() {
    let challenge = Day10(data: testData4)
    XCTAssertEqual(String(describing: challenge.part2()), "8")
  }
}
