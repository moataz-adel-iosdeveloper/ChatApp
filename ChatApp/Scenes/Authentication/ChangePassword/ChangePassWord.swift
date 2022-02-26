//
//  ChangePassWord.swift
//  mrt7al
//
//  Created by MacPro on 7/8/20.
//  Copyright © 2020 Ashraf-Project. All rights reserved.
//

import UIKit
protocol ChangePassWordProtocol {
    func funcChangePassWord(ActiveCode: String , phoneNumber : String , Password : String)
}

class ChangePassWord: UIViewController {
    
    @IBOutlet weak var txtSecondNewPassword: UITextField!
    @IBOutlet weak var txtFirstNewPassWord: UITextField!
    var viewcontroller : Profile!
    var Delegate : ChangePassWordProtocol!
    var Phone : String!
    var ActiveCode : String!
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.lightGray.withAlphaComponent(0.8)
        view.isOpaque = false
    }

    @IBAction func button_ChangePasswordAction(_ sender: UIButton) {
//        if txtSecondNewPassword.text == "" || txtFirstNewPassWord.text == "" {
//            Helper.AlertWithOutAction(AlertTitle: "خطآ في المعلومات", message: "يجب اضافه البيانات المطلوبه", view: viewcontroller)
//            return
//        }
//        if txtFirstNewPassWord.text != txtSecondNewPassword.text {
//            Helper.AlertWithOutAction(AlertTitle: "خطآ في المعلومات", message: "كلمات المرور غير متطابقه", view: viewcontroller)
//            return
//        }
        Delegate.funcChangePassWord(ActiveCode: ActiveCode, phoneNumber: Phone, Password: txtFirstNewPassWord.text!)
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
          return .lightContent
    }
    
    @IBAction func button_ColseButon(_ sender: UIButton) {
//        viewcontroller.vcChangePassword.view.removeFromSuperview()
    }
    
}
