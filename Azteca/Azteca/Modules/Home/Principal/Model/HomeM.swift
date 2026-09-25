//
//  HomeM.swift
//  Azteca
//
//  Created by Ignacio Hernández on 24/09/26.
//

import Foundation
import UIKit

// MARK: HomeMProtocol
protocol HomeMProtocol: ProtocolM {
    func responseGetOptions(options: [HomeOption])
}

@MainActor
final class HomeM {
    // MARK: - Variables
    weak var delegate: HomeMProtocol?
    
    private(set) var arrayOptions: [HomeOption] = []
    

    // MARK: - Llamadas a servicios
    /// Función que regresa la información a pintar en cada una de las celdas de Home
    func getHomeOptions() {
        self.arrayOptions.removeAll()
        var option: HomeOption = HomeOption(title: Constant.Home.camera, id: 0, isSelect: false, type: .photo, rows: 1)
        self.arrayOptions.append(option)
        
        option.title = Constant.Home.photo
        option.id = 1
        option.isSelect = false
        option.type = .image
        option.rows = 1
        self.arrayOptions.append(option)
        
        option.title = Constant.Home.fullName
        option.id = 2
        option.isSelect = false
        option.type = .name
        option.rows = 1
        self.arrayOptions.append(option)
        
        option.title = Constant.Home.phone
        option.id = 3
        option.isSelect = false
        option.type = .phone
        option.rows = 1
        self.arrayOptions.append(option)
        
        option.title = Constant.Home.birthdate
        option.id = 4
        option.isSelect = false
        option.type = .age
        option.rows = 1
        self.arrayOptions.append(option)
        
        option.title = Constant.Home.gender
        option.id = 5
        option.isSelect = false
        option.type = .gender
        option.rows = 2
        self.arrayOptions.append(option)
        
        option.title = Constant.Home.favoriteColor
        option.id = 6
        option.isSelect = false
        option.type = .color
        option.rows = 5
        self.arrayOptions.append(option)
        
        self.delegate?.responseGetOptions(options: self.arrayOptions)
    }
}
