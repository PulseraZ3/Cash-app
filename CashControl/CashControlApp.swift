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
    init() {
        DatosIniciales.load(context: persistenceController.context)
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext,
                              persistenceController.context)
        }
    }
}
