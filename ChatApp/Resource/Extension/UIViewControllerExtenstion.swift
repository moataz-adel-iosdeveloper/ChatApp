//
//  UIViewControllerExtenstion.swift
//  ChatApp
//
//  Created by ModyMayaAser on 26/02/2022.
//

import Foundation
import UIKit

extension UIViewController{

    func showToast(message : String, seconds: Double){
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.view.backgroundColor = .darkGray
        alert.view.alpha = 0.5
        alert.view.layer.cornerRadius = 15
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: { (action) -> Void in
            alert.dismiss(animated: true)
        })
        alert.addAction(okAction)
        self.present(alert, animated: true)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + seconds) {
            alert.dismiss(animated: true)
        }
    }
}
