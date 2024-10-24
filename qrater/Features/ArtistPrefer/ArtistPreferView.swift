import SwiftUI

struct ArtistPreferView: View {
    @State private var viewModel = ArtistPreferViewModel()
    
    @EnvironmentObject private var spotifyManager: SpotifyManager
    
    var body: some View {
        ZStack {
            Color.background.ignoresSafeArea()
            
            ScrollView {
                VStack {
                    Text("Choose three artists you like")
                        .font(.system(size: 25))
                        .bold()
                        .foregroundStyle(Color.white)
                    
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(Color.white)
                        
                        TextField(
                            "Search by name",
                            text: $viewModel.searchText,
                            onCommit: {
                                Task {
                                    viewModel.onCommit()
                                    let artists = await spotifyManager.seachArtist(keyword: viewModel.searchText)
                                    viewModel.onSearchFinished(artists: artists)
                                }
                            }
                        )
                    }
                    .font(.headline)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color.gray)
                    )
                    
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]) {
                        ForEach(viewModel.artists) { artist in
                            Button {
                                viewModel.tapArtist(artist)
                            } label: {
                                VStack {
                                    AsyncImage(url: URL(string: artist.images?.first?.url ?? "")) { image in
                                        image
                                            .resizable()
                                            .scaledToFit()
                                    } placeholder: {
                                        Rectangle()
                                            .fill(Color.white)
                                    }
                                    .frame(width: 100, height: 100)
                                    .clipShape(Circle())
                                    .padding(.horizontal, 5)
                                    .padding(.top, 20)
                                    .padding(.bottom,10)
                                    
                                    Text(artist.name ?? "")
                                        .font(.system(size: 20))
                                        .bold()
                                        .foregroundStyle(Color.white)
                                }
                            }
                        }
                    }
                }
                .padding()
            }
            .onDisappear {
                viewModel.onDisappear()
            }
            
            if viewModel.isLoading {
                Color.black.opacity(0.5)
                    .ignoresSafeArea()
                
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
            }
        }
    }
}


#Preview {
    ArtistPreferView()
}
