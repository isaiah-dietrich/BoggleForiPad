import SwiftUI

struct ShuffleButton: View {
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Image(systemName: "shuffle")
                .font(.system(size: 22, weight: .bold))
                .foregroundStyle(Color(red: 0.03, green: 0.22, blue: 0.43))
                .frame(width: 54, height: 54)
                .background(.ultraThinMaterial, in: Circle())
                .overlay(
                    Circle()
                        .stroke(Color.white.opacity(0.65), lineWidth: 1)
                )
                .shadow(color: Color.black.opacity(0.25), radius: 12, x: 0, y: 6)
        }
        .buttonStyle(.plain)
        .accessibilityLabel("Shuffle board")
    }
}
