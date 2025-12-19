//
//  DashboardViewModel.swift
//  CashControl
//
//  Created by LEONARDO FAVIO  on 11/12/25.
//
import Foundation
import Combine
import CoreData

final class DashboardViewModel: ObservableObject {
    @Published var categoriasTotales: [CategoriaTotal] = []
    
    private let repository: MovimientoRepository
    
    struct CategoriaTotal: Identifiable {
        let id = UUID()
        let categoria: Categoria
        let total: Double
    }
    
    init(context: NSManagedObjectContext) {
        self.repository = MovimientoRepository(context: context)
        cargarTotales()
    }
    
    func cargarTotales() {
        let categorias = repository.getAllCategory()
        categoriasTotales = categorias.map { categoria in
            let total = repository.totalCategorias(categoria)
            return CategoriaTotal(categoria: categoria, total: total)
        }
    }
}

