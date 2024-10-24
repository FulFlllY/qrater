import SwiftUI

struct SelectedArtistView: View {
    private let artistID: String?
    private let artistName: String?
    private let imageURL: String?
    
    init(artistID: String?, artistName: String?, imageURL: String?) {
        self.artistID = artistID
        self.artistName = artistName
        self.imageURL = imageURL
    }
    
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: imageURL ?? "")) { image in
                image
                    .resizable()
                    .scaledToFit()
            } placeholder: {
                Rectangle()
                    .fill(Color.black)
            }
            .frame(width: 50, height: 50)
            .clipShape(Circle())
            .padding(.bottom, 5)
            
            Text(artistName ?? "-")
                .font(.system(size: 12))
                .foregroundColor(Color.white)
        }
    }
}
