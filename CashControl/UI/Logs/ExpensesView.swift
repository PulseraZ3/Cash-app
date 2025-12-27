import SwiftUI
import CoreData

struct ExpensesView: View {
    @Environment(\.managedObjectContext) private var context
    @Environment(\.dismiss) var dismiss
    
    @State private var showingFormulario = false
    
    // Lista de movimientos
    @State private var movimientos: [Movimiento] = []

    // Repositorio para manejar CoreData
    private var repository: MovimientoRepository

    init(context: NSManagedObjectContext) {
        self.repository = MovimientoRepository(context: context)
    }

    var body: some View {
        NavigationStack {
            
            List {
                ForEach(movimientos, id: \.id) { movimiento in
                    HStack {
                        if let icono = movimiento.categoria?.icon {
                                Image(systemName: icono)
                                    .resizable()
                                    .frame(width: 24, height: 24)
                                    .foregroundColor(.blue) // o lo que quieras
                            }
                        VStack(alignment: .leading) {
                            Text(movimiento.nota ?? "Sin nombre")
                                .font(.subheadline)
                                .foregroundColor(.black).padding(.bottom, 5)
                            Text(movimiento.fecha.map{
                                let formato = RelativeDateTimeFormatter()
                                formato.unitsStyle = .full
                                formato.locale = Locale(identifier: "es")
                                return formato.localizedString(for: $0, relativeTo: Date())
                            } ?? "Sin fecha")
                            .font(.subheadline)
                            .foregroundStyle(.gray)
                        }
                        Spacer()
                        Text("S/\(movimiento.monto, specifier: "%.2f")") // formato de cadenas para double = %.2f
                            .font(.headline)
                            .foregroundColor(movimiento.tipo?.nombre == "Gasto" ? .red : .green)
                    }
                    .padding(.vertical, 4)
                    .listRowSeparator(.hidden)
                }
            }
            .listStyle(.plain)
            .navigationTitle("Expenses Logs")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        showingFormulario = true
                    }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingFormulario, onDismiss: loadMovimientos) {
                FormularioMovimientoView(context: context)
                    .presentationDetents([.medium, .large], selection: .constant(.large))
                    .presentationDragIndicator(.hidden)
            }
            .onAppear(perform: loadMovimientos)
        }
    }

    private func loadMovimientos() {
        movimientos = repository.getAllMovimientos()
    }
}
