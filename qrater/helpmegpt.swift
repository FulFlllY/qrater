import Foundation
import OpenAI
import SwiftUI
import RealmSwift


struct ContentView2: View {
    @Environment(\.realm) var realm
    
    @State var text = "Test"
    
    let viewModel = ContentViewModel()
    
    var body: some View {
        VStack {
            Text(text)
        }
        .task {
            text = await viewModel.testQuery()
        }
    }
}

#Preview {
    ContentView2()
}
