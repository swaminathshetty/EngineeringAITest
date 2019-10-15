//
//  ServiceModel.swift
//  EngineeringAITest
//
//  Created by Swaminath-Ojas on 15/10/19.
//  Copyright © 2019 Swaminath-Ojas. All rights reserved.
//

import Foundation

struct ModelResponse:Codable{
    let hits:[hitsArray]?
}
struct hitsArray:Codable {
    let title:String?
    let created_at:String
}
