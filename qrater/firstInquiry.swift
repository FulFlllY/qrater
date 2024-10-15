import SwiftUI

struct firstInquiry : View {
    @State var step = 1 //얘 상태가 바뀔 때마다 새로 돌아감
    @State private var mood: String = ""
    @State private var vibe: String = ""
    @State private var action: String = ""
    @State var textOutput = ""

    @Environment(\.dismiss) var dismiss

    var header: String {
        if step == 1 {
            return "Identifying your mood."
        }
        else if step == 2 {
            return "Specifying your music."
        }
        else {
            return "Almost done!"
        }
    }
    
    var body: some View {


        ZStack{
            Color.background
                .ignoresSafeArea()
            VStack (alignment: .trailing){
                Button {
                    step -= 1
                    if (step == 0) {
                        dismiss()
                    }
                } label : {
                    Image(systemName: "arrow.backward")
                        .resizable()
                        .scaledToFit() //비율 보전
                        .frame(width: 30, height: 30)
                        .foregroundStyle(Color.white)
//                    이미지에다가 foreground 맥이면 view가 되어버림. 따라서 resizeble이 안 먹음. 못 믿겠으면 직접 해봐라

                }.frame(maxWidth: .infinity, alignment: .leading)
                //frame을 대빵 키워서 trailing 안 먹고 이 안에서 leading으로 다시 정렬
                
                Text(header).font(.system(size: 25)).frame(maxWidth: .infinity).foregroundStyle(Color.white).bold() //함수 호출 (Calculator property)

                HStack(spacing: 0) {
                    Circle().foregroundStyle(step == 1 ? LinearGradient(colors: [Color.leftend, Color.rightend], startPoint: .leading, endPoint: .trailing) : LinearGradient(colors: [Color.white, Color.white], startPoint: .leading, endPoint: .trailing)).frame(width: 30, height: 30).overlay{
                        Image(systemName: "person.fill.checkmark").foregroundStyle(Color.white)
                        
                    }
                    
                    Line().stroke(style: StrokeStyle(lineWidth: 1, dash: [5])).frame(height: 1).foregroundStyle(Color.white)
                    
                    Circle().foregroundStyle(step == 2 ? LinearGradient(colors: [Color.leftend, Color.rightend], startPoint: .leading, endPoint: .trailing) : LinearGradient(colors: [Color.white, Color.white], startPoint: .leading, endPoint: .trailing)).frame(width: 30, height: 30).overlay{
                        Image(systemName: "doc.text.magnifyingglass").foregroundStyle(Color.white)
                        
                    }
                    
                    Line().stroke(style: StrokeStyle(lineWidth: 1, dash: [5])).frame(height: 1).foregroundStyle(Color.white)
                        
                    Circle().foregroundStyle(step == 3 ? LinearGradient(colors: [Color.leftend, Color.rightend], startPoint: .leading, endPoint: .trailing) : LinearGradient(colors: [Color.white, Color.white], startPoint: .leading, endPoint: .trailing)).frame(width: 30, height: 30).overlay{
                        Image(systemName: "person.fill.questionmark").foregroundStyle(Color.white)
                        
                    }
                }.padding(.horizontal)
                    .padding(.top)
                Text("Step \(step) of 3").foregroundStyle(Color.white).padding(.trailing, 50)
                    .padding(.top, 10)
                
                Spacer().frame(height: 100)
                VStack(alignment: .leading)  { //content 생긴 거 없애줄것
                    if (step == 1) {
                        Text("What is your current mood?").foregroundStyle(Color.white)
                        
                        TextField(
                            "Mood",
                            text: $mood,
                            prompt: Text("How are you feeling?").foregroundStyle(Color.white)
                        ).foregroundStyle(Color.white)
                            .padding()
                            .background(Rectangle().cornerRadius(5))
                    }
                    else if (step == 2) {
                        Text("What kind of music do you want right now?").foregroundStyle(Color.white)
                        
                        TextField(
                            "vibe",
                            text: $vibe,
                            prompt: Text("Describe the vibe or provide examples of songs. ").foregroundStyle(Color.white)
                        ).foregroundStyle(Color.white)
                            .padding()
                            .background(Rectangle().cornerRadius(5))
                    }
                    else if (step == 3) {
                        Text("Describe what you are doing right now.").foregroundStyle(Color.white)
                        
                        TextField(
                            "action",
                            text: $action,
                            prompt: Text("What are you doing right now?").foregroundStyle(Color.white)
                        ).foregroundStyle(Color.white)
                            .padding()
                            .background(Rectangle().cornerRadius(5))
                    }
                }
                //trailing되어도 화면을 꽉 채우니까 안 되는 거처럼 보임
                Spacer()
                Button {
                    step += 1
                } label : {
                    Text((step == 3) ? "Find my music" :  "Next").foregroundStyle(Color.white).frame(maxWidth: .infinity, maxHeight: 50).background(Rectangle().cornerRadius(5).foregroundStyle(LinearGradient(colors: [Color.leftend, Color.rightend], startPoint: .leading, endPoint: .trailing)))
                }
            }.padding(.horizontal, 30)
            
        }
        .navigationBarBackButtonHidden()
    }
}

struct Line: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: rect.width, y: 0))
        return path
    }
}

#Preview {
    firstInquiry() //객체 / 인스턴스니까 ()가 있어야함. (메모리에 올라감)
}
