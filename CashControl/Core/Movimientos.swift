//
//  Movimientos.swift
//  CashControl
//
//  Created by LEONARDO FAVIO  on 5/12/25.
//

import Foundation
struct Movimientos: Identifiable, Codable,Hashable{
    let id: UUID
    var monto: Decimal
    var tipo: TipoMovimiento
    var categoriaID: UUID
    var fecha: Date
    var descripcion: String?
    init(id: UUID, monto: Decimal, tipo: TipoMovimiento, categoriaID: UUID, fecha: Date, descripcion: String? = nil) {
        self.id = id
        self.monto = monto
        self.tipo = tipo
        self.categoriaID = categoriaID
        self.fecha = fecha
        self.descripcion = descripcion
    }
}
