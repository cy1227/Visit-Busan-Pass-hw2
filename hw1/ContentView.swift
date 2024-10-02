import SwiftUI
extension Color {
    // 使用16進制顏色初始化
    init(hex: String) {
        let scanner = Scanner(string: hex)
        _ = scanner.scanString("#") // 跳過 '#' 符號
        var rgbValue: UInt64 = 0
        scanner.scanHexInt64(&rgbValue)
        
        let red = Double((rgbValue >> 16) & 0xFF) / 255.0
        let green = Double((rgbValue >> 8) & 0xFF) / 255.0
        let blue = Double(rgbValue & 0xFF) / 255.0
        
        self.init(red: red, green: green, blue: blue)
    }
}
struct Hexagon: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.width * 0.5, y: rect.height * 0))
        path.addLine(to: CGPoint(x: rect.width * 0.9, y: rect.height * 0.25))
        path.addLine(to: CGPoint(x: rect.width * 0.9, y: rect.height * 0.75))
        path.addLine(to: CGPoint(x: rect.width * 0.5, y: rect.height * 1.0))
        path.addLine(to: CGPoint(x: rect.width * 0.1, y: rect.height * 0.75))
        path.addLine(to: CGPoint(x: rect.width * 0.1, y: rect.height * 0.25))
        path.closeSubpath()
        return path
    }
}
struct IrregularPolygon: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        // 移動到第一個點 (頂點)
        path.move(to: CGPoint(x: rect.width * 0.5, y: rect.height * 0.1))
        
        // 添加其他不規則頂點
        path.addLine(to: CGPoint(x: rect.width * 0.8, y: rect.height * 0.2))
        path.addLine(to: CGPoint(x: rect.width * 0.9, y: rect.height * 0.5))
        path.addLine(to: CGPoint(x: rect.width * 0.7, y: rect.height * 0.9))
        path.addLine(to: CGPoint(x: rect.width * 0.3, y: rect.height * 0.8))
        path.addLine(to: CGPoint(x: rect.width * 0.1, y: rect.height * 0.4))
        
        path.closeSubpath()
        return path
    }
}


struct ContentView: View {
    // 圖片名稱
    let images = ["t1", "t2", "t3","t4"]
    
