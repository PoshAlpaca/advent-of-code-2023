import Algorithms
import Foundation

struct Day11: AdventDay {
  let grid: [[Character]]

  init(data: String) {
    self.grid = data
      .trimmingCharacters(in: .newlines)
      .components(separatedBy: .newlines)
      .map { $0.map { $0 } }
  }

  // MARK: - Part 1

  func part1() -> Any {
    var grid = grid
    print(grid.map { $0.allSatisfy({ $0 == "." })})
    expand(grid: &grid)

    let galaxies = Array(grid.galaxyLocations.enumerated())

    let galaxyPairs = galaxies.combinations(ofCount: 2)
    let distances = galaxyPairs.map { galaxyPair -> (Int, Int, Int) in
      let rowDiff: Int = galaxyPair[1].element.row - galaxyPair[0].element.row
      let columnDiff: Int = galaxyPair[1].element.column - galaxyPair[0].element.column
      let diff: Int = abs(rowDiff) + abs(columnDiff)

      return (galaxyPair[0].offset + 1, galaxyPair[1].offset + 1, diff)
    }

    return distances.map(\.2).reduce(0, +)
  }

  // MARK: - Part 2

  func part2() -> Any {
    "Todo"
  }

  func expand(grid: inout [[Character]]) {
    var rowsToExpand: [Int] = []
    for rowIndex in grid.indices {
      if grid[rowIndex].allSatisfy({ $0 == "." }) {
        rowsToExpand.append(rowIndex)
      }
    }

    while let rowIndex = rowsToExpand.popLast() {
      grid.insert(Array(repeating: ".", count: grid[rowIndex].count), at: rowIndex)
    }

    var columnsToExpand: [Int] = []
    for columnIndex in grid[0].indices {
      if grid.indices.allSatisfy({ grid[$0][columnIndex] == "." }) {
        columnsToExpand.append(columnIndex)
      }
    }

    while let columnIndex = columnsToExpand.popLast() {
      for rowIndex in grid.indices {
        grid[rowIndex].insert(".", at: columnIndex)
      }
    }
  }
}


extension [[Character]] {
  var galaxyLocations: [(row: Int, column: Int)] {
    var locations: [(row: Int, column: Int)] = []
    for rowIndex in self.indices {
      for columnIndex in self[rowIndex].indices {
        if self[rowIndex][columnIndex] == "#" {
          locations.append((rowIndex, columnIndex))
        }
      }
    }
    return locations
  }
}
