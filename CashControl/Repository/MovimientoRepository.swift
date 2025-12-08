//
//  MovimientoRepository.swift
//  CashControl
//
//  Created by LEONARDO FAVIO  on 7/12/25.
//

import CoreData

protocol MovimientoRepositoryProtocol {
    
    func guardarMovimiento(
        monto: Double,
        fecha: Date,
        categoria: Categoria,
        tipo: TipoMovimiento,
        cuenta: Cuenta,
        nota: String?
    ) throws
}
final class MovimientoRepository: MovimientoRepositoryProtocol {
    
    private let context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext) {
        self.context = context
    }
    func guardarMovimiento(
            monto: Double,
            fecha: Date,
            categoria: Categoria,
            tipo: TipoMovimiento,
            cuenta: Cuenta,
            nota: String?,
            
        ) throws {

            let movimiento = Movimiento(context: context)
            movimiento.id = UUID()
            movimiento.monto = monto
            movimiento.fecha = fecha
            movimiento.categoria = categoria
            movimiento.tipo = tipo
            movimiento.cuenta = cuenta
            movimiento.nota = nota
            try context.save()
        }
}
