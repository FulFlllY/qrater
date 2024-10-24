import SwiftUI
import RealmSwift

struct ResultView: View {
    @StateObject private var viewModel: ResultViewModel
    
    @Binding private var path: [StackView]
    
    @Environment(\.dismiss) private var dismiss
    
    private var dateFormatter: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        return dateFormatter
    }
    
    init(path: Binding<[StackView]>, playlist: Playlist) {
        _path = path
        _viewModel = StateObject(wrappedValue: ResultViewModel(playlist: playlist))
    }
    
    var body : some View {
        ZStack {
            Color.background.ignoresSafeArea()
            
            ScrollView{
                VStack {
                    Button {
                        dismiss()
                    } label : {
                        Image(systemName: "arrow.backward")
                            .resizable()
                            .scaledToFit() //비율 보전
                            .frame(width: 30, height: 30) //큰 거 기준으로 비율 관리
                            .foregroundStyle(Color.white)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .padding(.top)
                    
                    HStack {
                        VStack (alignment: .leading) {
                            Text("\(dateFormatter.string(from: viewModel.playlist.createAt))")
                                .foregroundColor(Color.white)
                                .padding(.leading, 30)
                            
                            Text("\(viewModel.playlist.mood?.whatDo ?? "")")
                                .font(.system(size: 23))
                                .bold()
                                .foregroundColor(Color.white)
                                .padding(.leading, 30)
                        }
                        
                        Spacer()
                        
                        Button(action: {
                            viewModel.isPlaying.toggle()
                        }) {
                            Image(systemName: viewModel.playlist.isLiked ? "star.fill" : "star")
                                .resizable()
                                .frame(width: 30, height: 30)
                                .foregroundColor(viewModel.isPlaying ? .yellow : .gray)
                                .padding(.trailing, 40)
                            
                        }
                    }
                    .padding(.bottom, 20)
                    
                    HStack {
                        VStack {
                            Text("Mood").foregroundColor(Color.white)
                                .font(.system(size: 30)).bold()
                                .padding(.leading, 30)
                                .padding(.top, 20)
                            
                            Image("BigBooby")
                                .resizable()
                                .frame(width: 100, height: 100)
                                .padding(.leading, 30)
                        }
                        
                        Spacer()
                        
                        VStack(spacing: 4) {
                            ForEach(0..<(viewModel.playlist.mood?.moods.count ?? 0), id: \.self) { index in
                                Text(viewModel.playlist.mood?.moods[index] ?? "")
                            }
                        }.padding()
                        .foregroundStyle(Color.white)
                        .font(.system(size: 20))
                        .bold()// 다른 거 들가도 되나요?
                        .padding(.trailing, 30)
                    }
                    .background(
                        LinearGradient(
                            colors: [Color.black, Color.gray],
                            startPoint: .leading,
                            endPoint: .trailing)
                    )
                    .cornerRadius(20)//foreground 가 아닌 background
                    
                    HStack (spacing: 20) {
                        Button {} label: {
                            ZStack {
                                Rectangle()
                                    .frame(width: 70, height: 70)
                                    .cornerRadius(10)
                                    .foregroundStyle(Color.black)
                                
                                Image("spotify")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 60, height: 60)
                                    .foregroundStyle(Color.white)
                            }
                        }
                        
                        Button {} label: {
                            ZStack {
                                Rectangle()
                                    .frame(width: 70, height: 70)
                                    .cornerRadius(10)
                                    .foregroundStyle(Color.black)
                                Image(systemName: "play.fill")
                                    .resizable()
                                    .frame(width: 30, height: 30)
                                    .foregroundStyle(Color.white)
                                    .padding(.leading, 5)
                            }
                        }
                        
                        Button {} label: {
                            ZStack {
                                Rectangle()
                                    .frame(width: 70, height: 70)
                                    .cornerRadius(10)
                                    .foregroundStyle(Color.black)
                                
                                Image("WhiteBooby")
                                    .resizable()
                                    .frame(width: 70, height: 70)
                            }
                        }
                        
                        Button {} label: {
                            ZStack {
                                Rectangle().frame(width: 70, height: 70)
                                    .cornerRadius(10)
                                    .foregroundStyle(Color.black)
                                
                                Image(systemName: "ellipsis")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 20, height: 20)
                                    .foregroundStyle(Color.white)
                            }
                        }
                    }
                    
                    HStack(spacing: 24) {
                        HStack {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(Color.white)
                            
                            TextField("Search by name", text: $viewModel.searchText)
                        }
                        .font(.headline)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 20)
                                .fill(Color.gray)
                        )
                        
                        Button {} label: {
                            ZStack {
                                Rectangle()
                                    .frame(width: 50, height: 50)
                                    .cornerRadius(10)
                                    .foregroundStyle(Color.black)
                                Image(systemName: "square.and.pencil")
                                    .resizable()
                                    .frame(width: 30, height: 30)
                                    .foregroundStyle(Color.white)
                            }
                        }
                    }
                    .padding(.vertical, 8)
                    
                    VStack {
                        ForEach(0..<(viewModel.filteredMusics.count), id: \.self) { index in
                            Button {
                                path.append(StackView(type: .curateView, music: viewModel.filteredMusics[index]))
                            } label: {
                                VStack(alignment: .leading) {
                                    Text(viewModel.filteredMusics[index].name)
                                        .bold()
                                        .font(.system(size: 17))
                                        .multilineTextAlignment(.leading)
                                        .foregroundStyle(Color.black)
                                    
                                    Text("Artist: \(viewModel.filteredMusics[index].artistName)")
                                        .font(.system(size: 14))
                                        .foregroundStyle(Color.black)
                                }
                                .padding(.vertical, 30)
                                .padding(.leading, 20)
                                
                                Spacer()
                            }
                            .background(
                                Rectangle()
                                    .foregroundStyle(Color.white)
                            )
                            .cornerRadius(10)
                            .padding(.bottom, 20)
                        }
                    }
                }
                .padding(.horizontal, 30)
            }
            .scrollIndicators(.hidden)
        }
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    ResultView(path: .constant([]), playlist: Playlist())
}
