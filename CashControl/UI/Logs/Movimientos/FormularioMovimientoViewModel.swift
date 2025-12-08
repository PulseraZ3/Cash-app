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
    
    private let repository: MovimientoRepository
    
    init(context: NSManagedObjectContext){
        self.repository = MovimientoRepository(context: context)
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
                cuenta: cuenta
                , nota: ""
            )
            print("movimiento guardado")
        } catch{
            print("Error al guardar")
        }
    }
}
