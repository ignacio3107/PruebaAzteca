//
//  Strings.swift
//  Azteca
//
//  Created by Ignacio Hernández on 23/09/26.
//

import Foundation

enum Controllers: String {
    case homeVC = "HomeVC"
    case detailVC = "DetailVC"
    case defaultVC = "DefaultVC"
}

enum Celdas: String {
    // Home
    case checkBoxTableViewCell = "CheckBoxTableViewCell"
    // Detail
    case cameraTableViewCell = "CameraTableViewCell"
    case imageTableViewCell = "ImageTableViewCell"
    case textFieldTableViewCell = "TextFieldTableViewCell"
}

enum TypeField: String {
    case photo = "Photo"
    case image = "Image"
    case name = "Name"
    case phone = "Phone"
    case age = "Age"
    case gender = "Gender"
    case color = "Color"
}
