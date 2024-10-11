import SwiftUI


struct home: View {
    @Environment(\.realm) var realm
    
    @StateObject private var spotifyController = SpotifyController()
    
    
    
    var body: some View {
        NavigationStack { //얘가 안에 있어야 함
            ZStack {
                Color.background
                    .ignoresSafeArea()
                VStack {
                    Text("Welcome listener!")
                        .font(.system(size: 35))
                        .bold()
                        .padding(.top, 85.0)
                        .foregroundStyle(Color.white)
                    NavigationLink { //navigation link 역할을 하는 버튼
                        firstInquiry()
                    } label: {
                        Image("button")
                            .resizable()
                            .frame(width: 300.0, height: 300.0) //크기 (너비 높이) 변경
                            .clipShape(.circle) //중요
                            .padding(.top)
                        
                        //패딩 전에 resizable 이랑 frame 먼저 넣을 것
                        
                        
                    }
                    
                    Text("Touch to find your music")
                        .font(.system(size: 20))
                        .bold()
                        .foregroundStyle(Color.white)
                        .padding() //앞뒤앙옆 디폴트로 16으로 들감
                    
                    VStack(spacing: 16) { //각 원소마다 자동으로 간격 넣어줌. 기본 값 8
                        HStack {
                            Text("Artist Preference")
                                .font(.system(size: 15))
                                .fontWeight(.bold)
                                .foregroundColor(Color.white)
                                .padding(.leading)
                            
                            Spacer()
                            Button {} label: {
                                Image(systemName: "square.and.pencil")
                                    .resizable()
                                    .frame(width: 30.0, height: 30.0)
                                    .foregroundStyle(Color.white)
                            }
                            .padding(.trailing)
                        }.padding(.top)
                        HStack {
                            VStack {
                                Circle()
                                    .frame(width: 70, height: 70)
                                    .padding(.bottom, 10)
                                
                                Text("John Mayer").foregroundColor(Color.white)
                                    .font(.system(size: 12))
                            }
                            VStack {
                                Circle()
                                    .frame(width: 70, height: 70)
                                    .padding(.bottom, 10)
                                
                                Text("John Mayer").foregroundColor(Color.white)
                                    .font(.system(size: 12))
                            }
                            VStack {
                                Circle()
                                    .frame(width: 70, height: 70)
                                    .padding(.bottom, 10)
                                
                                Text("John Mayer").foregroundColor(Color.white)
                                    .font(.system(size: 12))
                            }
                            VStack {
                                Circle()
                                    .frame(width: 70, height: 70)
                                    .padding(.bottom, 10)
                                
                                Text("John Mayer").foregroundColor(Color.white)
                                    .font(.system(size: 12))
                            }
                        }
                        .padding(.horizontal)
                        .padding(.bottom)
                        
                    }                    .background(Rectangle().stroke(.gray.opacity(0.2),lineWidth: 4))
                        .padding(.top, 20)
                        .padding(.horizontal, 30)
                    Spacer()
                }
                
                Capsule()
                    .fill(Color.secondary)
                    .frame(width: 30, height: 3)
                    .padding(10)

                // your sheet content here

                Spacer()
            }
        }
    }
}

#Preview {
    home()
}
