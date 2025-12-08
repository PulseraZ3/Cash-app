//
//  MovimientoListViewModel.swift
//  CashControl
//
//  Created by LEONARDO FAVIO  on 8/12/25.
//

import CoreData
import Combine

final class MovimientoListViewModel: ObservableObject {
    @Published var movimientos: [Movimiento] = []
    
    private let repository: MovimientoRepository
    
    init(repository: MovimientoRepository) {
        self.repository = repository
        fetchMovimientos()
    }
    
    func fetchMovimientos(){
        movimientos = repository.getAllMovimientos()
        
    }
    
    
}
