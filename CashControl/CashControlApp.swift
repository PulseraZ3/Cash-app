//
//  CashControlApp.swift
//  CashControl
//
//  Created by LEONARDO FAVIO  on 5/12/25.
//

import SwiftUI

@main
struct CashControlApp: App {
    @AppStorage("hasSeenOnboarding") private var hasSeenOnboarding = false
    let persistenceController = PersistenceController.shared
    init() {
        DatosIniciales.load(context: persistenceController.context)
    }
    var body: some Scene {
        WindowGroup {
            if hasSeenOnboarding {
                ContentView()
                    .environment(\.managedObjectContext,
                                  persistenceController.context)
            } else {
                OnBoardingView()
            }
        }
    }
}
