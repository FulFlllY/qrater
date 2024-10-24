import Foundation

@Observable
class ArtistPreferViewModel {
    var searchText = ""
    var artists: [Artist] = [
        Artist(
            id: "4Z8W4fKeB5YxbusRsdQVPb",
            name: "RadioHead",
            images: [
                ArtistImage(url: "https://i.scdn.co/image/ab6761610000e5eba03696716c9ee605006047fd")
            ]
        ),
        Artist(
            id: "0k17h0D3J5VfsdmQ1iZtE9",
            name: "Pink Floyd",
            images: [
                ArtistImage(url: "https://i.scdn.co/image/e69f71e2be4b67b82af90fb8e9d805715e0684fa")
            ]
        ),
        Artist(
            id: "1Mxqyy3pSjf8kZZL4QVxS0",
            name: "Frank Sinatra",
            images: [
                ArtistImage(url: "https://i.scdn.co/image/fc4e0f474fb4c4cb83617aa884dc9fd9822d4411")
            ]
        ),
        Artist(
            id: "19eLuQmk9aCobbVDHc6eek",
            name: "Louis Armstrong",
            images: [
                ArtistImage(url: "https://i.scdn.co/image/ab6772690000c46c4a0e9d5e55f9f3721c3243c5")
            ]
        ),
        Artist(
            id: "06HL4z0CvFAxyc27GXpf02",
            name: "Taylor Swift",
            images: [
                ArtistImage(url: "https://i.scdn.co/image/ab6761610000e5ebe672b5f553298dcdccb0e676")
            ]
        ),
        Artist(
            id: "36QJpDe2go2KgaRleHCDTp",
            name: "Led Zeppelin",
            images: [
                ArtistImage(url: "https://i.scdn.co/image/207803ce008388d3427a685254f9de6a8f61dc2e")
            ]
        ),
        Artist(
            id: "3fMbdgg4jU18AjLCKBhRSm",
            name: "Michael Jackson",
            images: [
                ArtistImage(url: "https://i.scdn.co/image/ab6761610000e5eb997cc9a4aec335d46c9481fd")
            ]
        ),
        Artist(
            id: "6tbjWDEIzxoDsBA1FuhfPW",
            name: "Madonna",
            images: [
                ArtistImage(url: "https://i.scdn.co/image/ab6761610000e5eb4b36d28b55620959821f4a5b")
            ]
        ),
        Artist(
            id: "6vWDO969PvNqNYHIOW5v0m",
            name: "Beyoncé",
            images: [
                ArtistImage(url: "https://i.scdn.co/image/ab6761610000e5eb247f44069c0bd1781df2f785")
            ]
        ),
        Artist(
            id: "1HY2Jd0NmPuamShAr6KMms",
            name: "Lady Gaga",
            images: [
                ArtistImage(url: "https://i.scdn.co/image/ab6761610000e5eb60f57316669a4ba12eb37b94")
            ]
        ),
        Artist(
            id: "26dSoYclwsYLMAKD3tpOr4",
            name: "Britney Spears",
            images: [
                ArtistImage(url: "https://i.scdn.co/image/ab6761610000e5eb3a49b0a3954e460a8a76ed90")
            ]
        ),
        Artist(
            id: "4iHNK0tOyZPYnBU7nGAgpQ",
            name: "Mariah Carey",
            images: [
                ArtistImage(url: "https://i.scdn.co/image/ab6761610000e5eb21b66418f7f3b86967f85bce")
            ]
        ),
        Artist(
            id: "5a2EaR3hamoenG9rDuVn8j",
            name: "Prince",
            images: [
                ArtistImage(url: "https://i.scdn.co/image/ab6761610000e5ebeaca358712b3fe4ed9814640")
            ]
        ),
        Artist(
            id: "5pKCCKE2ajJHZ9KAiaK11H",
            name: "Rihanna",
            images: [
                ArtistImage(url: "https://i.scdn.co/image/e69f71e2be4b67b82af90fb8e9d805715e0684fa")
            ]
        ),
        Artist(
            id: "6jJ0s89eD6GaHleKKya26X",
            name: "Katy Perry",
            images: [
                ArtistImage(url: "https://i.scdn.co/image/ab6761610000e5eb5e5f676a99a81dba06cc3db6")
            ]
        ),
        Artist(
            id: "3WrFJ7ztbogyGnTHbHJFl2",
            name: "The Beatles",
            images: [
                ArtistImage(url: "https://i.scdn.co/image/ab6761610000e5ebe9348cc01ff5d55971b22433")
            ]
        ),
        Artist(
            id: "22bE4uQ6baNwSHPVcDxLCe",
            name: "The Rolling Stones",
            images: [
                ArtistImage(url: "https://i.scdn.co/image/ab6761610000e5ebe4cea917b68726aadb4854b8")
            ]
        ),
        Artist(
            id: "67ea9eGLXYMsO2eYQRui3w",
            name: "The Who",
            images: [
                ArtistImage(url: "https://i.scdn.co/image/9cd709cabb4a614b4f1dd9ec256a5f30e21f0150")
            ]
        ),
        Artist(
            id: "6olE6TJLqED3rqDCT0FyPh",
            name: "Nirvana",
            images: [
                ArtistImage(url: "https://i.scdn.co/image/84282c28d851a700132356381fcfbadc67ff498b")
            ]
        ),
        Artist(
            id: "1dfeR4HaWDbWqFHLkxsg1d",
            name: "Queen",
            images: [
                ArtistImage(url: "https://i.scdn.co/image/b040846ceba13c3e9c125d68389491094e7f2982")
            ]
        ),
        Artist(
            id: "776Uo845nYHJpNaStv1Ds4",
            name: "Jimi Hendrix",
            images: [
                ArtistImage(url: "https://i.scdn.co/image/ab6761610000e5eb31f6ab67e6025de876475814")
            ]
        ),
        Artist(
            id: "51Blml2LZPmy7TTiAg47vQ",
            name: "U2",
            images: [
                ArtistImage(url: "https://i.scdn.co/image/ab6761610000e5ebe62be215d2ee31bcd97edaba")
            ]
        ),
        Artist(
            id: "3eqjTLE0HfPfh78zjh6TqT",
            name: "Bruce Springsteen",
            images: [
                ArtistImage(url: "https://i.scdn.co/image/ab6761610000e5eb81df2fa2f937029ec986bbb8")
            ]
        ),
        Artist(
            id: "1ZwdS5xdxEREPySFridCfh",
            name: "2Pac",
            images: [
                ArtistImage(url: "https://i.scdn.co/image/ab6761610000e5eb7f5cc432c9c109248ebec1ac")
            ]
        ),
        Artist(
            id: "5me0Irg2ANcsgc93uaYrpb",
            name: "The Notorious B.I.G.",
            images: [
                ArtistImage(url: "https://i.scdn.co/image/1b4858fbd24046a81cace5ee18d19c868262b91f")
            ]
        ),
        Artist(
            id: "7dGJo4pcD2V6oG8kP0tJRR",
            name: "Eminem",
            images: [
                ArtistImage(url: "https://i.scdn.co/image/ab6761610000e5eba00b11c129b27a88fc72f36b")
            ]
        ),
        Artist(
            id: "3nFkdlSjzX9mRTtwJOzDYB",
            name: "JAY-Z",
            images: [
                ArtistImage(url: "https://i.scdn.co/image/ab6761610000e5ebc75afcd5a9027f60eaebb5e4")
            ]
        ),
        Artist(
            id: "5K4W6rqBFWDnAN6FQUkS6x",
            name: "Kanye West",
            images: [
                ArtistImage(url: "https://i.scdn.co/image/ab6761610000e5eb6e835a500e791bf9c27a422a")
            ]
        ),
        Artist(
            id: "20qISvAhX20dpIbOOzGK3q",
            name: "Nas",
            images: [
                ArtistImage(url: "https://i.scdn.co/image/ab6761610000e5eb153198caeef9e3bda92f9285")
            ]
        ),
        Artist(
            id: "6DPYiyq5kWVQS4RGwxzPC7",
            name: "Dr. Dre",
            images: [
                ArtistImage(url: "https://i.scdn.co/image/83d2489cade1dadcdc533ddbcd74993d0ca6d4cb")
            ]
        ),
        Artist(
            id: "2YZyLoL8N0Wb9xBt1NhZWg",
            name: "Kendrick Lamar",
            images: [
                ArtistImage(url: "https://i.scdn.co/image/ab6761610000e5eb437b9e2a82505b3d93ff1022")
            ]
        ),
        Artist(
            id: "55Aa2cqylxrFIXC767Z865",
            name: "Lil Wayne",
            images: [
                ArtistImage(url: "https://i.scdn.co/image/ab6761610000e5ebc1c08e541eae3cc82c6988c4")
            ]
        ),
        Artist(
            id: "1vCWHaC5f2uS3yhpwWbIA6",
            name: "Avicii",
            images: [
                ArtistImage(url: "https://i.scdn.co/image/ab6761610000e5ebae07171f989fb39736674113")
            ]
        ),
        Artist(
            id: "2qxJFvFYMEDqd7ui6kSAcq",
            name: "Zedd",
            images: [
                ArtistImage(url: "https://i.scdn.co/image/ab6761610000e5ebe6d6f36e6be274af881e3dd0")
            ]
        ),
        Artist(
            id: "1Cs0zKBU1kc0i8ypK3B9ai",
            name: "David Guetta",
            images: [
                ArtistImage(url: "https://i.scdn.co/image/ab6761610000e5ebf150017ca69c8793503c2d4f")
            ]
        ),
        Artist(
            id: "2ye2Wgw4gimLv2eAKyk1NB",
            name: "Metallica",
            images: [
                ArtistImage(url: "https://i.scdn.co/image/ab6761610000e5eb69ca98dd3083f1082d740e44")
            ]
        ),
        Artist(
            id: "3qm84nBOXUEQ2vnTfUTTFC",
            name: "Guns N' Roses",
            images: [
                ArtistImage(url: "https://i.scdn.co/image/ab6761610000e5eb50defaf9fc059a1efc541f4c")
            ]
        )
    ]
    var isLoading = false
    
    @ObservationIgnored var selectedArtists: [Artist] = []
    
    func tapArtist(_ artist: Artist) {
        if (selectedArtists.count >= 4) {
            selectedArtists.removeFirst()
        }
        selectedArtists.append(artist)
    }
    
    func onDisappear() {
        let preferedArtists = Array(RealmManager.shared.read(PreferArtist.self))
        for preferArtist in preferedArtists {
            RealmManager.shared.delete(preferArtist)
        }
        
        for artist in selectedArtists {
            let preferedArtist = PreferArtist()
            preferedArtist.id = artist.id ?? ""
            preferedArtist.name = artist.name ?? ""
            preferedArtist.imageURL = artist.images?.first?.url ?? ""
            RealmManager.shared.write(preferedArtist)
        }
    }
    
    func onCommit() {
        isLoading = true
        artists = []
    }
    
    func onSearchFinished(artists: [Artist]) {
        isLoading = false
        self.artists = artists
    }
}
