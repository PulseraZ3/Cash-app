//
//  CashControlApp.swift
//  CashControl
//
//  Created by LEONARDO FAVIO  on 5/12/25.
//

import SwiftUI

@main
struct CashControlApp: App {
    let persistenceController = PersistenceController.shared
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext,
                              persistenceController.context)
        }
    }
}
