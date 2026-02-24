import Foundation

enum BoggleBoardGenerator {
    static let allowedRotations: [Double] = [0, 90, 180, 270]

    // One generation pipeline is reused for both board sizes.
    static func generateBoard(for boardSize: BoggleBoardSize) -> [BoggleTile] {
        generateBoard(using: boardSize.dice)
    }

    static func generateBoard(using dice: [BoggleDie]) -> [BoggleTile] {
        let shuffledDice = dice.shuffled()

        return shuffledDice.map { die in
            let letter = die.faces.randomElement() ?? "?"
            let rotation = allowedRotations.randomElement() ?? 0
            return BoggleTile(letter: letter, rotation: rotation)
        }
    }

    // Grid dimension is derived from dice/tile count (16 -> 4, 25 -> 5).
    static func gridDimension(for tileCount: Int) -> Int {
        let root = Int(Double(tileCount).squareRoot())
        return root * root == tileCount ? root : 4
    }
}
