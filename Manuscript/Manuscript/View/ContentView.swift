import UIKit
import CoreML
import Vision
import ImageIO
import SwiftUI

struct ContentView: View {
    @Environment(\.colorScheme) var colorScheme
    
    @State private var staff1DrawableStaff = DrawableStaff()
    @State private var staff2DrawableStaff = DrawableStaff()
    @State private var staff3DrawableStaff = DrawableStaff()
    
    var body: some View {
        VStack {            
            let staff1 = ZStack{
            

                DrawingPad(drawableStaff: $staff1DrawableStaff)
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
                DrawingPad(drawableStaff: $staff2DrawableStaff)
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
                DrawingPad(drawableStaff: $staff3DrawableStaff)
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
            staff1
            staff2
            staff3
//            staff1.gesture(DragGesture().onChanged({value in print("Hello from staff1 \(value.location)")}))
//            staff2.gesture(DragGesture().onChanged({value in print("Hello from staff2 \(value.location)")}))
//            staff3.gesture(DragGesture().onChanged({value in print("Hello from staff3 \(value.location)")}))
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
            .preferredColorScheme(.dark)
            .previewDevice("iPad Pro (12.9-inch) (4th generation)")
    }
}

//https://stackoverflow.com/a/64177005/14082090
struct DrawingPad: View {
    
    @Binding var drawableStaff: DrawableStaff
    
    var body: some View {
        GeometryReader { geometry in
            Path { path in
                for drawing in self.drawableStaff.drawingList {
                    self.add(drawing: drawing, toPath: &path)
                }
                self.add(drawing: self.drawableStaff.drawing, toPath: &path)
            }
            .stroke(self.drawableStaff.color, lineWidth: self.drawableStaff.lineWidth)
                .background(Color(UIColor.systemBackground))
                .gesture(
                    DragGesture(minimumDistance: 0.1)
                        .onChanged({ (value) in
                            let currentPoint = value.location
                            if currentPoint.y >= 0
                                && currentPoint.y < geometry.size.height {
                                self.drawableStaff.drawing.points.append(currentPoint)
                            }
                        })
                        .onEnded({ (value) in
                            let classifier = ImageClassifier()
                            let imageAsUI = UIImage(named: "test-drawings/quarter-note")
//                            print(classifier.classifyUIImage(image: imageAsUI!)!)
//                            print("Current drawing: \(self.drawableStaff.drawing)")
                            let predictedSymbol = classifier.classifyPath(path:self.drawableStaff.drawing)
                            print("Currently predicting: \(String(describing: predictedSymbol.symbolType))")
//                            print("Image path: \(predictedSymbol.getSymbolImage())")
                            //vvv In order to have notes disappear, comment out this line vvvv
                            self.drawableStaff.drawingList.append(self.drawableStaff.drawing)
                            
                            self.drawableStaff.drawing = Drawing()
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
