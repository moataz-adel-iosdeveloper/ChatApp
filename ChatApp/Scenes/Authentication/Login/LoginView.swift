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
    @IBOutlet weak var buttonSingin: LoadingLabel!
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
        self.buttonSingin.loadingColor = UIColor.white
        self.buttonSingin.View = self
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
        self.buttonSingin.showLoading()
        presenter?.login(phoneNumber: textPhoneNumber.text!, password: textPassword.text!)
    }
    
    @IBAction func buttonForgetPasswordAction(_ sender: UIButton) {
    }
    
    @IBAction func buttonSignUpAction(_ sender: UIButton) {
        let vc = RegisterView()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension LoginView : LoginViewProtocol {
    func loginSuccess() {
        self.buttonSingin.hideLoading()
        let vc = FrindesView()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func errorInAction(errorMessage: String) {
        self.buttonSingin.hideLoading()
        self.showToast(message: errorMessage, seconds: 4)
    }

}
