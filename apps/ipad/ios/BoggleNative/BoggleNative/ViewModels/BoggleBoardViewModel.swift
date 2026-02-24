import Foundation
import Combine

final class BoggleBoardViewModel: ObservableObject {
    @Published private(set) var tiles: [BoggleTile] = []
    @Published var boardSize: BoggleBoardSize = .fourByFour {
        didSet {
            if oldValue != boardSize {
                shuffleBoard()
            }
        }
    }

    var gridDimension: Int {
        BoggleBoardGenerator.gridDimension(for: tiles.count)
    }

    init() {
        shuffleBoard()
    }

    func shuffleBoard() {
        tiles = BoggleBoardGenerator.generateBoard(for: boardSize)
    }
}
