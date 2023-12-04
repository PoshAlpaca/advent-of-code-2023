import Collections
import Foundation

struct Day04: AdventDay {
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
      let components = line.components(separatedBy: ":")
      guard components.count == 2 else { return "Wrong" }
      let numbers = components[1]
      let numberComponents = numbers.components(separatedBy: "|")
      guard numberComponents.count == 2 else { return "Wrong" }
      let winningNumbersString = numberComponents[0].trimmingCharacters(in: .whitespaces)
      let ourNumbersString = numberComponents[1].trimmingCharacters(in: .whitespaces)

      let winningNumbers = winningNumbersString
        .components(separatedBy: .whitespaces)
        .compactMap { Int($0.trimmingCharacters(in: .whitespaces)) }
      let ourNumbers = ourNumbersString
        .components(separatedBy: .whitespaces)
        .compactMap { Int($0.trimmingCharacters(in: .whitespaces)) }

      let count = Set(winningNumbers).intersection(Set(ourNumbers)).count
      let power = Int(pow(Double(2), Double(count - 1)))

      sum += power
    }

    return sum
  }

  // MARK: - Part 2

  func part2() -> Any {
    var scratchCards: [Int] = []

    for line in lines {
      let components = line.components(separatedBy: ":")
      guard components.count == 2 else { return "Wrong" }
      let cardString = components[0]

      let numbers = components[1]
      let numberComponents = numbers.components(separatedBy: "|")
      guard numberComponents.count == 2 else { return "Wrong" }
      let winningNumbersString = numberComponents[0].trimmingCharacters(in: .whitespaces)
      let ourNumbersString = numberComponents[1].trimmingCharacters(in: .whitespaces)

      let winningNumbers = winningNumbersString
        .components(separatedBy: .whitespaces)
        .compactMap { Int($0.trimmingCharacters(in: .whitespaces)) }
      let ourNumbers = ourNumbersString
        .components(separatedBy: .whitespaces)
        .compactMap { Int($0.trimmingCharacters(in: .whitespaces)) }

      let count = Set(winningNumbers).intersection(Set(ourNumbers)).count

      scratchCards.append(count)
    }

    var cardsToProcess: [Int] = []
    var processedCards = 0

    cardsToProcess = scratchCards.indices.reversed().map { $0 + 1 }

    while let card = cardsToProcess.popLast() {
      let amount = scratchCards[card - 1]
      if amount > 0 {
        for copiedCard in (card + 1)...(card + amount) {
          cardsToProcess.append(copiedCard)
        }
      }
      processedCards += 1
    }


    return processedCards
  }
}
