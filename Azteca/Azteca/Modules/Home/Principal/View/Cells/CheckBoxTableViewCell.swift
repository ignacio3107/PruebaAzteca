//
//  CheckBoxTableViewCell.swift
//  Azteca
//
//  Created by Ignacio Hernández on 24/09/26.
//

import UIKit

class CheckBoxTableViewCell: UITableViewCell {

    @IBOutlet weak var viewRound: UIView!
    @IBOutlet weak var viewColor: UIView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var check: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.viewRound.layer.cornerRadius = 10.0
        self.viewRound.layer.borderWidth = 1
        self.viewRound.layer.borderColor = UIColor.black.cgColor
        self.viewColor.layer.cornerRadius = 8
    }
    
    func setCheckBoxOn(){
        self.check.tintColor = UIColor.systemMint
        self.check.image = UIImage(systemName: "checkmark.square.fill")
        self.isSelected = true
        
    }
    
    func setCheckBoxOff(){
        self.check.tintColor = UIColor.systemGray
        self.check.image = UIImage(systemName: "square")
        self.isSelected = false
    }

    func setColor(color: UIColor, name: String){
        self.title.text = name
        self.viewColor.isHidden = false
        self.viewColor.backgroundColor = color
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
}
