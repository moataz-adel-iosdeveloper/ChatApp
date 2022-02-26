//
//  LoginView.swift
//  ChatApp
//
//  Created by ModyMayaAser on 25/02/2022.
//

import UIKit

class LoginView: UIViewController {
    
    @IBOutlet weak var textPassword: UITextField!
    @IBOutlet weak var textPhoneNumber: UITextField!
    
    private var presenter: LoginPresenterProtocol?
    
    init() {
        super.init(nibName: "\(LoginView.self)", bundle: nil)
        presenter = LoginViewPresenter(view: self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    @IBAction func buttonSinginAction(_ sender: UIButton) {
        presenter?.login(phoneNumber: textPhoneNumber.text!, password: textPassword.text!)
    }
    
    @IBAction func buttonForgetPasswordAction(_ sender: UIButton) {
    }
    @IBAction func buttonSignUpAction(_ sender: UIButton) {
        let vc = RegisterView(nibName: "RegisterView", bundle: nil)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension LoginView : LoginViewProtocol {
    func loginSuccess() {
        <#code#>
    }
    
    func errorInAction(errorMessage: String) {
        self.showToast(message: errorMessage, seconds: 0.4)
    }

}
