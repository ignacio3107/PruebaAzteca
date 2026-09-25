//
//  HomeVC.swift
//  Azteca
//
//  Created by Ignacio Hernández on 24/09/26.
//

import Foundation
import UIKit

class HomeVC: UIViewController {
    // MARK: - Variables
    var coordinator: HomeCoord!
    var viewModel: HomeVM!
    
    // MARK: - IBOutlets
    @IBOutlet weak var viewWarning: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var constraintHeightViewWarning: NSLayoutConstraint!
    
    // MARK: - IBActions
    @IBAction func goToDetail(_ sender: UIButton) {
        self.viewModel.goToDetailView()
    }
    
    
    // MARK: - Funciones Inicio
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNeedsStatusBarAppearanceUpdate()
        self.tableView.register(UINib(nibName: Celdas.checkBoxTableViewCell.rawValue, bundle: nil), forCellReuseIdentifier: Celdas.checkBoxTableViewCell.rawValue)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.viewModel.delegate = self
        self.configure()
        self.viewModel.initInfo()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .darkContent
    }
    
    func configure(){
        self.viewWarning.layer.cornerRadius = 15.0
        self.btnNext.layer.cornerRadius = self.btnNext.frame.height / 2
        self.btnNext.isEnabled = false
    }
}

// MARK: - UITableViewDelegate & UITableViewDataSource
extension HomeVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.getNumberOfRows(tableView: tableView)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return self.viewModel.cellForRowAt(tableView, indexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.viewModel.selectOption(tableView: tableView, indexPath: indexPath)
    }
}

// MARK: - Services Delegate
extension HomeVC: HomeProtocol {
    func updateButtonNext(isActive: Bool) {
        if isActive{
            self.btnNext.isEnabled = true
            self.btnNext.backgroundColor = UIColor.systemMint
            self.btnNext.setTitleColor(UIColor.white, for: .normal)
            UIView.animate(withDuration: 0.3) {
                self.viewWarning.alpha = 0.0
                self.constraintHeightViewWarning.constant = .zero
                self.viewWarning.layoutIfNeeded()
            }
        } else {
            self.btnNext.isEnabled = false
            self.btnNext.backgroundColor = UIColor.systemGray4
            self.btnNext.setTitleColor(UIColor.black, for: .normal)
            UIView.animate(withDuration: 0.5) {
                self.viewWarning.alpha = 1.0
                self.constraintHeightViewWarning.constant = 65.0
                self.viewWarning.layoutIfNeeded()
            }
        }
    }
    
    func refreshTableViewCell(indexPath: IndexPath) {
        self.tableView.reloadRows(at: [indexPath], with: .automatic)
    }
    
    func refreshTableView() {
        self.tableView.reloadData()
    }
}
