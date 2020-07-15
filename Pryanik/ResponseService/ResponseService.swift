//
//  ResponseService.swift
//  Pryanilk
//
//  Created by Veaceslav Chirita on 7/14/20.
//  Copyright © 2020 Veaceslav Chirita. All rights reserved.
//

import Foundation

class ResponseService {
    func responseFromApi(callBack: @escaping (ResponseModel?) -> Void) {
        NetworkManager.shared.getData { (response) in
            callBack(response)
        }
    }
}
