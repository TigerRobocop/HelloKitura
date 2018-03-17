//
//  Punch.swift
//  HelloKituraPackageDescription
//
//  Created by Liv Souza on 17/03/18.
//

import Foundation

public class Punch {
    var id: Int?
    var description: String = ""
    var quantidade: Float = 0
    var tags: [String]?
    var date: String = ""
    var value: Float = 0
    
    init? (json: [String: Any])  {
        if let descricao = json["descricao"] as? String
        , let quantidade = json ["quantidade"] as? Float
        , let data = json["data"] as? String
        , let valor = json["valor"] as? Float
        , let tags = json["tags"] as? [String] {
            
            self.description = descricao
            self.quantidade = quantidade
            self.date = data
            self.tags = tags
            self.value = valor
        }
    }
    
    func asMap() -> [String:Any] {
        var map: [String:Any] = [:]
        
        map["id"] = id
        map["descricao"] = description
        map["quantidade"] = quantidade
        map["tags"] = tags
        map["data"] = date
        map["valor"] = value
        
        return map
        
    }
    
    
}
