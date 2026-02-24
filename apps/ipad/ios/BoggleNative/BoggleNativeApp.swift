import SwiftUI

@main
struct BoggleNativeApp: App {
    @StateObject private var viewModel = BoggleBoardViewModel()

    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: viewModel)
                .statusBarHidden(true)
        }
    }
}
