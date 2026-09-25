//
//  DetailCoord.swift
//  Azteca
//
//  Created by Ignacio Hernández on 24/09/26.
//

import Foundation
import UIKit


// MARK: - DetailCoord class
final class DetailCoord: NavigationBridge {
    weak private var mainController: UIViewController?
    private var params: [HomeOption]
    
    init?(params: [HomeOption]) {
        if params.count == .zero {
            return nil
        }
        let paramsOrd = params.sorted { $0.id < $1.id }
        self.params = paramsOrd
    }
}

// MARK: - DetailCoord extension
extension DetailCoord: Coordinator {
    func createModule() -> UIViewController {
        let vc = ViewController.instantiate(destinoVC: Controllers.detailVC) as! DetailVC
        vc.modalPresentationStyle = .fullScreen
        vc.coordinator = self
        vc.viewModel = DetailVM(view: vc, coordinator: self, params: params)
        self.mainController = vc
        return vc
    }
    
    func showPicker(){
        let camaraPicker = UIImagePickerController()
        camaraPicker.delegate = self.mainController as! DetailVC
        camaraPicker.sourceType = .camera
        camaraPicker.allowsEditing = true
        if UIImagePickerController.isCameraDeviceAvailable(.front) {
            camaraPicker.cameraDevice = .front
        }
        self.mainController?.present(camaraPicker, animated: true, completion: nil)
    }
    
    func showAlert(_ message: String) {
        let alert = UIAlertController(
            title: Constant.Alert.titleError,
                message: "\(message)",
                preferredStyle: .alert
            )
        let btnAceptar = UIAlertAction(title: Constant.Alert.btnAcept, style: .default) { _ in
                //...
            }
            alert.addAction(btnAceptar)
        self.mainController?.present(alert, animated: true)
    }
    
}
