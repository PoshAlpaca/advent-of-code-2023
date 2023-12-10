import Algorithms
import Foundation

struct Day10: AdventDay {
  let data: String

  let grid: [[Character]]

  init(data: String) {
    self.data = data
    self.grid = data
      .trimmingCharacters(in: .newlines)
      .components(separatedBy: .newlines)
      .map { $0.map { $0} }
  }

  // MARK: - Part 1

  func part1() -> Any {
    var start: (line: Int, column: Int)? = nil
    for i in grid.indices {
      for j in grid[i].indices {
        if grid[i][j] == "S" {
          start = (i, j)
        }
      }
    }

    guard let start else { return "Wrong" }

    var lastCell: (line: Int, column: Int) = (0, 0)
    var currentCell: (line: Int, column: Int) = start
    var counter = 0

    while true {
      let connected = connectedCells(for: currentCell, in: grid)

      for cell in connected where lastCell.line != cell.line || lastCell.column != cell.column {
        lastCell = currentCell
        currentCell = cell
        break
      }

      counter += 1

      if currentCell.line == start.line && currentCell.column == start.column {
        break
      }
    }

    return counter / 2
  }

  // MARK: - Part 2

  func part2() -> Any {
    "Todo"
  }
}

func connectedCells(for cell: (line: Int, column: Int), in grid: [[Character]]) -> [(line: Int, column: Int)] {
  let adjacent = adjacentCells(for: cell, in: grid)

  let currentCell = Cell(rawValue: grid[cell.line][cell.column])!

  var cells: [(line: Int, column: Int)] = []
  for (direction, otherCell) in adjacent {
    if currentCell.canConnect(to: Cell(rawValue: grid[otherCell.line][otherCell.column])!, direction: direction) {
      cells.append(otherCell)
    }
  }

  return cells
}

func adjacentCells(for cell: (line: Int, column: Int), in grid: [[Character]]) -> [(direction: Direction, cell: (line: Int, column: Int))] {
  [
    (.north, (cell.line - 1, cell.column)),
    (.south, (cell.line + 1, cell.column)),
    (.west, (cell.line, cell.column - 1)),
    (.east, (cell.line, cell.column + 1)),
  ].filter { grid.indices.contains($1.line) && grid[0].indices.contains($1.column) }
}

enum Cell: Character {
  case vertical = "|"
  case horizontal = "-"
  case northEast = "L"
  case northWest = "J"
  case southWest = "7"
  case southEast = "F"
  case ground = "."
  case animal = "S"

  static let northConnectors: Set<Cell> = [.vertical, .northEast, .northWest, .animal]
  static let southConnectors: Set<Cell> = [.vertical, .southEast, .southWest, .animal]
  static let eastConnectors: Set<Cell> = [.horizontal, .northEast, .southEast, .animal]
  static let westConnectors: Set<Cell> = [.horizontal, .northWest, .southWest, .animal]

  func canConnect(to otherCell: Cell, direction: Direction) -> Bool {
    switch direction {
    case .north: Self.northConnectors.contains(self) && Self.southConnectors.contains(otherCell)
    case .east: Self.eastConnectors.contains(self) && Self.westConnectors.contains(otherCell)
    case .south: Self.southConnectors.contains(self) && Self.northConnectors.contains(otherCell)
    case .west: Self.westConnectors.contains(self) && Self.eastConnectors.contains(otherCell)
    }
  }
}

enum Direction {
  case north, east, south, west
}
