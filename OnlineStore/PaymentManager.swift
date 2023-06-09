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
import Alamofire

class PaymentManager: ObservableObject, WalleePaymentResultObserver {
    let baseUrl = "https://app-wallee.com"
    let spaceId = UserDefaults.standard.string(forKey: "spaceId") ?? ""
    let userId = UserDefaults.standard.string(forKey: "userId") ?? ""
    let userToken = UserDefaults.standard.string(forKey: "userToken") ?? ""
    
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
            "lineItems": listItems
        ] as [String : Any]
        
        AF.request("\(baseUrl)\(path)", method: .post, parameters: requestData, encoding: JSONEncoding.default, headers: headers).validate(statusCode: 200 ..< 299).responseData { response in
            switch response.result {
                case .success(let data):
                    do {
                        let res = try JSONDecoder().decode(TransactionResponse.self, from: data)
                        self.getTransactionToken(transactionId: res.id)
                    } catch {
                        print("Error: Trying to convert response")
                        return
                    }
                case .failure(let error):
                    print(error)
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
        let userTokenBase64 = Data(base64Encoded: userToken)!
        let secretKey = SymmetricKey(data: userTokenBase64)
        let signature = HMAC<SHA256>.authenticationCode(for: token, using: secretKey)
        let signatureBase64 = Data(signature).urlSafeBase64EncodedString()

        return [headerBase64, payloadBase64, signatureBase64].joined(separator: ".")
    }
    
    func getTransactionToken(transactionId: Int) {
        let path = "/api/transaction/createTransactionCredentials?spaceId=\(self.spaceId)&id=\(transactionId)"

        // headers
        let jwt = prepareJWT(path: path)
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(jwt)"
        ]
        
        AF.request("\(baseUrl)\(path)", method: .post, parameters: nil, encoding: JSONEncoding.default, headers: headers).validate(statusCode: 200 ..< 299).responseData { response in
            switch response.result {
                case .success(let data):
                    do {
                        guard let response = String(data: data, encoding: .utf8) else {
                            print("Error converting response")
                            return
                        }
                        self.token = response
                        self.presentedModal = true
                        self.showToast = false
                    }
                case .failure(let error):
                    print(error)
            }
        }

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


