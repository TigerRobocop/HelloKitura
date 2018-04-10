//
//  Type.swift
//  HelloKituraPackageDescription
//
//  Created by Liv Souza on 07/04/18.

import Foundation

public enum Type: Int {
    
    case single = 0
    case recurring = 1
    
    func isSingle(_ value: Type) -> Bool { return value == .single }
    
    func getStringBy(value: Type) -> String {
        switch value {
        case .single: return "Single purchase"
        case .recurring: return "Recurring purchase"
        }
    }
}
