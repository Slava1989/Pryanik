//
//  ResponseModel.swift
//  Pryanilk
//
//  Created by Veaceslav Chirita on 7/14/20.
//  Copyright © 2020 Veaceslav Chirita. All rights reserved.
//

import Foundation

struct ResponseModel: Codable {
    var data: [ResponseData]
    var view: [String]
}

struct ResponseData: Codable {
    var name: String
    var data: MainResponse
}

struct MainResponse: Codable {
    var text: String?
    var url: String?
    var selectedId: Int?
    var variants: [ResponseVariants]?
}

struct ResponseVariants: Codable {
    var id: Int
    var text: String
}

    
