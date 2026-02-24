import Foundation
import Combine

final class BoggleBoardViewModel: ObservableObject {
    @Published private(set) var tiles: [BoggleTile] = []

    private let dice = BoggleDiceSet.standard4x4

    init() {
        shuffleBoard()
    }

    func shuffleBoard() {
        tiles = BoggleBoardGenerator.generateBoard(using: dice)
    }
}
