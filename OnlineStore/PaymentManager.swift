//
//  PaymentManager.swift
//  OnlineStore
//
//  Created by Ira Paliy on 12.05.23.
//

import Foundation
import UIKit
import WalleePaymentSdk

class PaymentManager: ObservableObject, WalleePaymentResultObserver {

    @Published var token: String = ""
    @Published var tokenType = "Simple Token"
    @Published var accountTypeName = "33255 (Lukas)"
    @Published var resultCallback = "============"
    @Published var presentedModal: Bool = false
    
    var _accountType = "33255"
    
    func paymentResult(paymentResultMessage: PaymentResult) {
        print("OBSERVER RESULT - SUCCESS CODE: ", paymentResultMessage.code, " MESSAGE: ")
        var colorCodeMap = [PaymentResultEnum.FAILED: UIColor.red, PaymentResultEnum.COMPLETED: UIColor.green, PaymentResultEnum.CANCELED: UIColor.orange]

        DispatchQueue.main.async {
            self.presentedModal = false
            self.resultCallback = paymentResultMessage.code.rawValue
        }
    }

    func onOpenSdkPress(){
        self.fetchToken(onComplete: { fetchedToken in
            self.token = fetchedToken
            self.presentedModal = true
            let wallee = WalleePaymentSdk(eventObserver: self)
            self.changeWalleeColorSchema(wallee: wallee)
        })
    }

    @IBAction func clearTypeLabel(){
        resultCallback = "============"
    }

    private func changeWalleeColorSchema(wallee: WalleePaymentSdk) {
               let themeProvider = ThemeProvider()
        //        wallee.setLightTheme(light: themeProvider.getNewLightTheme())
        //        wallee.setDarkTheme(dark: themeProvider.getNewDarkTheme())
//        wallee.setCustomTheme(custom: themeProvider.getNewCustomTheme(), baseTheme: .DARK)
//        wallee.setLightTheme(light: themeProvider.getIncompleteLightTheme())
//        wallee.setDarkTheme(dark: themeProvider.getIncompleteDarkTheme())
//        wallee.setCustomTheme(custom: themeProvider.getIncompleteCustomTheme(), baseTheme: .DARK)
//        wallee.setCustomTheme(custom: nil, baseTheme: .LIGHT)
    }
    
    func addTokenManuallyClickSwiftUI(value: String){
        token =  value
    }

    func fetchToken(onComplete: @escaping (String) -> Void){
            guard let url = URL(string: getTokenUrl()) else{
                return
            }


            let task = URLSession.shared.dataTask(with: url){
                data, response, error in

                if let data = data, let token = String(data: data, encoding: .utf8){
                    DispatchQueue.main.async {
                        self.token = token
                        onComplete(token)
                    }
                }
            }

            task.resume()
        }


    func getTokenUrl() -> String{
        var spaceId = ""
        if(_accountType != "33255"){
            spaceId = "?spaceid=" + _accountType
        }

        switch(tokenType) {
        case "Simple Token":
            return "https://dev.customweb.com/schurter/mobile-sdk/create.php"+spaceId //NOTE LSA: original endpoint for creating transactions
        case "New Customer":
            return "https://dev.customweb.com/schurter/mobile-sdk/new-customer.php"+spaceId //NOTE LSA: creates a transaction with customerId set to a new value, so the checkbox to store the token will show up on the payment form, but no existing tokens.

        case "Existing Customer":
            return "https://dev.customweb.com/schurter/mobile-sdk/existing-customer.php"+spaceId // NOTE LSA: creates a transaction with customerId  set to 123customerid456 (an existing customer), so the existing tokens will be listed on the payment form.
        case "Active Token":
            return "https://dev.customweb.com/schurter/mobile-sdk/active-token.php"+spaceId // NOTE LSA: creates a transaction with token set to 2786560 (an existing token), so the active token screen will be displayed.
        default:
            return "https://dev.customweb.com/schurter/mobile-sdk/create.php"+spaceId
        }
    }



    @IBAction func setSimpleToken(){
        tokenType = "Simple Token"
    }

    @IBAction func setNewCustomer(){
        tokenType = "New Customer"

    }

    @IBAction func setExistingCustomer(){
        tokenType = "Existing Customer"
    }
    
    @IBAction func setActiveToken(){
        tokenType = "Active Token"
    }

    @IBAction func setAccountTypeLukasBalcerzak(){
        accountTypeName = "33955 (Lukas Balcerzak)"
        _accountType = "33955"
    }

    @IBAction func setAccountTypeKatja(){
        accountTypeName = "33958 (Katja)"
        _accountType = "33958"
    }

    @IBAction func setAccountTypeLukas(){
        accountTypeName = "33255 (Lukas)"
        _accountType = "33255"
    }
}



extension URLSession {
  func fetchData<T: Decodable>(for url: URL, completion: @escaping (Result<T, Error>) -> Void) {
    self.dataTask(with: url) { (data, response, error) in
      if let error = error {
        completion(.failure(error))
      }

      if let data = data {
        do {
          let object = try JSONDecoder().decode(T.self, from: data)
          completion(.success(object))
        } catch let decoderError {
          completion(.failure(decoderError))
        }
      }
    }.resume()
  }
}

