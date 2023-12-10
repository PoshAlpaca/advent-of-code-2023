import Algorithms
import Foundation

struct Day10: AdventDay {
  let grid: [[Character]]

  init(data: String) {
    self.grid = data
      .trimmingCharacters(in: .newlines)
      .components(separatedBy: .newlines)
      .map { $0.map { $0 } }
  }

  // MARK: - Part 1

  func part1() -> Any {
    guard let start = grid.animalLocation else { fatalError("No animal in grid.") }

    var previousCell: (row: Int, column: Int) = (0, 0)
    var currentCell: (row: Int, column: Int) = start
    var counter = 0

    while true {
      let connectedCells = connectedCells(for: currentCell, in: grid)

      for (_, cell) in connectedCells where previousCell.row != cell.row || previousCell.column != cell.column {
        previousCell = currentCell
        currentCell = cell
        break
      }

      counter += 1

      if currentCell.row == start.row && currentCell.column == start.column {
        break
      }
    }

    return counter / 2
  }

  // MARK: - Part 2

  func part2() -> Any {
    var grid = self.grid
    cleanUp(grid: &grid)

    var inside = false
    var directionMode: Direction? = nil

    for i in grid.indices {
      for j in grid[i].indices {
        let cell = Cell(rawValue: grid[i][j])!
        switch cell {
        case .vertical:
          inside.toggle()
        case .ground where !inside:
          grid[i][j] = "O"
        case .ground where inside:
          grid[i][j] = "I"
        case .northWest where directionMode == .south: // F-J
          inside.toggle()
        case .southWest where directionMode == .north: // L-7
          inside.toggle()
        case .northEast: // L
          directionMode = .north
        case .southEast: // F
          directionMode = .south
        default:
          break
        }
      }
    }

    var count = 0
    for line in grid {
      for char in line {
        if char == "I" {
          count += 1
        }
      }
    }

    return count
  }

  func cleanUp(grid: inout [[Character]]) {
    guard let start = grid.animalLocation else { fatalError() }

    var pipeMask: [[Bool]] = Array(repeating: Array(repeating: false, count: grid[0].count), count: grid.count)

    var lastCell: (row: Int, column: Int) = (0, 0)
    var currentCell: (row: Int, column: Int) = start

    while true {
      let connected = connectedCells(for: currentCell, in: grid)

      for (_, cell) in connected where lastCell.row != cell.row || lastCell.column != cell.column {
        lastCell = currentCell
        currentCell = cell
        break
      }

      pipeMask[currentCell.row][currentCell.column] = true

      if currentCell.row == start.row && currentCell.column == start.column {
        break
      }
    }

    let directions = connectedCells(for: start, in: grid).map(\.direction)
    let startCell = Cell.inferred(fromConnections: directions)
    grid[start.row][start.column] = startCell.rawValue

    for i in grid.indices {
      for j in grid[i].indices {
        if !pipeMask[i][j] {
          grid[i][j] = "."
        }
      }
    }
  }
}

func connectedCells(for cell: (row: Int, column: Int), in grid: [[Character]]) -> [(direction: Direction, cell: (row: Int, column: Int))] {
  let adjacent = adjacentCells(for: cell, in: grid)

  let currentCell = Cell(rawValue: grid[cell.row][cell.column])!

  var cells: [(direction: Direction, cell: (row: Int, column: Int))] = []
  for (direction, otherCell) in adjacent {
    if currentCell.canConnect(to: Cell(rawValue: grid[otherCell.row][otherCell.column])!, direction: direction) {
      cells.append((direction, otherCell))
    }
  }

  return cells
}

func adjacentCells(for cell: (row: Int, column: Int), in grid: [[Character]]) -> [(direction: Direction, cell: (row: Int, column: Int))] {
  [
    (.north, (cell.row - 1, cell.column)),
    (.south, (cell.row + 1, cell.column)),
    (.west, (cell.row, cell.column - 1)),
    (.east, (cell.row, cell.column + 1)),
  ].filter { grid.indices.contains($1.row) && grid[0].indices.contains($1.column) }
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

  private static let northConnectors: Set<Cell> = [.vertical, .northEast, .northWest, .animal]
  private static let southConnectors: Set<Cell> = [.vertical, .southEast, .southWest, .animal]
  private static let eastConnectors: Set<Cell> = [.horizontal, .northEast, .southEast, .animal]
  private static let westConnectors: Set<Cell> = [.horizontal, .northWest, .southWest, .animal]

  var isNorthConnector: Bool {
    Self.northConnectors.contains(self)
  }

  var isSouthConnector: Bool {
    Self.southConnectors.contains(self)
  }

  var isEastConnector: Bool {
    Self.eastConnectors.contains(self)
  }

  var isWestConnector: Bool {
    Self.westConnectors.contains(self)
  }

  func canConnect(to otherCell: Cell, direction: Direction) -> Bool {
    switch direction {
    case .north: self.isNorthConnector && otherCell.isSouthConnector
    case .east: self.isEastConnector && otherCell.isWestConnector
    case .south: self.isSouthConnector && otherCell.isNorthConnector
    case .west: self.isWestConnector && otherCell.isEastConnector
    }
  }
}

extension Cell {
  static func inferred(fromConnections directions: [Direction]) -> Cell {
    switch Set(directions) {
    case [.north, .south]: .vertical
    case [.east, .west]: .horizontal
    case [.north, .east]: .northEast
    case [.north, .west]: .northWest
    case [.south, .east]: .southEast
    case [.south, .west]: .southWest
    default: fatalError("Unsupported set of directions: \(directions).")
    }
  }
}

enum Direction {
  case north, east, south, west
}

extension [[Character]] {
  var prettyPrinted: String {
    self.map { String($0) }.joined(separator: "\n")
  }
}

extension [[Character]] {
  var animalLocation: (row: Int, column: Int)? {
    for i in self.indices {
      for j in self[i].indices {
        if self[i][j] == Cell.animal.rawValue {
          return (i, j)
        }
      }
    }

    return nil
  }
}
