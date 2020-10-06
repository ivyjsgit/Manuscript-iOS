//
//  DrawableStaff.swift
//  Manuscript
//
//  Created by Ivy on 10/6/20.
//

import Foundation
import SwiftUI
struct DrawableStaff{
    var drawing: Drawing = Drawing()
    var drawingList: [Drawing] = [Drawing]()
    var paths: [Path] = [Path]()
    var pathHolder = Path()
    var color = Color.primary
    var lineWidth: CGFloat = 3.0
}
