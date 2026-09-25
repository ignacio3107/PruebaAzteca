//
//  DetailVC.swift
//  Azteca
//
//  Created by Ignacio Hernández on 24/09/26.
//

import Foundation
import UIKit

class DetailVC: UIViewController {
    deinit{
        print("deinit-\(#function)")
    }
    
    // MARK: - Variables
    var coordinator: DetailCoord!
    var viewModel: DetailVM!
    
    // MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Funciones Inicio
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNeedsStatusBarAppearanceUpdate()
        self.tableView.register(UINib(nibName: Celdas.cameraTableViewCell.rawValue, bundle: nil), forCellReuseIdentifier: Celdas.cameraTableViewCell.rawValue)
        self.tableView.register(UINib(nibName: Celdas.imageTableViewCell.rawValue, bundle: nil), forCellReuseIdentifier: Celdas.imageTableViewCell.rawValue)
        self.tableView.register(UINib(nibName: Celdas.textFieldTableViewCell.rawValue, bundle: nil), forCellReuseIdentifier: Celdas.textFieldTableViewCell.rawValue)
        self.tableView.register(UINib(nibName: Celdas.checkBoxTableViewCell.rawValue, bundle: nil), forCellReuseIdentifier: Celdas.checkBoxTableViewCell.rawValue)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.viewModel.delegate = self
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(ocultarTeclado))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
        self.viewModel.initInfo()
    }
    
    @objc func ocultarTeclado() {
        view.endEditing(true)
    }
}

// MARK: - UITableViewDelegate & UITableViewDataSource
extension DetailVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.viewModel.getNumberOfSections(tableView: tableView)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.getNumberOfRowsInSection(tableView: tableView, section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return self.viewModel.cellForRowAt(tableView, indexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.viewModel.selectOption(tableView: tableView, indexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = .lightGray
        
        let label = UILabel()
        label.text = self.viewModel.textForHeaderInSection(section: section)
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .black
        
        label.translatesAutoresizingMaskIntoConstraints = false
        headerView.addSubview(label)
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 16),
            label.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -16),
            label.centerYAnchor.constraint(equalTo: headerView.centerYAnchor)
        ])
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return Constant.Celdas.heightHeaderGral
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.viewModel.heightForRow(indexPath: indexPath)
    }
}

// MARK: - UIImagePickerControllerDelegate
extension DetailVC: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let fotoTomada = info[.editedImage] as? UIImage ?? info[.originalImage] as? UIImage
        if let imagen = fotoTomada {
            self.viewModel.reloadSectionPhoto(image: imagen)
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}

// MARK: - UITextFieldDelegate
extension DetailVC : UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if string.isEmpty {
            return true
        }
        
        let currentText = textField.text ?? ""
        guard let rangeOfText = Range(range, in: currentText) else { return false }
        let newText = currentText.replacingCharacters(in: rangeOfText, with: string)
        switch textField.tag {
        case 0:
            // Solo caracteres / letras (Evita números y símbolos)
            let regexLetras = Constant.Regex.characteres
            let predicado = NSPredicate(format:"SELF MATCHES %@", regexLetras)
            if !predicado.evaluate(with: string) {
                return false
            }
            return newText.count <= Constant.MaxDigits.name
        default:
            // Solo números (0 al 9)
            let caracteresPermitidos = CharacterSet.decimalDigits
            let conjuntoDestino = CharacterSet(charactersIn: string)
            let isNumber = caracteresPermitidos.isSuperset(of: conjuntoDestino)
            if !isNumber {
                return false
            }
            return newText.count <= Constant.MaxDigits.phone
        }
    }
}

// MARK: - Services Delegate
extension DetailVC: DetailProtocol {
    func refreshSection(indexSet: IndexSet) {
        self.tableView.reloadSections(indexSet, with: .automatic)
    }
    
    func refreshTableViewCell(indexPath: IndexPath) {
        self.tableView.reloadRows(at: [indexPath], with: .automatic)
    }
    
    func refreshTableView() {
        self.tableView.reloadData()
    }
}
