import Foundation

struct Day06: AdventDay {
  let data: String

  var lines: [String] {
    data
      .trimmingCharacters(in: .newlines)
      .components(separatedBy: .newlines)
  }

  // MARK: - Part 1

  func part1() throws -> Any {
    let parsedLines = try lines.map {
      let splitLine = $0.components(separatedBy: ":")
      guard splitLine.count == 2 else { throw ParseError() }
      return splitLine[1]
        .components(separatedBy: .whitespaces)
        .filter { !$0.allSatisfy { $0.isWhitespace } }
        .map { Int($0.trimmingCharacters(in: .whitespaces))! }
    }

    guard parsedLines.count == 2 else { throw ParseError() }
    var counters: [Int] = []
    for (time, recordDistance) in zip(parsedLines[0], parsedLines[1]) {
      var counter = 0
      for milliseconds in (0...time) {
        if (time - milliseconds) * milliseconds > recordDistance {
          counter += 1
        }
      }
      counters.append(counter)
    }

    return counters.reduce(1, *)
  }

  // MARK: - Part 2

  func part2() throws -> Any {
    let parsedLines = try lines.map {
      let splitLine = $0.components(separatedBy: ":")
      guard splitLine.count == 2 else { throw ParseError() }
      let number = splitLine[1]
        .components(separatedBy: .whitespaces)
        .filter { !$0.allSatisfy { $0.isWhitespace } }
        .map { $0.trimmingCharacters(in: .whitespaces) }
        .joined()
      return Int(number)!
    }

    guard parsedLines.count == 2 else { throw ParseError() }

    let time = parsedLines[0]
    let recordDistance = parsedLines[1]

    var counter = 0
    for milliseconds in (0...time) {
      if (time - milliseconds) * milliseconds > recordDistance {
        counter += 1
      }
    }

    return counter
  }

  struct ParseError: Error { }
}
