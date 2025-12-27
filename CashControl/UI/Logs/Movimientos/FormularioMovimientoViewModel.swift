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
    
    init(context: NSManagedObjectContext){
        self.context = context
        self.repository = MovimientoRepository(context: context)
        
        if let firstCategoria = try? context.fetch(Categoria.fetchRequest()).first {
                    self.categoriaSeleccionada = firstCategoria
                }
        if let firstTipo = try? context.fetch(TipoMovimiento.fetchRequest()).first {
            self.tipoSeleccionado = firstTipo
        }
                
        if let firstCuenta = try? context.fetch(Cuenta.fetchRequest()).first {
            self.cuentaSeleccionada = firstCuenta
        }
}
    
    func guardarMovimiento(){
            guard
                let montoDouble = Double(monto),
                montoDouble > 0,
                let categoria = categoriaSeleccionada,
                let tipo = tipoSeleccionado,
                let cuenta = cuentaSeleccionada
            else{
                print("Formulario invalido")
                return
            }
            
            do{
                try repository.guardarMovimiento(
                    monto: montoDouble,
                    fecha: fecha,
                    categoria: categoria,
                    tipo: tipo,
                    cuenta: cuenta,
                    nota: notas ?? "" 
                )
                NotificationCenter.default.post(
                            name: .movimientoGuardado,
                            object: nil
                        )
                print("movimiento guardado")
            } catch let error as NSError {
                print("Error al guardar movimiento: \(error), \(error.userInfo)")
            }
        }
    }
