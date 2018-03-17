//
//  Punch.swift
//  HelloKituraPackageDescription
//
//  Created by Liv Souza on 17/03/18.
//

import Foundation

class Punch {
    var id: Int?\
    var description: String
    var quantidade: Float
    var tags: [String]?
    var date: Date
    var value: Float
    
    init (json: [String: Any]) -> Compra {
        if let descricao = json["descricao"]
    , let quantidade = json ["quantidade"]
    , let data = json["data"]
    
    }
}
