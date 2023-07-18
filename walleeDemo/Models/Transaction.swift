//
//  Transaction.swift
//  walleeDemo
//
//  Created by Ira Paliy on 31.05.23.
//

import Foundation

struct Transaction: Codable {
    var currency: String
    var lineItems: [TransactionListItem]
}

struct TransactionListItem: Codable {
    var uniqueId = UUID()
    var amountIncludingTax: String
    var name: String
    var quantity: Int
    var type: String
}

struct  TransactionResponse: Codable {
    let id: Int
}

struct JWTHeader: Encodable {
  let typ = "JWT"
  let alg = "HS256"
  let ver = 1
}

struct JWTPayload: Encodable {
    let sub: String
    let iat: Int
    let requestPath: String
    let requestMethod: String
    
    init (userId: String, path: String, requestMethod: String) {
           self.sub = userId
           self.iat = Int(Date().timeIntervalSince1970)
           self.requestPath = path
           self.requestMethod = requestMethod
       }
   }

