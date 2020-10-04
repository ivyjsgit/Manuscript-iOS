//
//  ManuscriptApp.swift
//  Manuscript
//
//  Created by Ivy on 10/2/20.
//

import SwiftUI

@main
struct ManuscriptApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
