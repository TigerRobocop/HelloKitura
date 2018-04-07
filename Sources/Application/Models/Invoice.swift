//
//  Invoice.swift
//  HelloKituraPackageDescription
//
//  Created by Liv Souza on 07/04/18.
//

import Foundation
import Application/Enums

public class Invoice {
    
    let id: Int
    let value: Float
    let item: Item
    let type: Type
    let date: String
    
    // default
    init(id: Int,
         value: Float,
         item: Item,
         type: Type,
         date: String) throws {
        
        if id < 0 {
            throw Error.invalidID
        }
        if value < 0 {
            throw Error.invalidValue
        }
        if value.  == 0 {
            throw Error.emptyValue
        }
        
        self.id = id
        self.value = value
        self.item = item
        self.type = type
        self.date = date
    }
    
    // convenience
    convenience init(_ json: [String : Any]) throws {
        try self.init(id: json[JSONField.id] as! Int,
                      value: json[JSONField.value] as! Float,
                      item: json[JSONField.item] as! Item,
                      type: json[JSONField.type] as! Type,
                      date: json[JSONField.date] as! String)
    }
    
    var asJson: [String: Any] {
        get {
            return [JSONField.id: id,
                    JSONField.value: value,
                    JSONField.item: item,
                    JSONField.type: type,
                    JSONField.date: date]
        }
    }
    
    func asMap() -> [String:Any] {
        var map: [String:Any] = [:]
        
        map["id"] = id
        map["value"] = value
        map["item"] = item
        map["type"] = type
        map["date"] = date
        
        return map
    }
    
    func getId() -> Int { return id }
    func getValue() -> Float { return value }
    func getItem() -> Item { return item }
    func getType() -> Type { return type }
    func getDate() -> String { return date }
}
