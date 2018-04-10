//
//  Error.swift
//  HelloKituraPackageDescription
//
//  Created by Liv Souza on 07/04/18.
//

// Criar enumeration com tipos de erro: id inválido, preço inválido e valor ausente. Mudar classe Compra para ter validações que usem esses erros

import Foundation

public enum Errors: Error {
    
    case invalidID
    case invalidValue
    case emptyValue
}
