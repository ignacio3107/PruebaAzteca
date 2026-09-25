//
//  Untitled.swift
//  Azteca
//
//  Created by Ignacio Hernández on 24/09/26.
//

import Foundation
import UIKit

// MARK: DetailProtocol
protocol DetailProtocol: AnyObject {
    func refreshTableView()
    func refreshTableViewCell(indexPath: IndexPath)
    func refreshSection(indexSet: IndexSet)
}

// MARK: DetailVM class
class DetailVM {
    // MARK: - Params
    private let coordinator: DetailCoord!
    private unowned let vista: DetailVC
    private let model: DetailM
    private var params: [HomeOption]
    
    // MARK: - Implementation
    weak var delegate: DetailProtocol?
    
    // MARK: - Variables
    var arrayColors: [ColorOption] = []
    var arrayGender: [GenderOption] = []
    var sectionPhoto: Int?
    var newImagePhoto: UIImage?
    
    // MARK: - Initializers
    init(view: DetailVC, coordinator: DetailCoord, params: [HomeOption]) {
        self.params = params
        self.vista = view
        self.coordinator = coordinator
        self.model = DetailM()
        self.model.delegate = self
    }
    
    // MARK: - ::: Funciones :::
    /// Función que obtiene la información necesaria para mostrar en tabla
    func initInfo() {
        self.model.getColorOptions()
    }
    
    func reloadSectionPhoto(image: UIImage){
        self.newImagePhoto = image
        self.delegate?.refreshSection(indexSet: IndexSet(integer: self.sectionPhoto!))
    }
    
    // MARK: - UITableViewDelegate & UITableViewDataSource
    /// Función que retorna el numero de secciones a mostrar
    /// - Parameter tableView: tabla de referencia
    /// - Returns: Valor entero
    func getNumberOfSections(tableView: UITableView) -> Int {
        return self.params.count
    }
    
    /// Función que retorna el numero de celdas a mostrar
    /// - Parameter tableView: tabla de referencia
    /// - Returns: Valor entero
    func getNumberOfRowsInSection(tableView: UITableView, section: Int) -> Int {
        return self.params[section].rows
    }
    
    /// Función que retorna la celda correspondiente
    /// - Parameters:
    ///   - tableView: UITableView
    ///   - indexPath: indexPath
    /// - Returns: UITableViewCell
    func cellForRowAt(_ tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let currentSection = params[indexPath.section]
        
        switch currentSection.type {
            case .photo:
                let cell = tableView.dequeueReusableCell(withIdentifier: Celdas.cameraTableViewCell.rawValue) as! CameraTableViewCell
                if let imgSave = self.newImagePhoto {
                    cell.imgCamera.image =  imgSave
                    cell.imgCamera.isHidden = false
                } else {
                    cell.imgCamera.isHidden = true
                }
                return cell
            case .image:
                let cell = tableView.dequeueReusableCell(withIdentifier: Celdas.imageTableViewCell.rawValue) as! ImageTableViewCell
                cell.imagePhoto.load(link: self.model.getUrlImage())
                return cell
            case .name:
                let cell = tableView.dequeueReusableCell(withIdentifier: Celdas.textFieldTableViewCell.rawValue) as! TextFieldTableViewCell
                cell.imgIcon.image = UIImage(systemName: "pencil")
                cell.campoTexto.keyboardType = .asciiCapable
                cell.campoTexto.delegate = self.vista
                cell.campoTexto.tag =  0
                cell.viewBlock.isHidden = true
                return cell
            case .phone:
                let cell = tableView.dequeueReusableCell(withIdentifier: Celdas.textFieldTableViewCell.rawValue) as! TextFieldTableViewCell
                cell.imgIcon.image = UIImage(systemName: "phone.fill")
                cell.campoTexto.keyboardType = .numberPad
                cell.campoTexto.delegate = self.vista
                cell.campoTexto.tag =  1
                cell.viewBlock.isHidden = true
                return cell
            case .age:
                let cell = tableView.dequeueReusableCell(withIdentifier: Celdas.textFieldTableViewCell.rawValue) as! TextFieldTableViewCell
                cell.imgIcon.image = UIImage(systemName: "calendar")
                cell.viewBlock.isHidden = false
                return cell
            case .gender:
                let cell = tableView.dequeueReusableCell(withIdentifier: Celdas.checkBoxTableViewCell.rawValue) as! CheckBoxTableViewCell
                cell.title.text = self.arrayGender[indexPath.row].title
                cell.viewColor.isHidden = true
                if self.arrayGender[indexPath.row].isSelect {
                    cell.setCheckBoxOn()
                } else {
                    cell.setCheckBoxOff()
                }
                return cell
            case .color:
                let cell = tableView.dequeueReusableCell(withIdentifier: Celdas.checkBoxTableViewCell.rawValue) as! CheckBoxTableViewCell
                cell.viewColor.isHidden = false
                cell.title.text = self.arrayColors[indexPath.row].title
                cell.viewColor.backgroundColor = self.arrayColors[indexPath.row].color
                if self.arrayColors[indexPath.row].isSelect {
                    cell.setCheckBoxOn()
                } else {
                    cell.setCheckBoxOff()
                }
                return cell
            }
    }
    
