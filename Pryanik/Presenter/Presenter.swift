//
//  Presenter.swift
//  Pryanilk
//
//  Created by Veaceslav Chirita on 7/14/20.
//  Copyright © 2020 Veaceslav Chirita. All rights reserved.
//

import Foundation

class Presenter {
    
    let responseService: ResponseService!
    
    init() {
        responseService = ResponseService()
    }
    
    func getAPIResponse(callBack: @escaping (ResponseModel?) -> ()) {
        responseService.responseFromApi { (response) in
            if (response != nil) {
                callBack(response)
            } else {
                callBack(nil)
            }
        }
    }
    
}
