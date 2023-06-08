//
//  PaymentManager.swift
//  OnlineStore
//
//  Created by Ira Paliy on 12.05.23.
//

import Foundation
import UIKit
import WalleePaymentSdk
import CryptoKit
import AlertToast
import SwiftUI

class PaymentManager: ObservableObject, WalleePaymentResultObserver {
    let baseUrl = "https://app-wallee.com"
    let spaceId = UserDefaults.standard.string(forKey: "spaceId") ?? ""
    let userId = UserDefaults.standard.string(forKey: "userId") ?? ""
    let userToken = UserDefaults.standard.string(forKey: "userToken") ?? ""
    let cartManager = CartManager()
    
    @Published var token: String = ""
    @Published var resultCallback:String = ""
    @Published var presentedModal: Bool = false
    @Published var showToast: Bool = false
    @Published var toastType: AlertToast.AlertType = .complete(Color.green)
    
    var onPaymentComplete: () -> Void
    init(onPaymentComplete: @escaping () -> Void) {
        self.onPaymentComplete = onPaymentComplete
    }

    func paymentResult(paymentResultMessage: PaymentResult) {
        print("PAYMENT RESULT: ", paymentResultMessage.code)
        self.presentedModal = false
        self.showToast = true
        self.toastType = paymentResultMessage.code == .COMPLETED ? .complete(Color.green) : .error(Color.red)
        self.resultCallback = paymentResultMessage.code.rawValue
        
        if (paymentResultMessage.code == .COMPLETED) {
            onPaymentComplete()
        }
            
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.showToast = false
        }
    }
    
    func createTransaction(cartProducts: [CartItem], completion: @escaping(_ success: Bool) -> Void) {
        // prepare url
        let url = "/api/transaction/create?spaceId=\(String(describing: spaceId))"
        guard let requestUrl = URL(string: "\(baseUrl)\(url)") else { fatalError() }

        var request = URLRequest(url: requestUrl)
        request.httpMethod = "POST"
        
        // headers
        let jwt = prepareJWT(path: url)
        request.addValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json; charset=utf-8", forHTTPHeaderField: "Accept")
        request.addValue("Bearer \(jwt)", forHTTPHeaderField: "Authorization")
        
        // payload
        let listItems = cartProducts.map { item in
            TransactionListItem(amountIncludingTax: String(format: "%.2f", Float(item.count) * item.product.price), name: item.product.name, quantity: item.count, type: "SHIPPING")
            }
        let requestData = Transaction(
            currency: cartProducts[0].product.currency,
            lineItems: listItems
        )
        let jsonData = try? JSONEncoder().encode(requestData)

        request.httpBody = jsonData

        let task = URLSession.shared.dataTask(with: request) {
            data, response, error in
            
            if let data = data {
                do {
                    let res = try JSONDecoder().decode(TransactionResponse.self, from: data)
                    self.fetchTransactionToken(transactionId: res.id)
                } catch let error {
                    print(">>>>")
                    print(error)
                }
            }
        }
        task.resume()
    }
    
    func prepareJWT(path: String) -> String {
        struct Header: Encodable {
          let typ = "JWT"
          let alg = "HS256"
          let ver = 1
        }
        
        struct Payload: Encodable {
            let sub: String
            let iat: Int
            let requestPath: String
            let requestMethod: String
            
            init (path: String) {
                   self.sub = "71232"
                   self.iat = Int(Date().timeIntervalSince1970)
                   self.requestPath = path
                   self.requestMethod = "POST"
               }
           }

        // prepare header
        let headerJSON = try! JSONEncoder().encode(Header())
        let headerBase64 = headerJSON.urlSafeBase64EncodedString()
        
        // prepare payload
        let payloadJSON = try! JSONEncoder().encode(Payload(path: path))
        let payloadBase64 = payloadJSON.urlSafeBase64EncodedString()
        
        let token = Data((headerBase64 + "." + payloadBase64).utf8)
        
        //prepare signature
        let userTokenBase64 = Data(base64Encoded: userToken)!
        let secretKey = SymmetricKey(data: userTokenBase64)
        let signature = HMAC<SHA256>.authenticationCode(for: token, using: secretKey)
        let signatureBase64 = Data(signature).urlSafeBase64EncodedString()

        return [headerBase64, payloadBase64, signatureBase64].joined(separator: ".")
    }
    
    func fetchTransactionToken(transactionId: Int) {
        // prepare url
        let baseUrlString = "https://app-wallee.com/api/transaction/createTransactionCredentials"
        let url = URL(string: "\(baseUrlString)?spaceId=\(String(describing: spaceId))&id=\(String(describing: transactionId))")
        guard let requestUrl = url else { fatalError() }

        var request = URLRequest(url: requestUrl)
        request.httpMethod = "POST"
        
        // headers
        let jwt = prepareJWT(path: "/api/transaction/createTransactionCredentials?spaceId=\(String(describing: spaceId))&id=\(String(describing: transactionId))")
        request.addValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json; charset=utf-8", forHTTPHeaderField: "Accept")
        request.addValue("Bearer \(jwt)", forHTTPHeaderField: "Authorization")
        
        // request
        let task = URLSession.shared.dataTask(with: request) {
            data, response, error in
            
            if let data = data, let response = String(data: data, encoding: .utf8){
                self.token = response
                self.presentedModal = true
                self.showToast = false
            }
        }
        task.resume()
    }
    

    func onOpenSdkPress(cartProducts: [CartItem]){
        let wallee = WalleePaymentSdk(eventObserver: self)
        self.showToast = true
        self.toastType = .loading
         createTransaction(cartProducts: cartProducts, completion: { (success: Bool) -> Void in
        //     if success {
        //     } else {
        //        //   print(">>>error")
        //    }
       })
    }
}


