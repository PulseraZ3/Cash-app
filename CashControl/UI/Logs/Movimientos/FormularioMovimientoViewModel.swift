    //
    //  FormularioMovimientoView.swift
    //  CashControl
    //
    //  Created by LEONARDO FAVIO  on 7/12/25.
    //

    import Foundation
    import CoreData
    import Combine

final class FormularioMovimientoViewModel: ObservableObject {
    
    @Published var monto: String = ""
    @Published var fecha: Date = Date()
    @Published var categoriaSeleccionada: Categoria?
    @Published var tipoSeleccionado: TipoMovimiento?
    @Published var cuentaSeleccionada: Cuenta?
    @Published var notas: String? = nil
    private let repository: MovimientoRepository
    private let context: NSManagedObjectContext
    private let movimiento: Movimiento?
    var esEdicion: Bool {
        movimiento != nil
    }
    init(context: NSManagedObjectContext,    movimiento: Movimiento? = nil){
        self.context = context
        self.repository = MovimientoRepository(context: context)
        self.movimiento = movimiento
        if let firstCategoria = try? context.fetch(Categoria.fetchRequest()).first {
            self.categoriaSeleccionada = firstCategoria
        }
        if let firstTipo = try? context.fetch(TipoMovimiento.fetchRequest()).first {
            self.tipoSeleccionado = firstTipo
        }
        
        if let firstCuenta = try? context.fetch(Cuenta.fetchRequest()).first {
            self.cuentaSeleccionada = firstCuenta
        }
        if let movimiento = movimiento {
            cargarDatos(movimiento)
        }else {
            cargarValoresPorDefecto()
        }
    }
    private func cargarDatos(_ movimiento: Movimiento) {
        monto = String(movimiento.monto)
        fecha = movimiento.fecha ?? Date()
        categoriaSeleccionada = movimiento.categoria
        tipoSeleccionado = movimiento.tipo
        cuentaSeleccionada = movimiento.cuenta
        notas = movimiento.nota
    }
    private func cargarValoresPorDefecto() {
        categoriaSeleccionada = (try? context.fetch(Categoria.fetchRequest()))?.first
        tipoSeleccionado = (try? context.fetch(TipoMovimiento.fetchRequest()))?.first
        cuentaSeleccionada = (try? context.fetch(Cuenta.fetchRequest()))?.first
    }
    func guardarMovimiento() {
        guard
            let montoDouble = Double(monto),
            montoDouble > 0,
            let categoria = categoriaSeleccionada,
            let tipo = tipoSeleccionado,
            let cuenta = cuentaSeleccionada
        else {
            print("Formulario inválido")
            return
        }
        
        do {
            if let movimiento = movimiento {
                try repository.actualizarMovimiento(
                    movimiento: movimiento,
                    monto: montoDouble,
                    fecha: fecha,
                    categoria: categoria,
                    tipo: tipo,
                    cuenta: cuenta,
                    nota: notas
                )
            } else {
                try repository.guardarMovimiento(
                    monto: montoDouble,
                    fecha: fecha,
                    categoria: categoria,
                    tipo: tipo,
                    cuenta: cuenta,
                    nota: notas
                )
            }
            
            NotificationCenter.default.post(
                name: .movimientoGuardado,
                object: nil
            )
            
        } catch {
            print("Error al guardar movimiento: \(error)")
        }
    }
    func eliminarMovimiento() {
        guard let movimiento = movimiento else { return }

        do {
            try repository.eliminarMovimiento(movimiento)
        } catch {
            print("Error al eliminar movimiento: \(error)")
        }
    }

}
