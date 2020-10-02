import SwiftUI

struct ContentView: View {
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        VStack {
            var staff1 = Group{
                
                Rectangle().frame(height: 40.0).foregroundColor(getBackgroundColor())
                StaffLine().padding(.top, 30.0)
                StaffLine().padding(.top, 30.0)
                StaffLine().padding(.top, 30.0)
                StaffLine().padding(.top, 30.0)
                StaffLine().padding(.top, 30.0)
                Rectangle().frame(height: 40.0).foregroundColor(getBackgroundColor())
            }

            var staff2 = Group{
                Rectangle().frame(height: 40.0).foregroundColor(getBackgroundColor())
                StaffLine().padding(.top, 130.0)
                StaffLine().padding(.top, 30.0)
                StaffLine().padding(.top, 30.0)
                StaffLine().padding(.top, 30.0)
                StaffLine().padding(.top, 30.0)
                Rectangle().frame(height: 40.0).foregroundColor(getBackgroundColor())
            }
            var staff3 = Group{
                Rectangle().frame(height: 40.0).foregroundColor(getBackgroundColor())
                StaffLine().padding(.top,130.0)
                StaffLine().padding(.top, 30.0)
                StaffLine().padding(.top, 30.0)
                StaffLine().padding(.top, 30.0)
                StaffLine().padding(.top, 30.0)
                Rectangle().frame(height: 40.0).foregroundColor(getBackgroundColor())
            }
            staff1.gesture(DragGesture().onChanged({ value in print("Hello from Staff1 \(getBackgroundColor())")}))
            staff2.gesture(DragGesture().onChanged({ value in print("Hello from Staff2 \(getBackgroundColor())")}))
            staff3.gesture(DragGesture().onChanged({ value in print("Hello from Staff3 \(getBackgroundColor())")}))
        }
    }
    
    func getBackgroundColor() -> Color{
        colorScheme == .dark ? .black : .white
    }

}

struct StaffLine: View {
    let color: Color = .secondary
    let width: CGFloat = 2
    var body: some View {
        Rectangle()
            .fill(color)
            .frame(height: width)
            .edgesIgnoringSafeArea(.horizontal)
    }
}
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}


#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        return Group {
            ContentView().previewLayout(.fixed(width: 2436 / 3.0, height: 1125 / 3.0))
        }
    }
}
#endif

