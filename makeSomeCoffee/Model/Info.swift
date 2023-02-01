//
//  Info.swift
//  makeSomeCoffee
//
//  Created by Osman Esad on 1.02.2023.
//

import SwiftUI

struct Info: Codable {
    var title: String
    var peopleAttended: Int
    var rules: [String]
    
    enum CodingKeys: CodingKey {
        case title
        case peopleAttended
        case rules
    }
}
