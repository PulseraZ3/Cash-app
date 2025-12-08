//
//  DatosIniciales.swift
//  CashControl
//
//  Created by LEONARDO FAVIO  on 7/12/25.
//

import CoreData
struct DatosIniciales {
    static func load(context: NSManagedObjectContext){
        
        //verificar si ya existen tipo de movimientos
        let tipoRequest: NSFetchRequest<TipoMovimiento> = TipoMovimiento.fetchRequest()
        
        if let count = try? context.count(for: tipoRequest), count == 0{
            createTipoMovimiento(nombre: "Gasto", context: context)
            createTipoMovimiento(nombre: "Ingreso", context: context)
        }
        
        let categoriaRequest: NSFetchRequest<Categoria> = Categoria.fetchRequest()
        
        if let count = try? context.count(for: categoriaRequest), count == 0{
            let categorias = [
                "Comida",
                "Transporte",
                "Servicios",
                "Entretenimiento",
                "Salud",
                "Educacion",
                "Otros"
            ]//creamos la categoria con los nombres anterior mencionados $0 = primer parametro
            categorias.forEach{
                createCategoria(nombre: $0, context: context)
            }
        }
        let nombreCuenta: NSFetchRequest<Cuenta> = Cuenta.fetchRequest()
        if let count = try? context.count(for: nombreCuenta), count == 0{
            let cuentas = [
                "Yape",
                "Plin",
                "Efectivo",
                "BCP",
                "BBVA",
                "Scotiabank",
                "InterBank"
            ]
            cuentas.forEach{
                createCuenta(nombre: $0,context: context)
            }
        }
        
        try? context.save()
    }
    // funciones para crear los items
        private static func createTipoMovimiento(nombre: String, context: NSManagedObjectContext) {
            let tipo = TipoMovimiento(context: context)
            tipo.id = UUID()
            tipo.nombre = nombre
        }

        private static func createCategoria(nombre: String, context: NSManagedObjectContext) {
            let categoria = Categoria(context: context)
            categoria.id = UUID()
            categoria.nombre = nombre
        }
        private static func createCuenta(nombre: String, context: NSManagedObjectContext) {
            let cuenta = Cuenta(context: context)
            cuenta.id = UUID()
            cuenta.nombre = nombre
        }
}
