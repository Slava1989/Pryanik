//
//  NetworkManager.swift
//  Pryanilk
//
//  Created by Veaceslav Chirita on 7/14/20.
//  Copyright © 2020 Veaceslav Chirita. All rights reserved.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
    func getData(completed: @escaping (ResponseModel?) -> Void) {
        
        guard let url = URL(string: API_URL) else {
            completed(nil)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                completed(nil)
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(nil)
                return
            }
            
            guard let data = data else {
                completed(nil)
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(ResponseModel.self, from: data)
                completed(response)
            } catch {
                print(error.localizedDescription)
                completed(nil)
            }
        }
        task.resume()
    }
}
