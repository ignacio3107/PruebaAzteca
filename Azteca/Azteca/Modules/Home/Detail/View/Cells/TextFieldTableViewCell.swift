//
//  TextFieldTableViewCell.swift
//  Azteca
//
//  Created by Ignacio Hernández on 24/09/26.
//

import UIKit

class TextFieldTableViewCell: UITableViewCell {

    @IBOutlet weak var viewRound: UIView!
    @IBOutlet weak var imgIcon: UIImageView!
    @IBOutlet weak var campoTexto: UITextField!
    @IBOutlet weak var viewBlock: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.viewRound.layer.cornerRadius = 10.0
        self.viewRound.layer.borderWidth = 1
        self.viewRound.layer.borderColor = UIColor.black.cgColor
        
        self.campoTexto.autocorrectionType = .no
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
