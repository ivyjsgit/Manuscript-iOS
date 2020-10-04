//
//  Staff.swift
//  Manuscript
//
//  Created by Ivy on 10/4/20.
//

import Foundation

class Staff{
    var staffContents: [Bar] = []
    
    init(staffContents: [Bar]){
        self.staffContents=staffContents
    }
    
    func getClefsToDisplay()->[Clef]{
        var deduplicated_clefs = [Clef]()
        
        if staffContents.count>=1{
            deduplicated_clefs.append((staffContents.first!.clef)) //Because we already checked the size is >=1, we can unwrap.
            for bar in self.staffContents{
                if bar.clef != deduplicated_clefs.last{
                    deduplicated_clefs.append(bar.clef)
                }
            }
        }

        return deduplicated_clefs
    }
}
