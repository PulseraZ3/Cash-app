import SwiftUI
import CoreData

struct ExpensesView: View {
    
    @Environment(\.managedObjectContext) private var context
    
    @State private var movimientoSeleccionado: Movimiento?
    @State private var crearNuevo = false
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(key: "fecha", ascending: false)],
        animation: .default
    )
    private var movimientos: FetchedResults<Movimiento>
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(movimientos) { movimiento in
                    Button {
                        movimientoSeleccionado = movimiento 
                    } label: {
                        filaMovimiento(movimiento)
                    }
                    .buttonStyle(.plain)
                }
            }
            .navigationTitle("Expenses Logs")
            .toolbar {
                Button {
                    crearNuevo = true // CREAR
                } label: {
                    Image(systemName: "plus")
                }
            }
            
            // 👉 EDITAR
            .sheet(item: $movimientoSeleccionado) { movimiento in
                FormularioMovimientoView(
                    context: context,
                    movimiento: movimiento
                )
            }
            
            // 👉 CREAR
            .sheet(isPresented: $crearNuevo) {
                FormularioMovimientoView(
                    context: context,
                    movimiento: nil
                )
            }
        }
    }
    
    private func filaMovimiento(_ movimiento: Movimiento) -> some View {
        HStack {
            // Icono de categoría
            if let icono = movimiento.categoria?.icon {
                Image(systemName: icono)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24, height: 24)
                    .foregroundColor(.blue)
            }
            
            // Información principal
            VStack(alignment: .leading, spacing: 4) {
                Text(
                    movimiento.nota?.isEmpty == false
                    ? movimiento.nota!
                    : "Sin nombre"
                )
                .font(.subheadline)
                .foregroundColor(.primary)
                
                if let fecha = movimiento.fecha {
                    Text(fecha, style: .relative)
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
            
            Spacer()
            
            // Monto
            Text("S/ \(movimiento.monto, specifier: "%.2f")")
                .font(.headline)
                .foregroundColor(
                    movimiento.tipo?.nombre == "Gasto"
                    ? .red
                    : .green
                )
        }
        .padding(.vertical, 6)
    }
}
