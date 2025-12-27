import SwiftUI
import CoreData

struct FormularioMovimientoView: View {

    @Environment(\.dismiss) private var dismiss
    @StateObject private var viewModel: FormularioMovimientoViewModel

    @FetchRequest(sortDescriptors: []) private var categorias: FetchedResults<Categoria>
    @FetchRequest(sortDescriptors: []) private var tipos: FetchedResults<TipoMovimiento>
    @FetchRequest(sortDescriptors: []) private var cuentas: FetchedResults<Cuenta>

    @State private var mostrarAlertaEliminar = false

    init(
        context: NSManagedObjectContext,
        movimiento: Movimiento?
    ) {
        _viewModel = StateObject(
            wrappedValue: FormularioMovimientoViewModel(
                context: context,
                movimiento: movimiento
            )
        )
    }

    var body: some View {
        NavigationStack {
            Form {
                TextField("Monto (Ej: 25.50)", text: $viewModel.monto)
                    .keyboardType(.decimalPad)

                DatePicker("Fecha", selection: $viewModel.fecha, displayedComponents: .date)

                Picker("Tipo de movimiento", selection: $viewModel.tipoSeleccionado) {
                    ForEach(tipos) { tipo in
                        Text(tipo.nombre ?? "").tag(tipo as TipoMovimiento?)
                    }
                }

                Picker("Categoría", selection: $viewModel.categoriaSeleccionada) {
                    ForEach(categorias) { categoria in
                        Text(categoria.nombre ?? "").tag(categoria as Categoria?)
                    }
                }

                Picker("Cuenta", selection: $viewModel.cuentaSeleccionada) {
                    ForEach(cuentas) { cuenta in
                        Text(cuenta.nombre ?? "").tag(cuenta as Cuenta?)
                    }
                }

                TextField(
                    "Notas (Opcional)",
                    text: Binding(
                        get: { viewModel.notas ?? "" },
                        set: { viewModel.notas = $0.isEmpty ? nil : $0 }
                    )
                )

                Button("Guardar") {
                    viewModel.guardarMovimiento()
                    dismiss()
                }
                if viewModel.esEdicion {
                    Section {
                        Button(role: .destructive) {
                            mostrarAlertaEliminar = true
                        } label: {
                            HStack {
                                Spacer()
                                Text("Eliminar movimiento")
                                Spacer()
                            }
                        }
                    }
                }
            }
            .navigationTitle(
                viewModel.esEdicion ? "Editar movimiento" : "Nuevo movimiento"
            )
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancelar") { dismiss() }
                }
            }
            .alert("Eliminar movimiento",
                   isPresented: $mostrarAlertaEliminar) {
                Button("Eliminar", role: .destructive) {
                    viewModel.eliminarMovimiento()
                    dismiss()
                }
                Button("Cancelar", role: .cancel) {}
            } message: {
                Text("Esta acción no se puede deshacer")
            }
        }
    }
}
