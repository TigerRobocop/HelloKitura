import Foundation
import Kitura
import LoggerAPI
import Configuration
import CloudEnvironment
import KituraContracts
import Health
import SwiftyJSON
import Models

public let projectPath = ConfigurationManager.BasePath.project.path
public let health = Health()

public class App {
    let router = Router()
    let cloudEnv = CloudEnv()
    
    var invoices: [Int:Invoice] = [:]
    var purchases: [Int:Purchases] = [:]
    
    var compras: [Int:Any] = [:]
    var index = 1

    public init() throws {
        router.all(middleware: BodyParser())
        
        // Run the metrics initializer
        initializeMetrics(router: router)
    }
   
    func postInit() throws {
        // Endpoints
        initializeHealthRoutes(app: self)
        
        func getAsMap<obj: Protocolo>(list: [Int: Type]) -> [Any] {
            var result: [Any] = []
            for value in list.values{
                result.append(value.asMap())
            }
            return result
        }
        
        // INVOICE
        router.post("/invoice") { // Create Invoice
            request, response, next in
            self.customPrint(request)
            if let data = request.body?.asJSON,
                let invoice = Invoice(json: data) {
                let key = self.index
                self.index += 1
                invoice.id = key
                self.invoices[key] = invoice
                response.send(JSON(invoice.asMap()).description)
            }
            next()
        }
        
        router.get("/invoices") { // Read All - Invoices
            request, response, next in
            var result: [Any] = getAsMap(list: self.invoices)
            response.send(JSON(result).description)
            next()
        }
        
        router.get("/invoice/:id") { // Read - Invoice
            request, response, next in
            if let keyStr = request.parameters["id"],
                let key = Int(keyStr),
                let data = self.invoices[key] {
                response.send(JSON(data).description)
            }
            next()
        }
        
        router.put("/invoice/:id") { // Update - Invoice
            request, response, next in
            if let keyStr = request.parameters["id"],
                let key = Int(keyStr),
                let data = request.body?.asJSON,
                let invoice = Invoice(json: data) {
                self.invoices[key] = invoice
                invoice.id = key
                response.send(JSON(invoice.asMap()).description)
            }
            next()
        }
        
        router.delete("/invoice/:id") { // Delete - Invoice
            request, response, next in
            if let keyStr = request.parameters["id"],
                let key = Int(keyStr),
                let data = self.invoices[key] {
                self.invoices[key] = nil
                response.send(JSON(data).description)
            }
            next()
        }
        
        // PURCHASE
        
        router.post("/purchase") { // Create Purchase
            request, response, next in
            self.customPrint(request)
            if let data = request.body?.asJSON,
                let puchase = Purchase(json: data) {
                let key = self.index
                self.index += 1
                puchase.id = key
                self.puchases[key] = purchase
                response.send(JSON(purchase.asMap()).description)
            }
            next()
        }
        
        router.get("/purchases") { // Read All - Purchases
            request, response, next in
            var result: [Any] = getAsMap(list: self.purchases)
            response.send(JSON(result).description)
            next()
        }

        router.get("/purchase/:id") { // Read - Purchases
            request, response, next in
            if let keyStr = request.parameters["id"],
                let key = Int(keyStr),
                let data = self.purchases[key] {
                response.send(JSON(data).description)
            }
            next()
        }
        
        router.put("/purchase/:id") { // Update - Purchases
            request, response, next in
            if let keyStr = request.parameters["id"],
                let key = Int(keyStr),
                let data = request.body?.asJSON,
                let purchase = Purchase(json: data) {
                self.purchases[key] = purchase
                purchase.id = key
                response.send(JSON(purchase.asMap()).description)
            }
            next()
        }
        
        router.delete("/purchase/:id") { // Delete - Purchases
            request, response, next in
            if let keyStr = request.parameters["id"],
                let key = Int(keyStr),
                let data = self.purchases[key] {
                self.purchases[key] = nil
                response.send(JSON(data).description)
            }
            next()
        }
        
        
        
        // Original
        router.get("/compra") { // Read all
            request, response, next in
            var result: [Any] = []
            for valor in self.compras.values {
                result.append(valor)
            }
            response.send(JSON(result).description)
            next()
        }
        
        router.get("/compra/:id") { // Read
            request, response, next in
            if let chaveStr = request.parameters["id"],
                let chave = Int(chaveStr),
                let data = self.compras[chave] {
                response.send(JSON(data).description)
            }
            next()
        }
        
        router.put("/compra/:id") { // Update
            request, response, next in
            if let chaveStr = request.parameters["id"],
                let chave = Int(chaveStr),
                let data = request.body?.asJSON,
                let compra = Compra(json: data) {
                self.compras[chave] = compra
                compra.id = chave
                response.send(JSON(compra.asMap()).description)
            }
            next()
        }
        
        router.delete("/compra/:id") { // Delete
            request, response, next in
            if let chaveStr = request.parameters["id"],
                let chave = Int(chaveStr),
                let data = self.compras[chave] {
                self.compras[chave] = nil
                response.send(JSON(data).description)
            }
            next()
        }
        
    }

    public func run() throws {
        try postInit()
        Kitura.addHTTPServer(onPort: cloudEnv.port, with: router)
        Kitura.run()
    }
}
