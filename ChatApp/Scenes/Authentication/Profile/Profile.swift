//
//  DriverProfile.swift
//  Golden Way
//
//  Created by MacPro on 12/15/20.
//  Copyright © 2020 Locus-Project. All rights reserved.
//

import UIKit
import Kingfisher

class Profile: UIViewController {

    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var Price: UILabel!
    @IBOutlet weak var rate: UILabel!
    @IBOutlet weak var textUserName: UITextField!
    @IBOutlet weak var textPhoneNumber: UITextField!
    @IBOutlet weak var TextEmail: UITextField!
    @IBOutlet weak var imgArabicLangImage: UIImageView!
    @IBOutlet weak var imgEnglishLangImage: UIImageView!
    
    // selected image = "unchecked"
    // unselected image = "Ellipsegreen"
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.navigationController?.isNavigationBarHidden = true
//        let UserLoging = PublicRealm.objects(User.self)
//        if UserLoging.count != 0 {
//            textUserName.text = UserLoging[0].username
//            TextEmail.text = UserLoging[0].email
//            textPhoneNumber.text = UserLoging[0].mobile
//            Price.text = "\(UserLoging[0].balance)" + "  SAR"
//            rate.text = UserLoging[0].rate
//        }
    }
    
    @IBAction func buMenu_Clicked(_ sender: UIButton) {
//        if let vc = self.revealViewController() {
//            vc.revealToggle(animated: true)
//            //vc.rightRevealToggle(animated: true)
//        }
    }
    
    @IBAction func buttonChangeLang_Clicked(_ sender: UIButton) {
        // 0 == ar
        // 1 == en
    }
    @IBAction func buttonSaveEdting(_ sender: UIButton) {
        
    }

}
