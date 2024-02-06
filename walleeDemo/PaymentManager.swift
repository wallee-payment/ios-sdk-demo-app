//
//  PaymentManager.swift
//  walleeDemo
//
//  Created by Ira Paliy on 12.05.23.
//

import Foundation
import UIKit
import PostFinanceCheckoutSdk
import CryptoKit
import AlertToast
import SwiftUI
import Alamofire

class PaymentManager: ObservableObject, PostFinanceCheckoutResultObserver {
    let baseUrl = "https://checkout.postfinance.ch"
    var spaceId = UserDefaults.standard.string(forKey: "spaceId") ?? ""
    var userId = UserDefaults.standard.string(forKey: "userId") ?? ""
    var userToken = UserDefaults.standard.string(forKey: "userToken") ?? ""
    
    @Published var token: String = ""
    @Published var result: String = ""
    @Published var toast: Toast = Toast(shouldShow: false, type: .complete(Color.green), title: nil)
    @Published var wallee: PostFinanceCheckoutSdk?
    

    func paymentResult(paymentResultMessage: PaymentResult) {
        self.toast = Toast(shouldShow: true, type: paymentResultMessage.code == .COMPLETED ? .complete(Color.green) : .error(Color.red), title: paymentResultMessage.code.rawValue)
        self.result = paymentResultMessage.code.rawValue
            
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.toast = Toast(shouldShow: false, type: .complete(Color.green))
        }
    }
    
    func createTransaction(cartProducts: [CartItem], completion: @escaping () -> Void) {
        spaceId = UserDefaults.standard.string(forKey: "spaceId") ?? ""
        userId = UserDefaults.standard.string(forKey: "userId") ?? ""
        userToken = UserDefaults.standard.string(forKey: "userToken") ?? ""
        
        let path = "/api/transaction/create?spaceId=\(String(describing: spaceId))"
        
        // headers
        let jwt = prepareJWT(path: path)
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(jwt)"
        ]

        // payload
        let listItems = cartProducts.map { item in [
                "uniqueId": UUID().uuidString,
                "amountIncludingTax": String(format: "%.2f", Float(item.count) * item.product.price),
                "name": item.product.name,
                "quantity": item.count,
                "type": "SHIPPING"
                ]
             }
        let requestData = [
            "currency": cartProducts[0].product.currency,
            "language": "en-US",
            "lineItems": listItems
        ] as [String : Any]
        
        AF.request("\(baseUrl)\(path)", method: .post, parameters: requestData, encoding: JSONEncoding.default, headers: headers).validate(statusCode: 200 ..< 699).responseData { response in
            switch response.result {
                case .success(let data):
                    do {
                        let res = try JSONDecoder().decode(TransactionResponse.self, from: data)
                        self.getTransactionToken(transactionId: res.id, completion: completion)
                    } catch {
                        self.toast = Toast(shouldShow: false, type: .error(Color.red))
                        self.toast = Toast(shouldShow: true, type: .error(Color.red), title: "Transaction failed, check user credentials")
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                            self.toast = Toast(shouldShow: false, type: .error(Color.red))
                        }
                    }
                case .failure:
                    self.toast = Toast(shouldShow: true, type: .error(Color.red), title: "Failed to create the transaction, please double check user credentials")
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                        self.toast = Toast(shouldShow: false, type: .error(Color.red))
                    }
            }
        }
    }
    
    func prepareJWT(path: String) -> String {
        // header
        let headerJSON = try! JSONEncoder().encode(JWTHeader())
        let headerBase64 = headerJSON.urlSafeBase64EncodedString()
        
        // payload
        let payloadJSON = try! JSONEncoder().encode(JWTPayload(userId: userId, path: path, requestMethod: "POST"))
        let payloadBase64 = payloadJSON.urlSafeBase64EncodedString()
        
        let token = Data((headerBase64 + "." + payloadBase64).utf8)
        
        // signature
        let userTokenBase64 = Data(base64Encoded: userToken) ?? Data()
        let secretKey = SymmetricKey(data: userTokenBase64)
        let signature = HMAC<SHA256>.authenticationCode(for: token, using: secretKey)
        let signatureBase64 = Data(signature).urlSafeBase64EncodedString()

        return [headerBase64, payloadBase64, signatureBase64].joined(separator: ".")
    }
    
    func getTransactionToken(transactionId: Int, completion: @escaping () -> Void) {
        let path = "/api/transaction/createTransactionCredentials?spaceId=\(self.spaceId)&id=\(transactionId)"

        // headers
        let jwt = prepareJWT(path: path)
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(jwt)"
        ]
        
        AF.request("\(self.baseUrl)\(path)", method: .post, parameters: nil, encoding: JSONEncoding.default, headers: headers).validate(statusCode: 200 ..< 699).responseData { response in
                switch response.result {
                case .success(let data):
                    do {
                        guard let response = String(data: data, encoding: .utf8) else {
                            print("Error converting response")
                            return
                        }
                        self.token = response
                        completion()
                        self.toast = Toast(shouldShow: false, type: .error(Color.red))
                    }
                case .failure(let error):
                    print(error)
                }
        }

    }
    

    func onOpenSdkPress(cartProducts: [CartItem]){
        wallee = PostFinanceCheckoutSdk(eventObserver: self)
        guard let wallee = wallee else { return }
        wallee.configureApplePay(merchantId: "merchant.wallee.demo.app")
        self.toast = Toast(shouldShow: true, type: .loading)
        createTransaction(cartProducts: cartProducts) {
            wallee.launchPayment(token: self.token, isSwiftUI: true)
        }
    }
}


