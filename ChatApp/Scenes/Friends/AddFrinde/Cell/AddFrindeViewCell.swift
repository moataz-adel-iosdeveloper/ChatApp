//
//  AddFrindeViewCell.swift
//  ChatApp
//
//  Created by ModyMayaAser on 25/02/2022.
//

import UIKit

class AddFrindeViewCell: UITableViewCell {

    @IBOutlet weak var imgSelectedImage: UIImageView!
    @IBOutlet weak var lblFrindePhone: UILabel!
    @IBOutlet weak var lblFrindeName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setCell(name : String , phone : String , isSelected : Bool) {
        lblFrindePhone.text = phone
        lblFrindeName.text = name
        if isSelected {
            imgSelectedImage.image = UIImage(named: "unchecked")
        }else {
            imgSelectedImage.image = UIImage(named: "Ellipsegreen")
        }
    }
    
}
