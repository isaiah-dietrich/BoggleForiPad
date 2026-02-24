import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: BoggleBoardViewModel

    var body: some View {
        GeometryReader { geo in
            ZStack {
                WoodSurfaceBackground()
                    .ignoresSafeArea()

                BoggleBoardView(tiles: viewModel.tiles, containerSize: geo.size)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)

                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        ShuffleButton {
                            viewModel.shuffleBoard()
                        }
                        .padding(.trailing, 24)
                        .padding(.bottom, 18)
                    }
                }
            }
        }
    }
}

private struct WoodSurfaceBackground: View {
    var body: some View {
        LinearGradient(
            colors: [
                Color(red: 0.95, green: 0.89, blue: 0.80),
                Color(red: 0.89, green: 0.78, blue: 0.64),
                Color(red: 0.82, green: 0.67, blue: 0.52)
            ],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
        .overlay(
            RoundedRectangle(cornerRadius: 0)
                .fill(
                    LinearGradient(
                        colors: [
                            Color.white.opacity(0.10),
                            Color.clear,
                            Color.black.opacity(0.08)
                        ],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
        )
    }
}
