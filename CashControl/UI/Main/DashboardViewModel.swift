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

extension DashboardViewModel {
    var totalGeneral: Double {
        categoriasTotales.reduce(0) { $0 + $1.total }
    }
}

extension DashboardViewModel {
    
    func disponible(presupuesto: Double) -> Double {
        presupuesto - totalGeneral
    }
    
    func porcentajeDisponible(presupuesto: Double) -> Double {
        guard presupuesto > 0 else { return 1 }
        return disponible(presupuesto: presupuesto) / presupuesto
    }
}



