import Foundation

struct Day02: AdventDay {
  let data: String

  var lines: [String] {
    data
      .trimmingCharacters(in: .newlines)
      .components(separatedBy: .newlines)
  }

  // MARK: - Part 1

  func part1() -> Any {
    var sum = 0
    for line in lines {
      let x = line.components(separatedBy: ":")
      guard x.count == 2 else { return "Wrong" }
      let game = x[0]
      let cubeSets = x[1]

      let gameComponents = game.components(separatedBy: " ")
      guard gameComponents.count == 2 else { return "Wrong" }
      let gameID = Int(gameComponents[1])!

      let y = cubeSets.components(separatedBy: ";")

      var gamePossible = true
      for cubeSet in y {
        let z = cubeSet.components(separatedBy: ",")
        for cube in z {
          let trimmedcube = cube.trimmingCharacters(in: .whitespaces)
          let components = trimmedcube.components(separatedBy: " ")
          guard components.count == 2 else { return "Wrong" }
          let amount = Int(components[0])!
          let color = Color(rawValue: components[1])!

          if amount > color.maxAmount {
            gamePossible = false
          }
        }
      }

      if gamePossible {
        sum += gameID
      }
    }
    return sum
  }

  // MARK: - Part 2

  func part2() -> Any {
    var sum = 0
    for line in lines {
      let x = line.components(separatedBy: ":")
      guard x.count == 2 else { return "Wrong" }
      let game = x[0]
      let cubeSets = x[1]

      let gameComponents = game.components(separatedBy: " ")
      guard gameComponents.count == 2 else { return "Wrong" }
      let gameID = Int(gameComponents[1])!

      let y = cubeSets.components(separatedBy: ";")

      var minRed = 0
      var minGreen = 0
      var minBlue = 0
      for cubeSet in y {
        let z = cubeSet.components(separatedBy: ",")
        for cube in z {
          let trimmedcube = cube.trimmingCharacters(in: .whitespaces)
          let components = trimmedcube.components(separatedBy: " ")
          guard components.count == 2 else { return "Wrong" }
          let amount = Int(components[0])!
          let color = Color(rawValue: components[1])!

          switch color {
          case .red:
            minRed = max(minRed, amount)
          case .green:
            minGreen = max(minGreen, amount)
          case .blue:
            minBlue = max(minBlue, amount)
          }
        }
      }

      let power = minRed * minGreen * minBlue

      sum += power
    }
    return sum
  }
}


enum Color: String {
  case red, green, blue

  var maxAmount: Int {
    switch self {
    case .red:
      12
    case .green:
      13
    case .blue:
      14
    }
  }
}
