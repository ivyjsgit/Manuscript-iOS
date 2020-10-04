import SwiftUI

struct Drawing {
    var points: [CGPoint] = [CGPoint]()
}
struct ContentView: View {
    @Environment(\.colorScheme) var colorScheme
    @State private var staff1Drawing: Drawing = Drawing()
    @State private var staff2Drawing: Drawing = Drawing()
    @State private var staff3Drawing: Drawing = Drawing()

    @State private var staff1DrawingList: [Drawing] = [Drawing]()
    @State private var staff2DrawingList: [Drawing] = [Drawing]()
    @State private var staff3DrawingList: [Drawing] = [Drawing]()

    @State private var color: Color = .primary
    @State private var lineWidth: CGFloat = 3.0
    
    var body: some View {
        VStack {            
            let staff1 = ZStack{
                
                DrawingPad(currentDrawing: $staff1Drawing,
                           drawings: $staff1DrawingList,
                           color: $color,
                           lineWidth: $lineWidth)
                VStack{
                    Rectangle().frame(height: 40.0).foregroundColor(getBackgroundColor())
                    StaffLine().padding(.top, 30.0)
                    StaffLine().padding(.top, 30.0)
                    StaffLine().padding(.top, 30.0)
                    StaffLine().padding(.top, 30.0)
                    StaffLine().padding(.top, 30.0)
                    Rectangle().frame(height: 40.0).foregroundColor(getBackgroundColor())
                }
            }
           
            let staff2 = ZStack{
                DrawingPad(currentDrawing: $staff2Drawing,
                           drawings: $staff2DrawingList,
                           color: $color,
                           lineWidth: $lineWidth)
                VStack{
                    Rectangle().frame(height: 40.0).foregroundColor(getBackgroundColor())
                    StaffLine().padding(.top, 130.0)
                    StaffLine().padding(.top, 30.0)
                    StaffLine().padding(.top, 30.0)
                    StaffLine().padding(.top, 30.0)
                    StaffLine().padding(.top, 30.0)
                    Rectangle().frame(height: 40.0).foregroundColor(getBackgroundColor())
                }
            }
            let staff3 = ZStack{
                DrawingPad(currentDrawing: $staff3Drawing,
                           drawings: $staff3DrawingList,
                           color: $color,
                           lineWidth: $lineWidth)
               VStack{
                    Rectangle().frame(height: 40.0).foregroundColor(getBackgroundColor())
                    StaffLine().padding(.top,130.0)
                    StaffLine().padding(.top, 30.0)
                    StaffLine().padding(.top, 30.0)
                    StaffLine().padding(.top, 30.0)
                    StaffLine().padding(.top, 30.0)
                    Rectangle().frame(height: 40.0).foregroundColor(getBackgroundColor())
                }
            }
            staff1.gesture(DragGesture().onChanged({value in print("Hello from staff1 \(value.location)")}))
            staff2.gesture(DragGesture().onChanged({value in print("Hello from staff2 \(value.location)")}))
            staff3.gesture(DragGesture().onChanged({value in print("Hello from staff3 \(value.location)")}))
        }
    }
    
    func getBackgroundColor() -> Color{
        colorScheme == .dark ? .black : .white
    }

}

struct StaffLine: View {
    @Environment(\.colorScheme) var colorScheme
    let color: Color = .primary
    let width: CGFloat = 2
    var body: some View {
        Rectangle()
            .fill(color)
            .frame(height: width)
            .edgesIgnoringSafeArea(.horizontal)
    }
 
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewDevice("iPad Pro (12.9-inch) (4th generation)")
    }
}

//https://stackoverflow.com/a/64177005/14082090
struct DrawingPad: View {
    @Binding var currentDrawing: Drawing
    @Binding var drawings: [Drawing]
    @Binding var color: Color
    @Binding var lineWidth: CGFloat
    
    var body: some View {
        GeometryReader { geometry in
            Path { path in
                for drawing in self.drawings {
                    self.add(drawing: drawing, toPath: &path)
                }
                self.add(drawing: self.currentDrawing, toPath: &path)
            }
            .stroke(self.color, lineWidth: self.lineWidth)
                .background(Color(UIColor.systemBackground))
                .gesture(
                    DragGesture(minimumDistance: 0.1)
                        .onChanged({ (value) in
                            let currentPoint = value.location
                            if currentPoint.y >= 0
                                && currentPoint.y < geometry.size.height {
                                self.currentDrawing.points.append(currentPoint)
                            }
                        })
                        .onEnded({ (value) in
                            self.drawings.append(self.currentDrawing)
                            self.currentDrawing = Drawing()
                        })
            )
        }
        .frame(maxHeight: .infinity)
    }
    
    private func add(drawing: Drawing, toPath path: inout Path) {
        let points = drawing.points
        if points.count > 1 {
            for i in 0..<points.count-1 {
                let current = points[i]
                let next = points[i+1]
                path.move(to: current)
                path.addLine(to: next)
            }
        }
    }
    
}
