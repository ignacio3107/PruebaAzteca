//
//  ExtGeneral.swift
//  Azteca
//
//  Created by Ignacio Hernández on 23/09/26.
//

import UIKit

protocol Storyboarded {
    static func instantiate(destinoVC: Controllers) -> UIViewController
}

// MARK: - UIViewController
extension UIViewController: Storyboarded {
    static func instantiate(destinoVC: Controllers) -> UIViewController {
        let storyboard = UIStoryboard(name: destinoVC.rawValue, bundle: nil)
        return storyboard.instantiateViewController(identifier: destinoVC.rawValue)
    }
    
    /// Función que quita el controlador con pop o con dismiss, dependiendo si existe un NavigationController
    func dismissOrPopViewController() {
        if self.navigationController != nil {
            self.navigationController!.popViewController(animated: true)
        } else {
            self.dismiss(animated: true)
        }
    }
}

// MARK: - UIImageView
extension UIImageView {
    func load(link: String) {
        DispatchQueue.global(qos: .utility).async { [weak self] in
            if let url = URL(string: link), let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
