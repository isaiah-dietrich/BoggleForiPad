import Foundation

struct BoggleDie: Hashable {
    let faces: [String]
}

enum BoggleBoardSize: Int, CaseIterable, Identifiable {
    case fourByFour = 4
    case fiveByFive = 5

    var id: Int { rawValue }

    var title: String {
        switch self {
        case .fourByFour:
            return "4x4"
        case .fiveByFive:
            return "5x5"
        }
    }

    var dice: [BoggleDie] {
        switch self {
        case .fourByFour:
            return BoggleDiceSet.standard4x4
        case .fiveByFive:
            return BoggleDiceSet.bigBoggle5x5
        }
    }
}

enum BoggleDiceSet {
    // Official 16 Boggle dice for classic 4x4.
    static let standard4x4: [BoggleDie] = [
        die("RIFOBX"),
        die("IFEHEY"),
        die("DENOWS"),
        die("UTOKND"),
        die("HMSRAO"),
        die("LUPETS"),
        die("ACTIOA"),
        die("YLGKUE"),
        die("QBMJOA"),
        die("EHISPN"),
        die("VETIGN"),
        die("BALIYT"),
        die("EZAVND"),
        die("RALESC"),
        die("UWILRG"),
        die("PACEMD")
    ]

    // Official 25 Big Boggle dice for 5x5.
    static let bigBoggle5x5: [BoggleDie] = [
        die("AAAFRS"), die("AAEEEE"), die("AAFIRS"), die("ADENNN"), die("AEEEEM"),
        die("AEEGMU"), die("AEGMNN"), die("AFIRSY"), die("BJKQXZ"), die("CCENST"),
        die("CEIILT"), die("CEILPT"), die("CEIPST"), die("DDHNOT"), die("DHHLOR"),
        die("DHLNOR"), die("DHLNOR"), die("EIIITT"), die("EMOTTT"), die("ENSSSU"),
        die("FIPRSY"), die("GORRVW"), die("IPRRRY"), die("NOOTUW"), die("OOOTTU")
    ]

    private static func die(_ faces: String) -> BoggleDie {
        BoggleDie(faces: faces.map { String($0) })
    }
}
