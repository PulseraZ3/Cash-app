//
//  FormularioMovimientoView.swift
//  CashControl
//
//  Created by LEONARDO FAVIO  on 7/12/25.
//

import SwiftUI
import CoreData

struct FormularioMovimientoView: View {
    
    @Environment(\.managedObjectContext) private var context
    @Environment(\.dismiss) private var dismiss
    
    @StateObject private var viewModel: FormularioMovimientoViewModel
    
    @FetchRequest(
        sortDescriptors: [],
        animation: .default
        )
    private var categorias: FetchedResults<Categoria>
    
    
    @FetchRequest(
            sortDescriptors: [],
            animation: .default
        )
    private var tipos: FetchedResults<TipoMovimiento>

    
        @FetchRequest(
            sortDescriptors: [],
            animation: .default
        )
    private var cuentas: FetchedResults<Cuenta>
    
    init(context: NSManagedObjectContext){
        _viewModel = StateObject(
            wrappedValue: FormularioMovimientoViewModel(context: context)
        )
    }
    
    var body: some View{
        NavigationStack{
            Form{
                Section(header: Text("Monto")){
                    TextField("Ej: 25.50", text: $viewModel.monto)
                        .keyboardType(.decimalPad)
                }
            }
        }
    }
}
