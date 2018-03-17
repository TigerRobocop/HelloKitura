import Foundation
import Kitura
import LoggerAPI
import Configuration
import CloudEnvironment
import KituraContracts
import Health
import SwiftyJSON

public let projectPath = ConfigurationManager.BasePath.project.path
public let health = Health()

public class App {
    let router = Router()
    let cloudEnv = CloudEnv()
    
    var compras: [Int:Any] = [:]
    var indice = 1

    public init() throws {
        router.all(middleware: BodyParser())
        
        // Run the metrics initializer
        initializeMetrics(router: router)
    }

    func postInit() throws {
        // Endpoints
        initializeHealthRoutes(app: self)
        
        // GET ALL
        router.get("/punches") {
            request, response, next in
            var result: [Any] = []
            for valor in self.compras.values {
                result.append(valor)
            }
            
            response.send(JSON(result).description)
            next()
        }
        
        // INSERT NEW
        router.post("/punch") {
            request, response, next in
            if let data = request.body?.asJSON,
                let compra = Punch(json: data) {
                let chave = self.indice
                self.indice += 1
                compra.id = chave
                self.compras[chave] = compra
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
