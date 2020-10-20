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
    func loadImage(name: String) -> CIImage?{
        guard let inputImage = UIImage(named: name) else{ return nil }
        let beginImage = CIImage(image: inputImage)!
        return beginImage
    }
    func convertUIImageToCGImage(image: UIImage) -> CGImage! {
        let inputImage = CIImage(image: image)!
        let context = CIContext(options: nil)
        if context != nil {
            return context.createCGImage(inputImage, from: inputImage.extent)
        }
        return nil
    }
}