    var body: some View {
        ScrollView {
            VStack(spacing: 10) {
                // 標題
                HStack(spacing: 0) {
                    Image(systemName: "line.3.horizontal")
                        .font(.largeTitle)
                        .foregroundColor(.white)
                    Image("busan")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 100, height: 100)
                        .clipped()
                        .cornerRadius(10)
                    Text("Visit Busan Pass")
                        .font(.custom("PatrickHand-Regular", size: 35))
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                }
                
                // 描述文字
                Text("    釜山PASS通行證是2024年2月1號才推出的最新旅遊券，釜山市專門為「非韓國籍旅客」購買的旅遊通行證，使用這張通行證能夠免費進入36個熱門釜山必去景點、免費體驗活動，還享有109間指定商店優惠。")
                    .font(.custom("jf-openhuninn-2.0", size: 20))
                    .font(.body)
                    .foregroundColor(.white)
                    .padding(.horizontal)
                
                // 圖片
                ZStack (alignment: .topLeading){
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 0) {
                            ForEach(images, id: \.self) { imageName in
                                Image(imageName)
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 400, height: 280)
                                    .clipped()
                                    .cornerRadius(10)
                            }
                        }
                        .padding(.horizontal)
                    }
                    Text("WEEKLY HOTPLACE")
                        .font(.custom("jf-openhuninn-2.0", size: 12))
                        .fontWeight(.bold)
                        .padding(8)
                        .background(.yellow)
                        .shadow(radius: 10)
                        .offset(x: 25, y: 10)//上下偏移
                }
                Spacer()
            }
            //        .frame(maxHeight: .infinity, alignment: .top)
            .padding(.top, 50)
            .background(Color(hex: "#421273"))
            .edgesIgnoringSafeArea(.all)
            VStack{
                Text("什麼是遊覽VISIT BUSAN PASS?")
                    .font(.custom("jf-openhuninn-2.0", size: 25))
                    .fontWeight(.bold)
                    .foregroundColor(Color(hex: "#036BAA"))
                Spacer().frame(height: 10)
                Text("  VISIT BUSAN PASS 是分為 24H / 48H 計時型及 BIG 3 / BIG 5 計次型的自由通行證。可以免費訪問釜山有名的觀光景點及享有在交通、購物、公演等多項優惠折扣。")
                    .font(.body)
                    .font(.system(size: 20))
                    .foregroundColor(Color(hex: "#036BAA"))
                    .padding(.horizontal)
                HStack{
                    AdvantagesView(picName: .f1, title: "免費使用卷", content: "釜山主要旅遊景點請免費使用")
                    AdvantagesView(picName: .f2, title: "減價優惠", content: "購物、一日課程等各種優惠滿滿!")
                }
                HStack{
                    AdvantagesView(picName: .f3, title: "交通便利", content: "使用釜山通行證可以乘坐觀光巴士以及城市地下鐵")
                    AdvantagesView(picName: .f4, title: "移動應用程序", content: "在移動程序中登錄通行證更為便捷")
                }
                //購票區塊
                Spacer().frame(height: 20)
                // Text 搭配 Markdown 語法實現點擊文字打開連結的功能
                Text("[BUY PASS](https://www.visitbusanpass.com/pass/)")
                    .font(.system(size: 30))
                    .accentColor(Color(hex: "#036BAA"))
                    .fontWeight(.bold)
                //                Link("BUY PASS", destination: URL(string: "https://www.visitbusanpass.com/pass/")!)
                //                    .font(.system(size: 30))
                //                    .accentColor(Color(hex: "#036BAA"))
                //                    .fontWeight(.bold)
                TicketTypeView(type:"24", type2: "PASS", describe:"VISIT BUSAN PASS 24H", price: "55,000" )
                TicketTypeView(type:"48", type2: "PASS", describe:"VISIT BUSAN PASS 48H", price: "85,000" )
                TicketTypeView(type:"3", type2: "CHOICE", describe:"VISIT BUSAN PASS BIG 3", price: "45,000" )
                TicketTypeView(type:"5", type2: "CHOICE", describe:"VISIT BUSAN PASS BIG 5", price: "65,000" )
            }
        } .ignoresSafeArea()
        
    }
}





#Preview {
    ContentView()
}

struct AdvantagesView: View {
    let picName: ImageResource
    let title: String
    let content: String
    
    var body: some View {
        VStack{
            Image(picName)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 130, height: 130)
                .clipped()
                .clipShape(IrregularPolygon())
            Text(title)
                .font(.custom("jf-openhuninn-2.0", size: 20))
                .foregroundColor(Color(hex: "#036BAA"))
                .padding(.horizontal)
            Text(content)
                .font(.custom("jf-openhuninn-2.0", size: 20))
                .foregroundColor(.gray)
                .padding(.horizontal)
                .frame(maxWidth: 150)
                .multilineTextAlignment(.center)
            
        }
    }
}

struct TicketTypeView: View {
    let type: String
    let type2: String
    let describe: String
    let price: String
    
    var body: some View {
        HStack(spacing: 0) {
            HStack{
                Text(type)
                    .font(.custom("RubikDoodleShadow-Regular", size: 35))
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                Text(type2)
                    .font(.system(size: 23))
                    .fontWeight(.bold)
                    .foregroundColor(.white)
            }
            .frame(width: 135,height:80)
            .background(Color(hex: "#343C4F"))
            HStack{
                VStack(spacing: 10){
                    Text(describe)
                        .font(.system(size: 13))
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    Text("免費40+ / 折扣160+")
                        .font(.system(size: 12))
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                }
                VStack(spacing: 10){
                    Text("KRW")
                        .font(.system(size: 15))
                        .fontWeight(.bold)
                        .foregroundColor(.red)
                    Text(price)
                        .font(.system(size: 18))
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                }
                
            }
            .padding(.horizontal, 5)
            .frame(width: 245,height:80 )
            .background(Color(hex: "#434C65"))
        }
        
    }
}
