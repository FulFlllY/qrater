import SwiftUI

struct CurateView: View {
    @StateObject private var viewModel: CurateViewModel
    @EnvironmentObject private var spotifyManager: SpotifyManager
    
    init(music: Music) {
        _viewModel = StateObject(wrappedValue: CurateViewModel(music: music))
    }
    
    var body: some View {
        ZStack{
            Color.background.ignoresSafeArea()
            
            VStack (spacing: 0){
                ZStack {
                    AsyncImage(url: URL(string: viewModel.artist?.images?.first?.url ?? "")) { image in
                        image
                            .resizable()
                            .scaledToFit()
                    } placeholder: {
                        Rectangle()
                    }
                    .frame(width: 450, height: 400)
                    
                    VStack {
                        VStack (alignment: .trailing, spacing: 0){
                            Text("Curating")
                                .foregroundStyle(Color.black)
                                .padding(5)
                                .padding(.horizontal, 10)
                                .background(Color.white)
                                .cornerRadius(30)
                                .padding(.bottom, 20)
                            
                            VStack (alignment: .leading, spacing: 0){
                                Text(viewModel.music.name)
                                    .font(.system(size: 30))
                                    .bold()
                                    .foregroundStyle(Color.white)
                                
                                Text("by \(viewModel.music.artistName)")
                                    .font(.system(size: 20))
                                    .bold()
                                    .foregroundStyle(Color.white)
                            }
                        }
                        .padding(.leading, 170)
                    }
                }
                
                HStack{
                    AsyncImage(url: URL(string: viewModel.music.albumImageURL)) { image in
                        image
                            .resizable()
                            .scaledToFit()
                    } placeholder: {
                        Rectangle()
                            .fill(Color.white)
                    }
                    .frame(width: 70, height: 70)
                    .padding(16)
                    
                    VStack (alignment: .leading){
                        Text(viewModel.music.name)
                            .font(.system(size: 20))
                            .bold()
                            .foregroundStyle(Color.white)
                        
                        Text("by \(viewModel.music.artistName)")
                            .font(.system(size: 15))
                            .bold()
                            .foregroundStyle(Color.white)
                    }
                    .padding(.trailing, 100)
                    
                    Button {
                        spotifyManager.play(uri: viewModel.music.uri)
                    } label: {
                        Image(systemName: "play")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30)
                            .foregroundStyle(Color.white)
                    }
                    .padding(.trailing, 40)
                    
                }
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.black)
                )
                
                ScrollView {
                    Text(viewModel.description ?? "")
                        .foregroundStyle(Color.black)
                        .font(.system(size: 20))
                        .bold()
                        .padding(.top, 20)
                        .padding(.horizontal, 30)
                        .ignoresSafeArea()
                }
                .background(Color.white)
                .padding(.horizontal, 50)
            }
            .task {
                let artist = await spotifyManager.requestArtistByID(viewModel.music.artistID)
                viewModel.finishedInit(artist: artist)
                
                await viewModel.getDescrip()
            }
        }
        .ignoresSafeArea()
    }
}

#Preview {
    CurateView(music: Music())
}
