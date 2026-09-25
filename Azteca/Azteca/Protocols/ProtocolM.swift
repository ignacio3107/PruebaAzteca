//
//  ProtocolM.swift
//  Azteca
//
//  Created by Ignacio Hernández on 24/09/26.
//

import Foundation
import UIKit

// MARK: Model main protocol
/// Protocolo general para llamadas a Servicios
@objc  protocol ProtocolM {
    // MARK: - Notificaciones Loading
    @objc optional func showLoading(msj: String)
    @objc optional func hideLoading()
}


// MARK: Coordinator main protocol
protocol Coordinator {
    func createModule() -> UIViewController
}
