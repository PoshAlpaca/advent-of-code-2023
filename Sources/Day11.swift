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
    shortestPathSum(expansionFactor: 2)
  }

  // MARK: - Part 2

  func part2() -> Any {
    shortestPathSum(expansionFactor: 1_000_000)
  }

  // MARK: - Helpers

  func shortestPathSum(expansionFactor: Int) -> Int {
    let expansions = grid.expansions
    let galaxies = grid.galaxyLocations.map { row, column in
      let rowExpansions = expansions.rows.filter { $0 < row }.count
      let columnExpansions = expansions.columns.filter { $0 < column }.count
      return (
        row: row + rowExpansions * (expansionFactor - 1),
        column: column + columnExpansions * (expansionFactor - 1)
      )
    }

    var sum = 0
    for galaxyPair in galaxies.combinations(ofCount: 2) {
      let rowDiff = galaxyPair[1].row - galaxyPair[0].row
      let columnDiff = galaxyPair[1].column - galaxyPair[0].column
      let diff = abs(rowDiff) + abs(columnDiff)
      sum += diff
    }

    return sum
  }
}


private extension [[Character]] {
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

  var expansions: (rows: [Int], columns: [Int]) {
    var rowsToExpand: [Int] = []
    for rowIndex in self.indices {
      if self[rowIndex].allSatisfy({ $0 == "." }) {
        rowsToExpand.append(rowIndex)
      }
    }

    var columnsToExpand: [Int] = []
    for columnIndex in self[0].indices {
      if self.indices.allSatisfy({ self[$0][columnIndex] == "." }) {
        columnsToExpand.append(columnIndex)
      }
    }

    return (rowsToExpand, columnsToExpand)
  }
}
