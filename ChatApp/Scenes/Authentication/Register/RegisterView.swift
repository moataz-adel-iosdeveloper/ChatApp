//
//  RegisterView.swift
//  ChatApp
//
//  Created by ModyMayaAser on 25/02/2022.
//

import UIKit

class RegisterView: UIViewController {

    @IBOutlet weak var imgUserProfile: UIImageView!
    @IBOutlet weak var textPassword: UITextField!
    @IBOutlet weak var textUserName: UITextField!
    @IBOutlet weak var textPhoneNumber: UITextField!
    var GetImage = Bundle.main.loadNibNamed("GetImageView", owner: self, options: nil)?.first as! GetImageController
    var imgProfile : UIImage!
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    @IBAction func buttonSingupAction(_ sender: UIButton) {
        
    }
    
    @IBAction func imgUserProfileAction(_ sender: UIButton) {
        GetImage.backgroundColor = UIColor.clear.withAlphaComponent(0.7)
        let Screenwidth = self.view.frame.size.width
        let ScreenHeight = self.view.frame.size.height
        GetImage.frame = CGRect.init(x: 0, y: 0 , width:  Screenwidth , height: ScreenHeight )
        GetImage.selectedImage = self
        GetImage.wrapperView = self
        GetImage.SourceName = "Profile"
        self.view.addSubview(GetImage)
    }
    
    @IBAction func buttonSigninAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}

extension RegisterView : selectedImageDelegate {
    func imageselected(image64: String, img: UIImage, imageSourceName: String) {
        self.imgProfile = img
        imgUserProfile.image = img
    }
    
    
}
