//
//  DetailM.swift
//  Azteca
//
//  Created by Ignacio Hernández on 24/09/26.
//

import Foundation
import UIKit

// MARK: DetailMProtocol
protocol DetailMProtocol: ProtocolM {
    func responseGetColors(options: [ColorOption])
    func responseGetGenders(options: [GenderOption])
}

@MainActor
final class DetailM {
    // MARK: - Variables
    weak var delegate: DetailMProtocol?
    
    private(set) var arrayColors: [ColorOption] = []
    private(set) var arrayGenders: [GenderOption] = []
    
    
    // MARK: - Llamadas a servicios
    /// Función que regresa la información a pintar en cada una de las celdas de Detalle
    func getUrlImage() -> String {
        return Constant.Detail.linkImage
    }
    
    /// Función que regresa la información a pintar en cada una de las celdas de la sección Color
    func getColorOptions() {
        self.arrayColors.removeAll()
        var option: ColorOption = ColorOption(title: Constant.Color.rojo, color: UIColor.red, isSelect: false)
        self.arrayColors.append(option)
        
        option.title = Constant.Color.verde
        option.color = UIColor.green
        option.isSelect = false
        self.arrayColors.append(option)
        
        option.title = Constant.Color.azul
        option.color = UIColor.blue
        option.isSelect = false
        self.arrayColors.append(option)
        
        option.title = Constant.Color.amarillo
        option.color = UIColor.yellow
        option.isSelect = false
        self.arrayColors.append(option)
        
        option.title = Constant.Color.cafe
        option.color = UIColor.brown
        option.isSelect = false
        self.arrayColors.append(option)
        
        self.delegate?.responseGetColors(options: self.arrayColors)
    }
    
    /// Función que regresa la información a pintar en cada una de las celdas de la sección Género
    func getGenderOptions() {
        self.arrayGenders.removeAll()
        var option: GenderOption = GenderOption(title: Constant.Gender.masculino, isSelect: false)
        self.arrayGenders.append(option)
        
        option.title = Constant.Gender.femenino
        option.isSelect = false
        self.arrayGenders.append(option)
        
        self.delegate?.responseGetGenders(options: self.arrayGenders)
    }
}
