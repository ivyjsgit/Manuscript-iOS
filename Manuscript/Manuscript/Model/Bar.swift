//
//  Bar.swift
//  Manuscript
//
//  Created by Ivy on 10/4/20.
//

import Foundation
class Bar{
    var timeSignature: TimeSignature = TimeSignature.fourfourtime
    var clef: Clef = Clef.gclef
    var lineSpaces: [SymbolPosition: [[NoteRest]]] = [SymbolPosition.a:[[]], //The inner array is for representing chords.
                                                    SymbolPosition.b:[[]],
                                                    SymbolPosition.c:[[]],
                                                    SymbolPosition.d:[[]],
                                                    SymbolPosition.e:[[]],
                                                    SymbolPosition.g:[[]]]
    
    init(clef: Clef){
        self.clef=clef
    }
    
    //For a single note, it will look like [note]
    func addChordToLine(position: SymbolPosition, notes: [NoteRest]){
        var previous_chords = lineSpaces[position]
        previous_chords?.append(notes)
    }
    
    func changeTimeSig(timeSignature: TimeSignature){
        self.timeSignature = timeSignature
    }
    
}
