//
//  HomeCoord.swift
//  Azteca
//
//  Created by Ignacio Hernández on 24/09/26.
//

import Foundation
import UIKit


// MARK: - HomeCoord class
final class HomeCoord: NavigationBridge {
    weak private var mainController: UIViewController?
}

// MARK: - HomeCoord extension
extension HomeCoord: Coordinator {
    func createModule() -> UIViewController {
        let vc = ViewController.instantiate(destinoVC: Controllers.homeVC) as! HomeVC
        vc.modalPresentationStyle = .fullScreen
        vc.coordinator = self
        vc.viewModel = HomeVM(view: vc, coordinator: self)
        self.mainController = vc
        return vc
    }
    
    func goToDetailView(params: [HomeOption]){
        let vc = self.create(.detailVC, obj: params)
        self.mainController?.navigationController?.pushViewController(vc, animated: true)
    }
}
