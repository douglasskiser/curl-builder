//
//  MethodsModel.swift
//  curl-builder
//
//  Created by Douglass Kiser on 11/28/20.
//

import Foundation

enum Methods: String, CaseIterable, Identifiable {
    case GET
    case POST
    case DELETE
    case PUT
    case PATCH

    var id: String { self.rawValue }
}
