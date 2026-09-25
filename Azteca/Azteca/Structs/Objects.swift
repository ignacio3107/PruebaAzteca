//
//  Objects.swift
//  Azteca
//
//  Created by Ignacio Hernández on 23/09/26.
//

import UIKit

// MARK: - Objetos Home
struct HomeOption {
    var title: String
    var id: Int
    var isSelect: Bool
    var type: TypeField
    var rows: Int
}

// MARK: - Objetos detalle
struct DetailOption {
    let homeOption: HomeOption
    var descript: String
    var rows: Int
}

struct ColorOption {
    var title: String
    var color: UIColor
    var isSelect: Bool
}

struct GenderOption {
    var title: String
    var isSelect: Bool
}
