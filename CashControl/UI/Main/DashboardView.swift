//
//  DashboardView.swift
//  CashControl
//
//  Created by LEONARDO FAVIO  on 7/12/25.
//

import SwiftUI

struct DashboardView: View{
    @Environment(\.managedObjectContext) private var context
        @StateObject private var vm: DashboardViewModel
        
        init() {
            _vm = StateObject(wrappedValue: DashboardViewModel(context: PersistenceController.shared.context))
        }
        
        var body: some View {
            NavigationStack {
                List(vm.categoriasTotales) { item in
                    HStack {
                        Image(systemName: item.categoria.icon ?? "questionmark.circle")
                            .frame(width: 30)
                        Text(item.categoria.nombre ?? "Sin nombre")
                            .font(.headline)
                        Spacer()
                        Text("$\(item.total, specifier: "%.2f")")
                            .font(.title3)
                            .fontWeight(.bold)
                            .foregroundColor(.red)
                    }
                    .padding(.vertical, 5)
                }
                .navigationTitle("Dashboard")
            }
        }
    }
