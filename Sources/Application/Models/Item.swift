//
//  Item.swift
//  HelloKituraPackageDescription
//
//  Created by Liv Souza on 07/04/18.
//

//6. Criar classe Produto com id, descrição, tags e usá-la ao invés de Compra.descricao

import Foundation

class Item
{
    var id: Int
    var description: String
    var tags: [String]
    
    init(id: Int,
         description: String,
         tags: [String]) {
        
        self.id = id
        self.description = description
        self.tags = tags
    }
}
