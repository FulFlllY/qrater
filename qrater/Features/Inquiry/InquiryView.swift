import SwiftUI

struct InquiryView : View {
    @State private var viewModel = InquiryViewModel()
    
    @Binding private var path: [StackView]
    
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject private var spotifyManager: SpotifyManager
    
    init(path: Binding<[StackView]>) {
        _path = path
    }
    
    var body: some View {
        ZStack{
            Color.background.ignoresSafeArea()
            
            VStack {
                VStack(alignment: .trailing) {
                    Button {
                        if (viewModel.step == 1) {
                            dismiss()
                        } else {
                            viewModel.back()
                        }
                    } label : {
                        Image(systemName: "arrow.backward")
                            .resizable()
                            .scaledToFit() //비율 보전
                            .frame(width: 30, height: 30) //큰 거 기준으로 비율 관리
                            .foregroundStyle(Color.white)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Text(viewModel.header)
                        .font(.system(size: 25))
                        .bold()
                        .frame(maxWidth: .infinity)
                        .foregroundStyle(Color.white)
                    
                    HStack(spacing: 0) {
                        Image(systemName: "person.fill.checkmark")
                            .foregroundStyle(Color.white)
                            .frame(width: 30, height: 30)
                            .background {
                                if (viewModel.step == 1) {
                                    Circle()
                                        .fill(
                                            LinearGradient(
                                                colors: [Color.main, Color.sub],
                                                startPoint: .leading,
                                                endPoint: .trailing
                                            )
                                        )
                                } else {
                                    Circle()
                                        .fill(Color.white)
                                }
                            }
                        
                        Line()
                            .stroke(style: StrokeStyle(lineWidth: 1, dash: [5]))
                            .foregroundStyle(Color.white)
                            .frame(height: 1)
                        
                        Image(systemName: "doc.text.magnifyingglass")
                            .foregroundStyle(Color.white)
                            .frame(width: 30, height: 30)
                            .background {
                                if (viewModel.step == 2) {
                                    Circle()
                                        .fill(
                                            LinearGradient(
                                                colors: [Color.main, Color.sub],
                                                startPoint: .leading,
                                                endPoint: .trailing
                                            )
                                        )
                                } else {
                                    Circle()
                                        .fill(Color.white)
                                }
                            }
                        
                        Line()
                            .stroke(style: StrokeStyle(lineWidth: 1, dash: [5]))
                            .foregroundStyle(Color.white)
                            .frame(height: 1)
                        
                        Image(systemName: "person.fill.questionmark")
                            .foregroundStyle(Color.white)
                            .frame(width: 30, height: 30)
                            .background {
                                if (viewModel.step == 3) {
                                    Circle()
                                        .fill(
                                            LinearGradient(
                                                colors: [Color.main, Color.sub],
                                                startPoint: .leading,
                                                endPoint: .trailing
                                            )
                                        )
                                } else {
                                    Circle()
                                        .fill(Color.white)
                                }
                            }
                    }
                    
                    Text("Step \(viewModel.step) of 3")
                        .foregroundStyle(Color.white)
                        .padding(.trailing, 50)
                        .padding(.top, 10)
                }
                .padding(.top)
                
                Spacer().frame(height: 100)
                
                Text(viewModel.question)
                    .foregroundStyle(Color.white)
                
                if (viewModel.step == 1) {
                    TextField(
                        "Mood",
                        text: $viewModel.mood,
                        prompt: Text("How are you feeling?").foregroundStyle(Color.white)
                    )
                    .padding()
                    .background(
                        Rectangle()
                            .fill(Color.black)
                            .cornerRadius(5)
                    )
                } else if (viewModel.step == 2) {
                    TextField(
                        "vibe",
                        text: $viewModel.vibe,
                        prompt: Text("Describe the vibe or provide examples of songs.").foregroundStyle(Color.white)
                    )
                    .padding()
                    .background(
                        Rectangle()
                            .fill(Color.black)
                            .cornerRadius(5)
                    )
                } else if (viewModel.step == 3) {
                    TextField(
                        "action",
                        text: $viewModel.action,
                        prompt: Text("What are you doing right now?").foregroundStyle(Color.white)
                    )
                    .padding()
                    .background(
                        Rectangle()
                            .fill(Color.black)
                            .cornerRadius(5)
                    )
                }
                
                Spacer()
                
                Button {
                    if (viewModel.step == 3) {
                        Task {
                            await viewModel.sumit()
                        }
                    } else {
                        viewModel.next()
                    }
                } label : {
                    Text(viewModel.step != 3 ? "Next" : "Find my music")
                        .foregroundStyle(Color.white)
                        .frame(maxWidth: .infinity, maxHeight: 50)
                        .background(
                            Rectangle()
                                .cornerRadius(5)
                                .foregroundStyle(
                                    LinearGradient(
                                        colors: [Color.main, Color.sub],
                                        startPoint: .leading,
                                        endPoint: .trailing
                                    )
                                )
                        )
                }
            }
            .padding(.horizontal, 30)
            .onAppear {
                viewModel.onAppear(spotifyManager: spotifyManager)
            }
            .onChange(of: viewModel.playlist, {
                if let playlist = viewModel.playlist {
                    path.append(StackView(type: .resultView, playlist: playlist))
                }
            })
            
            if viewModel.isLoading {
                Color.black.opacity(0.5)
                    .ignoresSafeArea()
                    .overlay {
                        ProgressView().progressViewStyle(CircularProgressViewStyle())
                    }
            }
        }
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    InquiryView(path: .constant([])) //객체 / 인스턴스니까 ()가 있어야함. (메모리에 올라감)
}
