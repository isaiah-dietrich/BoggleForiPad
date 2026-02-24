import SwiftUI

struct BoggleBoardView: View {
    let tiles: [BoggleTile]
    let containerSize: CGSize

    private let columns = Array(repeating: GridItem(.flexible(), spacing: 12), count: 4)

    var body: some View {
        // Layout scaling decisions:
        // Keep board square and size it from the shorter edge so landscape iPads
        // consistently preserve the physical tray proportions.
        let boardSide = min(containerSize.width * 0.82, containerSize.height * 0.90)

        ZStack {
            RoundedRectangle(cornerRadius: boardSide * 0.06, style: .continuous)
                .fill(
                    LinearGradient(
                        colors: [
                            Color(red: 0.05, green: 0.31, blue: 0.52),
                            Color(red: 0.03, green: 0.20, blue: 0.37),
                            Color(red: 0.02, green: 0.13, blue: 0.25)
                        ],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .overlay(
                    RoundedRectangle(cornerRadius: boardSide * 0.06, style: .continuous)
                        .stroke(Color.white.opacity(0.08), lineWidth: 1)
                )
                .shadow(color: Color.black.opacity(0.26), radius: 30, x: 7, y: 15)
                .shadow(color: Color.black.opacity(0.12), radius: 8, x: -3, y: -2)

            LazyVGrid(columns: columns, spacing: boardSide * 0.018) {
                ForEach(tiles) { tile in
                    BoggleTileView(tile: tile)
                        .aspectRatio(1, contentMode: .fit)
                }
            }
            .padding(boardSide * 0.048)
        }
        .frame(width: boardSide, height: boardSide)
    }
}
