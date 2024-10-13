import SwiftUI


struct firstInquiry : View {
    @State var step = 1 //얘 상태가 바뀔 때마다 새로 돌아감
    @State private var mood: String = ""
   

    
    var body: some View {


        ZStack{
            Color.background
                .ignoresSafeArea()
            
            VStack (alignment: .trailing){
                Text("Step \(step) of 3").foregroundStyle(Color.white).padding(.trailing, 50)
                    .padding(.top, 10)
                
                Spacer().frame(height: 100)
                VStack(alignment: .leading)  { //content 생긴 거 없애줄것
                    Text("What is your current mood?").foregroundStyle(Color.white)
                    
                    TextField(
                        "Mood",
                        text: $mood,
                        prompt: Text("How are you feeling?").foregroundStyle(Color.white)
                    ).foregroundStyle(Color.white)
                        .padding()
                        .background(Rectangle().cornerRadius(5))

                }
                //trailing되어도 화면을 꽉 채우니까 안 되는 거처럼 보임
                Spacer()
                Button {
                    step += 1
                } label : {
                    Text("Next").foregroundStyle(Color.white).frame(maxWidth: .infinity, maxHeight: 50).background(Rectangle().cornerRadius(5).foregroundStyle(LinearGradient(colors: [Color.leftend, Color.rightend], startPoint: .leading, endPoint: .trailing)))
                }
                

                if step >= 2 {
                    Button {
                        step -= 1
                    } label : {
                        Text("Before")
                    }
                }
            }.padding(.horizontal, 30)
            
        }
    }
}

#Preview {
    firstInquiry() //객체 / 인스턴스니까 ()가 있어야함. (메모리에 올라감)
}
