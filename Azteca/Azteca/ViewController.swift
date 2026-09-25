//
//  ViewController.swift
//  Azteca
//
//  Created by Ignacio Hernández on 23/09/26.
//

import UIKit

class ViewController: UIViewController {

    // MARK: - IBOutlets
    
    @IBOutlet weak var viewGreen: UIView!
    @IBOutlet weak var imgCenter: UIImageView!
    
    // MARK: - Funciones Inicio
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UIView.animate(withDuration: 0.8, animations: {
                    self.imgCenter.transform = CGAffineTransform(scaleX: 18, y: 18)
                    self.imgCenter.alpha = 0.0
                    self.viewGreen.alpha = 0.0
                }) { finished in
                    if finished {
                        let vc = NavigationBridge().create(.homeVC)
                        let nvc = UINavigationController(rootViewController: vc)
                        nvc.modalPresentationStyle = .fullScreen
                        nvc.isNavigationBarHidden = true
                        self.present(nvc, animated: false, completion: nil)
                    }
                }
    }
}

