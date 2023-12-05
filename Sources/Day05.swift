import Foundation

struct Day05: AdventDay {
  let data: String

  // MARK: - Part 1

  func part1() -> Any {
    let splitDataString = data.components(separatedBy: "\n\n")

    var numbers: [Int] = []
    var deltas: [Range<Int>: Int] = [:]

    for infoMapString in splitDataString {
      let splitInfoMapString = infoMapString.components(separatedBy: ":")
      guard splitInfoMapString.count == 2 else { return "Boom" }
      let name = splitInfoMapString[0]
      let numbersString = splitInfoMapString[1].trimmingCharacters(in: .whitespacesAndNewlines)

      if name == "seeds" {
        numbers = numbersString.components(separatedBy: .whitespaces).map { Int($0)! }
      } else {
        let numbersLines = numbersString.components(separatedBy: .newlines)

        for line in numbersLines {
          let splitLine = line.components(separatedBy: .whitespaces).map { Int($0)! }
          guard splitLine.count == 3 else { return "Boom" }
          let destinationRangeStart = splitLine[0]
          let sourceRangeStart = splitLine[1]
          let rangeLength = splitLine[2]

          let sourceRange = sourceRangeStart..<(sourceRangeStart + rangeLength)

          deltas[sourceRange] = destinationRangeStart - sourceRangeStart
        }

        numbers = numbers.map { number in
          var newNumber = number
          for (range, delta) in deltas {
            if range.contains(number) {
              newNumber += delta
            }
          }

          return newNumber
        }
      }

      deltas.removeAll()
    }

    return numbers.min()!
  }

  // MARK: - Part 2

  func part2() -> Any {
    "Todo"
  }
}
