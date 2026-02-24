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
                    HStack {
                        Spacer()
                        BoardSizeToggle(selectedSize: $viewModel.boardSize)
                            .padding(.trailing, 24)
                            .padding(.top, 16)
                    }

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

private struct BoardSizeToggle: View {
    @Binding var selectedSize: BoggleBoardSize

    var body: some View {
        Picker("Board size", selection: $selectedSize) {
            ForEach(BoggleBoardSize.allCases) { size in
                Text(size.title).tag(size)
            }
        }
        .pickerStyle(.segmented)
        .frame(width: 160)
        .padding(6)
        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 14, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: 14, style: .continuous)
                .stroke(Color.white.opacity(0.65), lineWidth: 1)
        )
        .shadow(color: Color.black.opacity(0.18), radius: 10, x: 0, y: 5)
        .accessibilityLabel("Board size")
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
