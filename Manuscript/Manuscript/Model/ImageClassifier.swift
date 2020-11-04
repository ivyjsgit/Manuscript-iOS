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
        
        let drawSize = CGSize(width: 300, height: 300)
        
        let imageRenderer = UIGraphicsImageRenderer(size: drawSize)
        let symbolAsCIImage = imageRenderer.image { ctx in
            ctx.cgContext.setFillColor(UIColor.white.cgColor)
            ctx.cgContext.fill(CGRect(x: 0, y: 0, width: drawSize.width, height: drawSize.height))
            ctx.cgContext.setStrokeColor(UIColor.black.cgColor)
            ctx.cgContext.setLineWidth(2)

            
            var points = path.points
            //Do math to center points here
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
}

