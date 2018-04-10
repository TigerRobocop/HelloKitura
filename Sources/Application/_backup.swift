//
//  _backup.swift
//  HelloKituraPackageDescription
//
//  Created by Liv Souza on 10/04/18.
//

import Foundation




//        // GET ALL
//        router.get("/punches") {
//            request, response, next in
//            var result: [Any] = []
//            for value in self.purchases.values {
//                result.append(value)
//            }
//
//            response.send(JSON(result).description)
//            next()
//        }
//
//        // INSERT NEW
//        router.post("/punch") {
//            request, response, next in
//            if let data = request.body?.asJSON,
//                let compra = Invoice(json: data) {
//                let key = self.index
//                self.index += 1
//                compra.id = key
//                self.purchases[key] = compra
//                response.send(JSON(data).description)
//            }
//            next()
//
//        }
//
//
//        // EDIT
//        router.put("/punch/:id") {
//            request, response, next in
//            if let chaveStr = request.parameters["id"]
//            , let chave = Int(chaveStr)
//                , let data = request.body?.asJSON {
//                self.compras[chave] = data
//                response.send(JSON(data).description)
//            }
//            next()
//        }
//
//
//        //DELETE
//        router.delete("/punch/:id") {
//            request, response, next in
//            if let chaveStr = request.parameters["id"]
//            , let chave = Int(chaveStr)
//                , let data = self.compras[chave] {
//                self.compras[chave] = nil
//                response.send(JSON(data).description)
//            }
//            next()
//        }
//
//        // INDEX
//        router.get("/") {
//            request, response, next in
//            response.send("Hello, Kitura!")
//            next()
//        }

