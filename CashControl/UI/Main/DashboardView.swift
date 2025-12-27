import SwiftUI
import Charts

struct DashboardView: View {
    @Environment(\.managedObjectContext) private var context
    @StateObject private var vm: DashboardViewModel
    @AppStorage("presupuestoMensual") private var presupuestoMensual: Double = 0
    @State private var presupuestoInput: String = ""
    @State private var mostrarAlerta = false
    @State private var alertaMostrada = false
    
    init() {
        _vm = StateObject(
            wrappedValue: DashboardViewModel(
                context: PersistenceController.shared.context
            )
        )
    }
    
    var body: some View {
        NavigationStack {
            List {
                
                Section("Presupuesto") {
                    HStack {
                        Text("Presupuesto mensual")
                        Spacer()
                        
                        TextField("0.00", text: $presupuestoInput)
                            .keyboardType(.decimalPad)
                            .multilineTextAlignment(.trailing)
                            .onChange(of: presupuestoInput) { _, newValue in
                                presupuestoMensual = Double(newValue) ?? 0
                                alertaMostrada = false // reinicia alerta
                            }
                            .frame(width: 100)
                    }
                    
                    HStack {
                        Text("Total gastado")
                        Spacer()
                        Text(vm.totalGeneral, format: .currency(code: "USD"))
                            .bold()
                            .foregroundColor(.red)
                    }
                    
                    HStack {
                        Text("Disponible")
                        Spacer()
                        Text(vm.disponible(presupuesto: presupuestoMensual),
                             format: .currency(code: "USD"))
                            .bold()
                            .foregroundColor(
                                vm.totalGeneral > presupuestoMensual ? .red : .green
                            )
                    }
                    .padding(.vertical, 8)
                }
                
                Section("Gastos por categoría") {
                    Chart(vm.categoriasTotales) { item in
                        BarMark(
                            x: .value("Categoría", item.categoria.nombre ?? "Sin nombre"),
                            y: .value("Total", item.total)
                        )
                    }
                    .frame(height: 220)
                    .padding(.vertical, 8)
                }
                
                Section("Detalle") {
                    ForEach(vm.categoriasTotales) { item in
                        HStack {
                            Image(systemName: item.categoria.icon ?? "questionmark.circle")
                                .frame(width: 30)
                            
                            Text(item.categoria.nombre ?? "Sin nombre")
                            Spacer()
                            
                            Text(item.total, format: .currency(code: "USD"))
                                .bold()
                                .foregroundColor(.red)
                        }
                    }
                }
            }
            .navigationTitle("Dashboard")
        }
        
        //Alerta 20%
        .alert("⚠️ Atención", isPresented: $mostrarAlerta) {
            Button("Entendido", role: .cancel) { }
        } message: {
            Text("Ha alcanzado el 20% de su presupuesto mensual.")
        }
        
        //Eventos
        .onAppear {
            presupuestoInput = String(format: "%.2f", presupuestoMensual)
        }
        .onReceive(NotificationCenter.default.publisher(for: .movimientoGuardado)) { _ in
            vm.cargarTotales()
            verificarAlerta()
        }
    }
    
    // Lógica de alerta
    private func verificarAlerta() {
        let porcentaje = vm.porcentajeDisponible(presupuesto: presupuestoMensual)
        
        if porcentaje <= 0.20 && !alertaMostrada {
            mostrarAlerta = true
            alertaMostrada = true
        }
    }
}
