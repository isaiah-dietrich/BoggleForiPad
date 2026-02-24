import Foundation

struct BoggleDie: Hashable {
    let faces: [String]
}

enum BoggleDiceSet {
    // Official 16 Boggle dice used by the current web version.
    static let standard4x4: [BoggleDie] = [
        BoggleDie(faces: ["R", "I", "F", "O", "B", "X"]),
        BoggleDie(faces: ["I", "F", "E", "H", "E", "Y"]),
        BoggleDie(faces: ["D", "E", "N", "O", "W", "S"]),
        BoggleDie(faces: ["U", "T", "O", "K", "N", "D"]),
        BoggleDie(faces: ["H", "M", "S", "R", "A", "O"]),
        BoggleDie(faces: ["L", "U", "P", "E", "T", "S"]),
        BoggleDie(faces: ["A", "C", "T", "I", "O", "A"]),
        BoggleDie(faces: ["Y", "L", "G", "K", "U", "E"]),
        BoggleDie(faces: ["Q", "B", "M", "J", "O", "A"]),
        BoggleDie(faces: ["E", "H", "I", "S", "P", "N"]),
        BoggleDie(faces: ["V", "E", "T", "I", "G", "N"]),
        BoggleDie(faces: ["B", "A", "L", "I", "Y", "T"]),
        BoggleDie(faces: ["E", "Z", "A", "V", "N", "D"]),
        BoggleDie(faces: ["R", "A", "L", "E", "S", "C"]),
        BoggleDie(faces: ["U", "W", "I", "L", "R", "G"]),
        BoggleDie(faces: ["P", "A", "C", "E", "M", "D"])
    ]
}
