//
//  Symbol.swift
//  Manuscript
//
//  Created by Ivy on 10/1/20.
//

import Foundation
import SwiftUI

class Symbol{
    var symbolType: SymbolEnum?
    var symbolPositionOnStaff: SymbolPosition?;
    
    init(symbolType: String, symbolPositionOnStaff: String){
        self.symbolType = stringToEnum(value: symbolType);
        self.symbolPositionOnStaff=SymbolPosition(rawValue: symbolPositionOnStaff);
    }
    
    func stringToEnum(value: String)-> SymbolEnum?{
        switch value{
        case "12-8-Time":
            return SymbolEnum.twelveeighttime
        case "2-2-Time":
            return SymbolEnum.twotwotime
        case "2-4-Time":
            return SymbolEnum.twofourtime
        case "3-4-Time":
            return SymbolEnum.threefourtime
        case "3-8-Time":
            return SymbolEnum.threeeighttime
        case "4-4-Time":
            return SymbolEnum.fourfourtime
        case "6-8-Time":
            return SymbolEnum.sixeighttime
        case "9-8-Time":
            return SymbolEnum.nineeighttime
        case "Barline" :
            return SymbolEnum.barline
        case "C-Clef":
            return SymbolEnum.cclef
        case "Common-Time":
            return SymbolEnum.commontime
        case "Cut-Time":
            return SymbolEnum.cuttime
        case "Dot":
            return SymbolEnum.dot
        case "Double-Sharp":
            return SymbolEnum.doublesharp
        case "Eighth-Note":
            return SymbolEnum.eighthnote
        case "Eighth-Rest":
            return SymbolEnum.eighthrest
        case "F-Clef":
            return SymbolEnum.fclef
        case "Flat":
            return SymbolEnum.flat
        case "G-Clef":
            return SymbolEnum.gclef
        case "Half-Note":
            return SymbolEnum.halfnote
        case "Natural":
            return SymbolEnum.natural
        case "Quarter-Note":
            return SymbolEnum.quarternote
        case "Quarter-Rest" :
            return SymbolEnum.quarterrest
        case "Sharp":
            return SymbolEnum.sharp
        case "Sixteenth-Note":
            return SymbolEnum.sixteenthnote
        case "Sixteenth-Rest":
            return SymbolEnum.sixteenthrest
        case "Sixty-Four-Note":
            return SymbolEnum.sixtyfournote
        case "Sixty-Four-Rest":
            return SymbolEnum.sixtyfourrest
        case "Thirty-Two-Note":
            return SymbolEnum.thirtytwonote
        case "Thirty-Two-Rest":
            return SymbolEnum.thirtytworest
        case "Whole-Half-Rest":
            return SymbolEnum.wholehalfrest
        case "Whole-Note":
            return SymbolEnum.wholenote
        
        
        default:
            return nil
        }
    }
    func symbolEnum()-> Image?{
        switch self.symbolType{
            case .twelveeighttime:
                return Image("Symbols/12-8-time")
            case .twotwotime:
                return Image("Symbols/2-2-time")
            case .twofourtime:
                return Image("Symbols/2-4-time")
            case .threefourtime:
                return Image("Symbols/3-4-time")
            case .threeeighttime:
                return Image("Symbols/3-8-time")
            case .fourfourtime:
                return Image("Symbols/4-4-time")
            case .sixeighttime:
                return Image("Symbols/6-8-time")
            case .nineeighttime:
                return Image("Symbols/9-8-time")
            case .barline:
                return Image("Symbols/Barline")
            case .cclef:
                return Image("Symbols/C-Clef")
            case .commontime:
                return Image("Symbols/Common-Time")
            case .cuttime:
                return Image("Symbols/Cut-Time")
            case .dot:
                return Image("Symbols/Dot")
            case .doublesharp:
                return Image("Symbols/Double-Sharp")
            case .eighthnote:
                return Image("Symbols/Eighth-Note")
            case .eighthrest:
                return Image("Symbols/Eighth-Rest")
            case .fclef:
                return Image("Symbols/F-Clef")
            case .flat:
                return Image("Symbols/Flat")
            case .gclef:
                return Image("Symbols/G-Clef")
            case .halfnote:
                return Image("Symbols/Half-Note")
            case .natural:
                return Image("Symbols/Natural")
            case .quarternote:
                return Image("Symbols/Quarter-Note")
            case .quarterrest:
                return Image("Symbols/Quarter-Rest")
            case .sharp:
                return Image("Symbols/Sharp")
            case .sixteenthnote:
                return Image("Symbols/Sixteenth-Note")
            case .sixteenthrest:
                return Image("Symbols/Sixteenth-Rest")
            case .sixtyfournote:
                return Image("Symbols/Sixty-Four-Note")
            case .sixtyfourrest:
                return Image("Symbols/Sixty-Four-Rest")
            case .thirtytwonote:
                return Image("Symbols/Thirty-Two-Note")
            case .thirtytworest:
                return Image("Symbols/Thirty-Two-Rest")
            case .wholehalfrest:
                return Image("Symbols/Whole-Half-Rest")
            case .wholenote:
                return Image("Symbols/Whole-Note")
            
            //If all else fails, display a G-Clef
            default:
                return Image("Symbols/G-Clef")
            }
    }
}
