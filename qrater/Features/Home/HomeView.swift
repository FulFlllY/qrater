import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = HomeViewModel()
    
    @EnvironmentObject private var spotifyManager: SpotifyManager
    
    var body: some View {
        NavigationStack (path: $viewModel.path) {
            ZStack {
                Color.background.ignoresSafeArea()
                
                VStack {
                    Text("Welcome listener!")
                        .font(.system(size: 35))
                        .bold()
                        .padding(.top, 60.0)
                        .foregroundStyle(Color.white)
                    
                    Button {
                        viewModel.push(StackView(type: .inquiryView))
                    } label: {
                        Image("MainButton")
                            .resizable()
                            .frame(width: 300.0, height: 300.0) //크기 (너비 높이) 변경
                            .clipShape(.circle) //중요
                            .padding(.top)
                    }
                    
                    Text("Touch to find your music")
                        .font(.system(size: 20))
                        .bold()
                        .foregroundStyle(Color.white)
                        .padding() //앞뒤앙옆 디폴트로 16으로 들감
                    
                    VStack(spacing: 16) { //각 원소마다 자동으로 간격 넣어줌. 기본 값 8
                        HStack {
                            Text("Artist Preference")
                                .font(.system(size: 18))
                                .fontWeight(.bold)
                                .foregroundColor(Color.white)
                                .padding(.leading)
                            
                            Spacer()
                            
                            Button {
                                viewModel.push(StackView(type: .artistView))
                            } label: {
                                Image(systemName: "square.and.pencil")
                                    .resizable()
                                    .frame(width: 25.0, height: 25.0)
                                    .foregroundStyle(Color.white)
                            }
                            .padding(.trailing)
                        }
                        .padding(.top)
                        
                        HStack {
                            ForEach(0..<4) { index in
                                if (index < viewModel.preferArtists.count) {
                                    SelectedArtistView(
                                        artistID: viewModel.preferArtists[index].id,
                                        artistName: viewModel.preferArtists[index].name,
                                        imageURL: viewModel.preferArtists[index].imageURL
                                    )
                                } else {
                                    SelectedArtistView(
                                        artistID: nil,
                                        artistName: nil,
                                        imageURL: nil
                                    )
                                }
                            }
                        }
                        .padding(.horizontal)
                        .padding(.bottom)
                    }
                    .background(
                        Rectangle()
                            .stroke(.gray.opacity(0.2),lineWidth: 4)
                    )
                    .padding(.top, 20)
                    .padding(.horizontal, 30)
                    
                    Spacer()
                }
                .onAppear {
                    spotifyManager.authorize()
                    viewModel.onAppear()
                }
                
                CurateHistoryView(path: $viewModel.path, playlists: $viewModel.playlists)
            }
            .navigationDestination(for: StackView.self) { stackView in
                switch stackView.type {
                case .inquiryView:
                    InquiryView(path: $viewModel.path)
                case .resultView:
                    ResultView(path: $viewModel.path, playlist: stackView.playlist!)
                case .curateView:
                    CurateView(music: stackView.music!)
                case .artistView:
                    ArtistPreferView()
                }
            }
        }
    }
}

#Preview {
    HomeView()
}
