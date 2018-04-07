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
    var compras: [Int:Any] = [:]
    var index = 1

    public init() throws {
        router.all(middleware: BodyParser())
        
        // Run the metrics initializer
        initializeMetrics(router: router)
    }
    
    func customPrint <T>(_ string : T) {
        print("\(string)")
    }
    

    func postInit() throws {
        // Endpoints
        initializeHealthRoutes(app: self)
        
        
        router.post("/invoice") { // Create
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
        
        
        // GET ALL
        router.get("/punches") {
            request, response, next in
            var result: [Any] = []
            for value in self.purchases.values {
                result.append(value)
            }
            
            response.send(JSON(result).description)
            next()
        }
        
        // INSERT NEW
        router.post("/punch") {
            request, response, next in
            if let data = request.body?.asJSON,
                let compra = Invoice(json: data) {
                let key = self.index
                self.index += 1
                compra.id = key
                self.purchases[key] = compra
                response.send(JSON(data).description)
            }
            next()
            
        }
        
        
        // EDIT
        router.put("/punch/:id") {
            request, response, next in
            if let chaveStr = request.parameters["id"]
            , let chave = Int(chaveStr)
                , let data = request.body?.asJSON {
                self.compras[chave] = data
                response.send(JSON(data).description)
            }
            next()
        }
 
        
        //DELETE
        router.delete("/punch/:id") {
            request, response, next in
            if let chaveStr = request.parameters["id"]
            , let chave = Int(chaveStr)
                , let data = self.compras[chave] {
                self.compras[chave] = nil
                response.send(JSON(data).description)
            }
            next()
        }
 
        // INDEX
        router.get("/") {
            request, response, next in
            response.send("Hello, Kitura!")
            next()
        }
    }

    public func run() throws {
        try postInit()
        Kitura.addHTTPServer(onPort: cloudEnv.port, with: router)
        Kitura.run()
    }
}
