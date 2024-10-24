import SwiftUI

struct CurateHistoryView: View {
    @State private var viewState = CGSize.zero
    @State private var viewOffset = CGFloat(600) // Starting position at the bottom
    
    private let minHeight: CGFloat = 100
    private let maxHeight: CGFloat = 600
    private let images = ["PinkBooby", "SkyBlueBooby", "WhiteBooby", "YellowBooby", "YellowGreenBooby"]
    
    @Binding private var path: [StackView]
    @Binding private var playlists: [Playlist]
    
    private var dateFormatter: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        return dateFormatter
    }
    
    init(path: Binding<[StackView]>, playlists: Binding<[Playlist]>) {
        _path = path
        _playlists = playlists
        _viewOffset = State(initialValue: UIScreen.main.bounds.height - minHeight)
    }
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Spacer()
                
                handleBar
                
                Text("Recent Searches").bold().foregroundColor(Color.white)
                    .font(.system(size: 23))
                    .padding(.trailing, 160)
                    .padding(.top, 10)
                
                ScrollView {
                    content
                }
            }
            .frame(width: geometry.size.width, height: maxHeight, alignment: .top)
            .background(Color.gray)
            .cornerRadius(20)
            .shadow(radius: 5).foregroundStyle(Color.white)
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
            .foregroundColor(Color.white)
            .cornerRadius(10)
            .padding(5)
    }
    
    var content: some View {
        VStack {
            ForEach(0..<playlists.count, id: \.self) { index in
                Button {
                    path.append(StackView(type: .resultView, playlist: playlists[index]))
                } label: {
                    HStack(spacing: 0) {
                        Image(images[(index % images.count)])
                            .resizable()
                            .frame(width: 70, height: 70)
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text(playlists[index].mood?.whatDo ?? "")
                                .bold()
                                .font(.system(size: 17))
                                .foregroundStyle(Color.black)
                            
                            Text("Searched: \(dateFormatter.string(from: playlists[index].createAt))")
                                .font(.system(size: 14))
                                .foregroundStyle(Color.black)
                        }
                    }
                    .padding()
                    
                    Spacer(minLength: 0)
                }
                .background(
                    Rectangle().foregroundStyle(Color.white)
                )
                .cornerRadius(10)
                .padding(.bottom, 20)
                .padding(.horizontal, 30)
            }
        }
    }
}

#Preview {
    CurateHistoryView(path: .constant([]), playlists: .constant([]))
}
