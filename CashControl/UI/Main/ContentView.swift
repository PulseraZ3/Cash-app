//
//  ContentView.swift
//  CashControl
//
//  Created by LEONARDO FAVIO  on 5/12/25.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) private var context
    var body: some View {
        TabView{
            DashboardView()
                .tabItem{
                    Label("Dashboard", systemImage: "chart.pie")
                }
            ExpensesView()
                .tabItem{
                    Label("Logs", systemImage: "tray")
                }
        }
    }
}
