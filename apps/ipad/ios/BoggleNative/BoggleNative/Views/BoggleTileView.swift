import SwiftUI

struct BoggleTileView: View {
    let tile: BoggleTile
    let usesQuDigraph: Bool

    var body: some View {
        GeometryReader { geo in
            let side = geo.size.width
            let corner = side * 0.13
            let displayLetter = usesQuDigraph && tile.letter == "Q" ? "Qu" : tile.letter
            let hasDigraph = displayLetter.count > 1

            ZStack {
                // Bottom/front side to make each tile read as raised plastic.
                RoundedRectangle(cornerRadius: corner * 0.7, style: .continuous)
                    .fill(
                        LinearGradient(
                            colors: [Color.black.opacity(0.16), Color.black.opacity(0.03)],
                            startPoint: .top,
                            endPoint: .bottom
                        )
                    )
                    .scaleEffect(x: 0.86, y: 0.10)
                    .offset(y: side * 0.44)

                // Right side for subtle 3D depth.
                RoundedRectangle(cornerRadius: corner * 0.7, style: .continuous)
                    .fill(
                        LinearGradient(
                            colors: [Color.black.opacity(0.14), Color.black.opacity(0.03)],
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .scaleEffect(x: 0.10, y: 0.86)
                    .offset(x: side * 0.44)

                RoundedRectangle(cornerRadius: corner, style: .continuous)
                    .fill(
                        LinearGradient(
                            colors: [
                                Color.white,
                                Color(red: 0.98, green: 0.97, blue: 0.95),
                                Color(red: 0.94, green: 0.92, blue: 0.89)
                            ],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .overlay(
                        Ellipse()
                            .fill(
                                RadialGradient(
                                    colors: [Color.white.opacity(0.85), Color.clear],
                                    center: .topLeading,
                                    startRadius: 1,
                                    endRadius: side * 0.5
                                )
                            )
                            .padding(side * 0.08)
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: corner, style: .continuous)
                            .stroke(Color.white.opacity(0.70), lineWidth: 1)
                    )
                    .shadow(color: Color.black.opacity(0.20), radius: 7, x: 3, y: 5)
                    .shadow(color: Color.white.opacity(0.5), radius: 3, x: -2, y: -2)

                // Render Qu only in the 5x5 mode to preserve 4x4 behavior.
                Text(displayLetter)
                    .font(.system(size: hasDigraph ? side * 0.44 : side * 0.56, weight: .black, design: .rounded))
                    .foregroundStyle(Color(red: 0.02, green: 0.14, blue: 0.32))
                    .rotationEffect(.degrees(tile.rotation))
                    .shadow(color: Color.white.opacity(0.3), radius: 0.5, x: 0, y: -0.5)
            }
            .padding(side * 0.08)
        }
        .aspectRatio(1, contentMode: .fit)
    }
}
