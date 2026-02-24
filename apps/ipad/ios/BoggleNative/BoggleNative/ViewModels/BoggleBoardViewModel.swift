import Foundation
import Combine
import SwiftUI

@MainActor
final class BoggleBoardViewModel: ObservableObject {
    @Published private(set) var tiles: [BoggleTile] = []
    @Published private(set) var boardSize: BoggleBoardSize = .fourByFour
    @Published private(set) var isModeSwitching: Bool = false
    @Published private(set) var shuffleRotation: Double = 0

    var gridDimension: Int {
        BoggleBoardGenerator.gridDimension(for: tiles.count)
    }

    init() {
        shuffleBoard()
    }

    func shuffleBoard() {
        tiles = BoggleBoardGenerator.generateBoard(for: boardSize)
    }

    func setBoardSize(_ newSize: BoggleBoardSize) {
        guard newSize != boardSize, !isModeSwitching else { return }

        let halfDuration: TimeInterval = 0.20
        let halfDurationNanos = UInt64(halfDuration * 1_000_000_000)

        isModeSwitching = true

        withAnimation(.easeInOut(duration: halfDuration)) {
            shuffleRotation = -5
        }

        Task { @MainActor in
            try? await Task.sleep(nanoseconds: halfDurationNanos)

            boardSize = newSize
            shuffleBoard()

            withAnimation(.easeInOut(duration: 0.08)) {
                shuffleRotation = 5
            }
            try? await Task.sleep(nanoseconds: 80_000_000)

            withAnimation(.easeInOut(duration: halfDuration)) {
                isModeSwitching = false
                shuffleRotation = 0
            }
        }
    }
}
