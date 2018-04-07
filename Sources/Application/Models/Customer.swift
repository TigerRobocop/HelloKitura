//
//  Customer.swift
//  HelloKituraPackageDescription
//
//  Created by Liv Souza on 07/04/18.
// 7. Criar classe Cliente com id, nome, tags

import Foundation

class Customer
{
    var id: Int
    var name: String
    var tags: [String]
    
    init(id: Int,
         name: String,
         tags: [String]) {
        
        self.id = id
        self.name = name
        self.tags = tags
    }
}
