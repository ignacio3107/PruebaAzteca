//
//  HomeVM.swift
//  Azteca
//
//  Created by Ignacio Hernández on 24/09/26.
//

import Foundation
import UIKit

// MARK: HomeProtocol
protocol HomeProtocol: AnyObject {
    func refreshTableView()
    func refreshTableViewCell(indexPath: IndexPath)
    func updateButtonNext(isActive: Bool)
}

// MARK: HomeVM class
class HomeVM {
    // MARK: - Params
    private let coordinator: HomeCoord!
    private unowned let vista: HomeVC
    private let model: HomeM
    
    // MARK: - Implementation
    weak var delegate: HomeProtocol?
    
    // MARK: - Variables
    var arrayHomeOptions: [HomeOption] = []
    var arrayParamOptions: [HomeOption] = []
    
    // MARK: - Initializers
    init(view: HomeVC, coordinator: HomeCoord) {
        self.vista = view
        self.coordinator = coordinator
        self.model = HomeM()
        self.model.delegate = self
    }
    
    // MARK: - ::: Funciones :::
    /// Función que obtiene la información necesaria para mostrar en tabla
    func initInfo() {
        self.arrayParamOptions.removeAll()
        self.model.getHomeOptions()
    }
    
    // MARK: - UITableViewDelegate & UITableViewDataSource
    /// Función que retorna el numero de celdas a mostrar
    /// - Parameter tableView: tabla de referencia
    /// - Returns: Valor entero
    func getNumberOfRows(tableView: UITableView) -> Int {
        return self.arrayHomeOptions.count
    }
    
    /// Función que retorna la celda correspondiente
    /// - Parameters:
    ///   - tableView: UITableView
    ///   - indexPath: indexPath
    /// - Returns: UITableViewCell
    func cellForRowAt(_ tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        var obj: HomeOption
        obj = self.arrayHomeOptions[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Celdas.checkBoxTableViewCell.rawValue) as! CheckBoxTableViewCell
        cell.title.text = obj.title.capitalized
        if obj.isSelect {
            cell.setCheckBoxOn()
        } else {
            cell.setCheckBoxOff()
        }
        return cell
        
    }
    
    /// Función que define la acción personalizada al seleccionar una celda
    /// - Parameter tableView: tabla de referencia
    /// - Parameter indexPath: posición seleccionada
    func selectOption(tableView: UITableView, indexPath: IndexPath) {
        var optionSelect: HomeOption
        optionSelect = self.arrayHomeOptions[indexPath.row]
        optionSelect.isSelect = !optionSelect.isSelect
        self.arrayHomeOptions[indexPath.row] = optionSelect
        if optionSelect.isSelect {
            self.arrayParamOptions.append(optionSelect)
        } else {
            if !arrayParamOptions.isEmpty {
                self.arrayParamOptions.removeAll { $0.id == optionSelect.id }
            }
        }
        delegate?.refreshTableViewCell(indexPath: indexPath)
        self.validateButtonStatus()
    }
    
    /// Función que valida las celdas seleccionadas para habilitar o no el botòn de siguiente
    func validateButtonStatus(){
        let buttonActive = self.arrayHomeOptions.contains(where: { $0.isSelect })
        delegate?.updateButtonNext(isActive: buttonActive)
    }
    
    /// Función que presenta la vista de Detalle
    func goToDetailView(){
        self.coordinator.goToDetailView(params: self.arrayParamOptions)
    }
}

// MARK: - HomeMProtocol
extension HomeVM: HomeMProtocol {
    func responseGetOptions(options: [HomeOption]) {
        self.arrayHomeOptions = options
        delegate?.refreshTableView()
    }
}
