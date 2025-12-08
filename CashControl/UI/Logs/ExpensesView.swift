    //
    //  ExpensesView.swift
    //  CashControl
    //
    //  Created by LEONARDO FAVIO  on 7/12/25.
    //

    import SwiftUI

struct ExpensesView: View {
    
    @Environment(\.managedObjectContext) private var context
    @State private var showingFormulario = false
    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Expenses Logs")
                        .font(.headline)
                        .fontWeight(.bold)
                }

                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        showingFormulario = true
                    }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingFormulario) {
                FormularioMovimientoView(context: context)
                    .presentationDetents([.medium, .large], selection: .constant(.large))
                    .presentationDragIndicator(.hidden)
            }
        }
    }
}
