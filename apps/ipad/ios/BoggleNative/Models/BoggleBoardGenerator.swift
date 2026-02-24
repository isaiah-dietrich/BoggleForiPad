import Foundation

enum BoggleBoardGenerator {
    static let allowedRotations: [Double] = [0, 90, 180, 270]

    static func generateBoard(using dice: [BoggleDie]) -> [BoggleTile] {
        // Dice shuffling logic:
        // Shuffle the 16 dice so their board positions are unbiased each round.
        let shuffledDice = dice.shuffled()

        return shuffledDice.map { die in
            // Letter selection logic:
            // Pick one random face from the current die, equivalent to rolling it.
            let letter = die.faces.randomElement() ?? "?"

            // Letter rotation logic:
            // Rotate each tile to one of the four cardinal orientations.
            let rotation = allowedRotations.randomElement() ?? 0

            return BoggleTile(letter: letter, rotation: rotation)
        }
    }
}
