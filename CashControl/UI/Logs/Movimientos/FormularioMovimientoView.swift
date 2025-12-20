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
        NavigationStack {
            Form {
                TextField("Monto (Ej: 25.50)", text: $viewModel.monto)
                    .keyboardType(.decimalPad)
                
                DatePicker("Fecha", selection: $viewModel.fecha, displayedComponents: .date)
                
                Picker("Tipo de movimiento", selection: $viewModel.tipoSeleccionado) {
                    ForEach(tipos, id: \.self) { tipo in
                        Text(tipo.nombre ?? "").tag(tipo as TipoMovimiento?)
                    }
                }
                .pickerStyle(.menu)
                
                Picker("Categoría", selection: $viewModel.categoriaSeleccionada) {
                    ForEach(categorias, id: \.self) { categoria in
                        Text(categoria.nombre ?? "").tag(categoria as Categoria?)
                    }
                }
                .pickerStyle(.menu)
                Picker("Cuenta", selection: $viewModel.cuentaSeleccionada) {
                    ForEach(cuentas, id: \.self) { cuenta in
                        Text(cuenta.nombre ?? "").tag(cuenta as Cuenta?)
                    }
                }
                .pickerStyle(.menu)
                TextField("Notas (Opcional)", text: Binding(
                    get: { viewModel.notas ?? "" },
                    set: { viewModel.notas = $0.isEmpty ? nil : $0 }
                ))
                Section {
                    Button("Guardar") {
                        viewModel.guardarMovimiento()
                        dismiss()
                    }
                }
            }
            .navigationTitle("New Expense Log")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                

                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancelar") {
                        dismiss()
                    }
                    .foregroundColor(.cyan)
                }
            }
        }
    }
}
