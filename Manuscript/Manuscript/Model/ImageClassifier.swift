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
    func classifyPath(path:Drawing) -> String?{
        //Possibly load a white CIImage of 300x300
        //Use min and max functions and math to adjust the points to look more centred.
        //Do the mapping onto the CIImage using CIImage tools to map the symbol onto it
        //Save as pixelBuffer
        //???
        //Profit
        
        //For some reason, CGImages are recognized as half of their size???
        let drawSize = CGSize(width: 150, height: 150)
        
        let imageRenderer = UIGraphicsImageRenderer(size: drawSize)
        let symbolAsCIImage = imageRenderer.image { ctx in
            ctx.cgContext.setFillColor(UIColor.white.cgColor)
            ctx.cgContext.fill(CGRect(x: 0, y: 0, width: drawSize.width, height: drawSize.height))
            ctx.cgContext.setStrokeColor(UIColor.black.cgColor)
            ctx.cgContext.setLineWidth(2)

            
            var points = path.points
            //Do math to center points here
            
            let symbolWidth = abs(findMaxX(cgpoints: points)) - abs(findMinX(cgpoints: points))
            let symbolHeight = abs(findMaxY(cgpoints: points)) - abs(findMinX(cgpoints: points))
            
            print("Height: \(symbolHeight) Width: \(symbolWidth)")

            let first = points.removeFirst()
            ctx.cgContext.move(to: first)
            ctx.cgContext.addLines(between: points)
            ctx.cgContext.drawPath(using: .fillStroke)


        }
        
        //???
        return classify(image: symbolAsCIImage.cgImage!)
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
        return xs.min()!

    }
    
    func findMaxX(cgpoints: [CGPoint]) -> Float{
        let xs:[Float] = cgpoints.map ({(point:CGPoint) -> Float in
            return Float(point.x
)        })
        return xs.max()!

    }
    
    func findMinY(cgpoints: [CGPoint]) -> Float{
        let ys:[Float] = cgpoints.map ({(point:CGPoint) -> Float in
            return Float(point.y
)        })
        return ys.min()!

    }
    
    func findMaxY(cgpoints: [CGPoint]) -> Float{
        let ys:[Float] = cgpoints.map ({(point:CGPoint) -> Float in
            return Float(point.y
)        })
        return ys.min()!

    }
    
}

