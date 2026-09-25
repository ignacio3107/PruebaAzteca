//
//  CameraTableViewCell.swift
//  Azteca
//
//  Created by Ignacio Hernández on 24/09/26.
//

import UIKit

class CameraTableViewCell: UITableViewCell {

    @IBOutlet weak var viewRound: UIView!
    @IBOutlet weak var imgCamera: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.viewRound.layer.cornerRadius = 10.0
        self.viewRound.layer.borderWidth = 1
        self.viewRound.layer.borderColor = UIColor.black.cgColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}
