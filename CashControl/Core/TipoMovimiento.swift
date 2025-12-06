//
//  TipoMovimiento.swift
//  CashControl
//
//  Created by LEONARDO FAVIO  on 5/12/25.
//

import Foundation
enum TipoMovimiento: String, CaseIterable,Codable, Identifiable{ // se usa enum debido a que los datos son finitos
    case ingreso = "Ingreso"
    case gasto = "Gasto"
    var id: String { rawValue } // identificador necesario para algo pequenio como el movimiento
    
}

