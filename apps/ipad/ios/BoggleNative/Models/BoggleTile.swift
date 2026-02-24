import Foundation

struct BoggleTile: Identifiable, Hashable {
    let id = UUID()
    let letter: String
    let rotation: Double
}
