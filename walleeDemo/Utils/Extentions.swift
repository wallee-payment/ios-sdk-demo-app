//
//  Extentions.swift
//  walleeDemo
//
//  Created by Ira Paliy on 05.06.23.
//

import Foundation

extension Data {
  func urlSafeBase64EncodedString() -> String {
    return base64EncodedString()
       .replacingOccurrences(of: "+", with: "-")
       .replacingOccurrences(of: "/", with: "_")
       .replacingOccurrences(of: "=", with: "")
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
