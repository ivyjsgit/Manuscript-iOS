////
////  ImageClassifier.swift
////  Manuscript
////
////  Created by Ivy on 10/6/20.
////

import UIKit
import CoreML
import Vision
import ImageIO
import SwiftUI

struct ImageClassifier{
    var classifier = SymbolClassifier()

    func classify(image: CGImage) -> String?{
        let pixelBuffer = image.pixelBuffer(width: 300, height: 300, orientation: CGImagePropertyOrientation.up)!
        let output = try? self.classifier.prediction(image: pixelBuffer)
        return output?.classLabel
    }
    func classifyUIImage(image: UIImage)-> String?{
        guard let imageAsUIImage:CGImage = convertUIImageToCGImage(image: image) else{
            return nil
        }
        return classify(image: imageAsUIImage)
    }
    //https://www.hackingwithswift.com/example-code/core-graphics/how-to-draw-lines-in-core-graphics-moveto-and-addlineto
    func classifyPath(path:Drawing) -> Symbol{

        //For some reason, CGImages are recognized as half of their size???
        let viewportSize=300
        let padding:CGFloat = CGFloat(0.0)
        
        //Tweak these until the image is roughly the correct size and centred
        let shrinkFactor: Float = 10
        let drawSize = CGSize(width: viewportSize, height: viewportSize)
        
        let imageRenderer = UIGraphicsImageRenderer(size: drawSize)
        let symbolAsCIImage = imageRenderer.image { ctx in
            ctx.cgContext.setFillColor(UIColor.white.cgColor)
            ctx.cgContext.fill(CGRect(x: 0, y: 0, width: drawSize.width, height: drawSize.height))
            ctx.cgContext.setStrokeColor(UIColor.black.cgColor)
            ctx.cgContext.setLineWidth(2)

            
            let points = path.points

            //Get the height and width of the original symbol
            let symbolWidth = abs(findMaxX(cgpoints: points) - findMinX(cgpoints: points))
            let symbolHeight = abs(findMaxY(cgpoints: points) - findMinY(cgpoints: points))
            
            let centeredPoints = movePointsToCorner(points: points)
            
            //Get the amount we should scale the symbol by
            let scale = symbolWidth/Float(viewportSize) * shrinkFactor
            
            //Scale the image
            let scaledPoints = centeredPoints.map{CGPoint(x: ($0.x)/CGFloat(scale),y: ($0.y)/CGFloat(scale))}
            
     
            var scootedPoints = scaledPoints.map{CGPoint(x: ($0.x)-CGFloat(findMinX(cgpoints: scaledPoints))+padding, y: ($0.y)-CGFloat(findMinY(cgpoints: scaledPoints))+padding)}
            

            
            print("Height: \(symbolHeight) Width: \(symbolWidth)")
            print("Mins: \(findMinX(cgpoints: scaledPoints)) \(findMinY(cgpoints: scaledPoints))")

            if scootedPoints.count>1{
                let first = scootedPoints.removeFirst()
                ctx.cgContext.move(to: first)
                ctx.cgContext.addLines(between: scootedPoints)
                ctx.cgContext.drawPath(using: .fillStroke)
            }
        }
        
        return Symbol(symbolType: (classify(image: symbolAsCIImage.cgImage!)!))
    }
    func convertUIImageToCGImage(image: UIImage) -> CGImage? {
        let inputImage = CIImage(image: image)!
        let context = CIContext(options: nil)
        return context.createCGImage(inputImage, from: inputImage.extent)
    }
    
    func findMinX(cgpoints: [CGPoint]) -> Float{
        let xs:[Float] = cgpoints.map ({(point:CGPoint) -> Float in
            return Float(point.x
)        })
        if xs.min() == nil {
            return 0.0
        }else{
            return xs.min()!
        }
    }
    
    func findMaxX(cgpoints: [CGPoint]) -> Float{
        let xs:[Float] = cgpoints.map ({(point:CGPoint) -> Float in
            return Float(point.x
)        })
        
        if xs.max() == nil {
            return 0.0
        }else{
            return xs.max()!
        }
        
    }
    
    func findMinY(cgpoints: [CGPoint]) -> Float{
        let ys:[Float] = cgpoints.map ({(point:CGPoint) -> Float in
            return Float(point.y
)        })
        if ys.min() == nil {
            return 0.0
        }else{
            return ys.min()!
        }
        

    }
    
    func findMaxY(cgpoints: [CGPoint]) -> Float{
        let ys:[Float] = cgpoints.map ({(point:CGPoint) -> Float in
            return Float(point.y
)        })
        if ys.max() == nil {
            return 0.0
        }else{
            return ys.max()!
        }

    }
    func movePointsToCorner(points: [CGPoint]) -> [CGPoint]{
        let minX = findMinX(cgpoints: points)
        let minY = findMinY(cgpoints: points)
        let maxX = findMaxX(cgpoints: points)
        let maxY = findMaxY(cgpoints: points)
        
        let width = maxX - minX
        let height = maxY - minY
        
        //Initialize scootedPoints
        var centeredPoints:[CGPoint] = []
        if (width<height){
            let amountToScoot:CGFloat = CGFloat(((height-width)/2.0))
            centeredPoints = points.map{CGPoint(x: ($0.x) + amountToScoot, y: ($0.y))}
        }else{
            let amountToScoot:CGFloat = CGFloat(((width - height)/2.0))
            centeredPoints = points.map{CGPoint(x: ($0.x), y: ($0.y) + amountToScoot)}
        }
        return centeredPoints
    }
}

