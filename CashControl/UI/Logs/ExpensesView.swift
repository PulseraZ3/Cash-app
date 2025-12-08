//
//  ExpensesView.swift
//  CashControl
//
//  Created by LEONARDO FAVIO  on 7/12/25.
//

import SwiftUI

struct ExpensesView: View {
    @Environment(\.managedObjectContext) private var context
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
            }
            .toolbar {

                // Título a la izquierda
                ToolbarItem(placement: .principal) {
                    Text("Expenses Logs")
                        .font(.headline)
                        .fontWeight(.bold)
                }

                // Botón Add a la derecha
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink {
                        FormularioMovimientoView(context: context)
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
        }

        
    }
}
