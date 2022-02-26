//
//  FrindesViewCell.swift
//  ChatApp
//
//  Created by ModyMayaAser on 26/02/2022.
//

import UIKit

class FrindesViewCell: UITableViewCell {

    @IBOutlet weak var lblFrindePhone: UILabel!
    @IBOutlet weak var lblFrindeName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setCell(name : String , phone : String ) {
        lblFrindePhone.text = phone
        lblFrindeName.text = name
    }
    
}
