//
//  HeaderModel.swift
//  curl-builder
//
//  Created by Douglass Kiser on 11/28/20.
//

import Foundation

struct Header: Codable {
    var key: String
    var value: String
}

extension Header: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(key)
        hasher.combine(value)
    }
}
