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
    @IBOutlet weak var textUserName: UITextField!
    @IBOutlet weak var textPhoneNumber: UITextField!
    @IBOutlet weak var imgArabicLangImage: UIImageView!
    @IBOutlet weak var lblSaveEdting: LoadingLabel!
    @IBOutlet weak var imgEnglishLangImage: UIImageView!
    // selected image = "unchecked"
    // unselected image = "Ellipsegreen"
    private var presenter: ProfilePresenterProtocol?
    private var imgProfileUpdated : UIImage!
    private var GetImage = Bundle.main.loadNibNamed("GetImageView", owner: self, options: nil)?.first as! GetImageController
    
    init() {
        super.init(nibName: "\(Profile.self)", bundle: nil)
        presenter = ProfilePresenter(view: self)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter?.getProfileData()
    }
    
    @IBAction func buttonChangeLang_Clicked(_ sender: UIButton) {
        // 0 == ar
        // 1 == en
    }
    @IBAction func buttonSaveEdting(_ sender: UIButton) {
        self.lblSaveEdting.showLoading()
        self.presenter?.updateProfile(phoneNumber: textPhoneNumber.text, img: imgProfileUpdated, userName: textUserName.text)
    }

    @IBAction func imgProfileAction(_ sender: UIButton) {
        GetImage.backgroundColor = UIColor.clear.withAlphaComponent(0.7)
        let Screenwidth = self.view.frame.size.width
        let ScreenHeight = self.view.frame.size.height
        GetImage.frame = CGRect.init(x: 0, y: 0 , width:  Screenwidth , height: ScreenHeight )
        GetImage.selectedImage = self
        GetImage.wrapperView = self
        GetImage.SourceName = "Profile"
        self.view.addSubview(GetImage)
    }
}
extension Profile : selectedImageDelegate {
    func imageselected(image64: String, img: UIImage, imageSourceName: String) {
        self.imgProfileUpdated = img
        imgProfile.image = img
    }
}
extension Profile : ProfileProtocol {
    func errorInAction(errorMessage: String) {
        self.lblSaveEdting.hideLoading()
        self.showToast(message: errorMessage, seconds: 4)
    }
    
    func updateDate(user: UserModel) {
        textUserName.text = user.user?.fullname
        textPhoneNumber.text = user.user?.phone
        if let url = URL(string: user.user?.img ?? "") {
            imgProfile.kf.setImage(with: url)
        }
    }
}
