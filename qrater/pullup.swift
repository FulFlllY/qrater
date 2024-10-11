import SwiftUI

struct PullUpHandleView: View {
    @State private var viewState = CGSize.zero
    @State private var viewOffset = CGFloat(600) // Starting position at the bottom
    let minHeight: CGFloat = 100
    let maxHeight: CGFloat = 600

    
    init() {

        _viewOffset = State(initialValue: UIScreen.main.bounds.height - minHeight)
    }
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Spacer()
                handleBar
                Text("Recent Searches").bold().foregroundColor(Color.black)
                    .font(.system(size: 20)).padding(.trailing, 180)
                    .padding()

                ScrollView {
                    content
                }
            }
            .frame(width: geometry.size.width, height: maxHeight, alignment: .top)
            .background(Color.white)
            .cornerRadius(20)
            .shadow(radius: 5)
            .offset(y: max(viewOffset + viewState.height, geometry.size.height - maxHeight))
            .gesture(
                DragGesture().onChanged { value in
                    viewState = value.translation
                }
                .onEnded { value in
                    let verticalMovement = value.translation.height
                    let newPosition = viewOffset + verticalMovement
                    if newPosition < geometry.size.height - maxHeight {
                        viewOffset = geometry.size.height - maxHeight
                    } else if newPosition > geometry.size.height - minHeight {
                        viewOffset = geometry.size.height - minHeight
                    } else {
                        viewOffset = newPosition
                    }
                    viewState = .zero
                }
            )
        }
        .edgesIgnoringSafeArea(.all)
    }

    var handleBar: some View {
        Rectangle()
            .frame(width: 40, height: 5)
            .foregroundColor(Color.gray)
            .cornerRadius(10)
            .padding(5)
    }

    var content: some View {
        VStack {
            ForEach(0..<50) { index in
                Text("Item \(index)")
                    .padding()
            }
        }
    }
}

struct PullUpHandleView_Previews: PreviewProvider {
    static var previews: some View {
        PullUpHandleView()
    }
}
