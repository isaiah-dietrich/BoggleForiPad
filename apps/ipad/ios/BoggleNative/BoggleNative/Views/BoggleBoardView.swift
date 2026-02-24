import SwiftUI

struct BoggleBoardView: View {
    let tiles: [BoggleTile]
    let containerSize: CGSize

    var body: some View {
        // Layout is driven from dice/tile count so 4x4 and 5x5 share one implementation.
        let gridDimension = BoggleBoardGenerator.gridDimension(for: tiles.count)
        let boardSide = min(containerSize.width * 0.86, containerSize.height * 0.90)
        let gridSpacing = boardSide * (gridDimension == 5 ? 0.014 : 0.018)
        let gridPadding = boardSide * (gridDimension == 5 ? 0.042 : 0.048)
        let columns = Array(repeating: GridItem(.flexible(), spacing: gridSpacing), count: gridDimension)
        let usesQuDigraph = gridDimension == 5

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

            LazyVGrid(columns: columns, spacing: gridSpacing) {
                ForEach(tiles) { tile in
                    BoggleTileView(tile: tile, usesQuDigraph: usesQuDigraph)
                        .aspectRatio(1, contentMode: .fit)
                }
            }
            .padding(gridPadding)
        }
        .frame(width: boardSide, height: boardSide)
    }
}
