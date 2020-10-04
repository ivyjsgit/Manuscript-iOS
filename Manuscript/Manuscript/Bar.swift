//
//  Bar.swift
//  Manuscript
//
//  Created by Ivy on 10/4/20.
//

import Foundation
class Bar{
    var timeSignature: TimeSignature = TimeSignature.fourfourtime
    var clef: Clef = Clef.cclef
    var lineSpaces: [SymbolPosition: [NoteRest]] = [SymbolPosition.a:[],
                                                    SymbolPosition.b:[],
                                                    SymbolPosition.c:[],
                                                    SymbolPosition.d:[],
                                                    SymbolPosition.e:[],
                                                    SymbolPosition.g:[]]
}