    /// Función que define la acción personalizada al seleccionar una celda
    /// - Parameter tableView: tabla de referencia
    /// - Parameter indexPath: posición seleccionada
    func selectOption(tableView: UITableView, indexPath: IndexPath) {
        self.vista.view.endEditing(true)
        
        let currentSection = params[indexPath.section]
        let currentRow = indexPath.row
        switch currentSection.type {
        case .photo:
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                self.sectionPhoto = indexPath.section
                self.coordinator.showPicker()
            } else {
                self.coordinator.showAlert(Constant.Alert.messageErrorCamera)
            }
        case .age:
            self.coordinator.showAlert(Constant.Alert.messageIncompleteSection)
        case .gender:
            var genderSelect: GenderOption = self.arrayGender[currentRow]
            genderSelect.isSelect = !genderSelect.isSelect
            self.arrayGender[currentRow] = genderSelect
            if genderSelect.isSelect {
                for (index, _) in self.arrayGender.enumerated() {
                    if index != currentRow {
                        self.arrayGender[index].isSelect = false
                    }
                }
            }
            delegate?.refreshSection(indexSet: IndexSet(integer: indexPath.section))
        case .color:
            var colorSelect: ColorOption = self.arrayColors[currentRow]
            colorSelect.isSelect = !colorSelect.isSelect
            self.arrayColors[indexPath.row] = colorSelect
            delegate?.refreshTableViewCell(indexPath: indexPath)
        default: //.image, .name, .phone
            print("Celda sin acción...")
        }
    }
    
    /// Función que retorna el texto de cada header
    /// - Parameter section: sección de referencia
    func textForHeaderInSection(section: Int) -> String{
        let currentSection = params[section]
        return currentSection.title
    }
    
    /// Función que retorna la altura de la celda por tipo
    /// - Parameter indexPath: posición seleccionada
    func heightForRow(indexPath: IndexPath) -> CGFloat{
        let currentSection = params[indexPath.section]
        switch currentSection.type {
        case .photo:
            return Constant.Celdas.heightPhoto
        case .image:
            return Constant.Celdas.heightImage
        case .name, .phone, .age:
            return Constant.Celdas.heightTextField
        default: // .gender, .color
            return Constant.Celdas.heightDefault
        }
    }
}

// MARK: - HomeMProtocol
extension DetailVM: DetailMProtocol {
    func responseGetColors(options: [ColorOption]) {
        self.arrayColors = options
        self.model.getGenderOptions()
    }
    
    func responseGetGenders(options: [GenderOption]) {
        self.arrayGender = options
        delegate?.refreshTableView()
    }
}
