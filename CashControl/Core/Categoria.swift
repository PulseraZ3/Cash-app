//
//  Categoria.swift
//  CashControl
//
//  Created by LEONARDO FAVIO  on 5/12/25.
//

import Foundation
struct Categoria: Identifiable, Codable, Hashable{
    let id: UUID
    var nombre: String
    var sistemaIcono: String?
    var colorHex: String?
    var permite: [TipoMovimiento]
    
    init(id: UUID = UUID(), nombre: String, sistemaIcono: String? = nil, colorHex: String? = nil, permite: [TipoMovimiento] = [.gasto]) {
        self.id = id
        self.nombre = nombre
        self.sistemaIcono = sistemaIcono
        self.colorHex = colorHex
        self.permite = permite
    }
}
