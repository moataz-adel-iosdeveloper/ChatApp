//
//  UIButton.swift
//  mrt7al
//
//  Created by moamed maya on 15/08/2021.
//  Copyright © 2021 Ashraf-Project. All rights reserved.
//

import Foundation
import NVActivityIndicatorView
import UIKit

class LoadingButton: UIButton {
    
    var originalButtonText: String?
    var originalButtonImage: UIImage?
    var activityIndicator: NVActivityIndicatorView!
    var loadingColor : UIColor!
    var loadingType: NVActivityIndicatorType!
    var View : UIViewController!
    
    func showLoading() {
        originalButtonText = self.titleLabel?.text
        originalButtonImage = self.imageView?.image
        self.setTitle("", for: UIControl.State.normal)
        self.setImage(nil, for: .normal)
        if (activityIndicator == nil) {
            activityIndicator = createActivityIndicator()
        }
        showSpinning()
    }
    
    func LoadingColor(color : UIColor) {
        self.loadingColor = color
    }
    
    func hideLoading() {
        if activityIndicator != nil {
            self.setTitle(originalButtonText, for: UIControl.State.normal)
            self.setImage(originalButtonImage, for: .normal)
            if View != nil {
                View.view.isUserInteractionEnabled = true
            }
            activityIndicator.stopAnimating()
        }
    }
    
    private func createActivityIndicator() -> NVActivityIndicatorView {
        let activityIndicator = NVActivityIndicatorView(frame: self.frame)
        activityIndicator.type = loadingType == nil ? .ballRotateChase : loadingType
        activityIndicator.isHidden = true
        activityIndicator.color = loadingColor == nil ? UIColor.white : loadingColor
        return activityIndicator
    }
    
    private func showSpinning() {
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        if View != nil {
            View.view.isUserInteractionEnabled = false
        }
        self.addSubview(activityIndicator)
        centerActivityIndicatorInButton()
        activityIndicator.startAnimating()
    }
    
    private func centerActivityIndicatorInButton() {
        let xCenterConstraint = NSLayoutConstraint(item: self, attribute: .centerX, relatedBy: .equal, toItem: activityIndicator, attribute: .centerX, multiplier: 1, constant: 0)
        self.addConstraint(xCenterConstraint)
        
        let yCenterConstraint = NSLayoutConstraint(item: self, attribute: .centerY, relatedBy: .equal, toItem: activityIndicator, attribute: .centerY, multiplier: 1, constant: 0)
        self.addConstraint(yCenterConstraint)
    }
    
}

class LoadingLabel: UILabel {
    
    var originalButtonText: String?
    var activityIndicator: NVActivityIndicatorView!
    var loadingColor : UIColor!
    var loadingType: NVActivityIndicatorType!
    var View : UIViewController!
    
    func showLoading() {
        originalButtonText = self.text
        self.text = ""
        
        if (activityIndicator == nil) {
            activityIndicator = createActivityIndicator()
        }
        
        showSpinning()
    }
    
    func LoadingColor(color : UIColor) {
        self.loadingColor = color
    }
    
    func hideLoading() {
        self.text = originalButtonText
        if View != nil {
            View.view.isUserInteractionEnabled = true
        }
        activityIndicator.stopAnimating()
    }
    
    private func createActivityIndicator() -> NVActivityIndicatorView {
        let activityIndicator = NVActivityIndicatorView(frame: self.frame)
        activityIndicator.type = loadingType == nil ? .ballRotateChase : loadingType
        activityIndicator.isHidden = true
        activityIndicator.color = loadingColor == nil ? UIColor.white : loadingColor
        return activityIndicator
    }
    
    private func showSpinning() {
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        if View != nil {
            View.view.isUserInteractionEnabled = false
        }
        self.addSubview(activityIndicator)
        centerActivityIndicatorInButton()
        activityIndicator.startAnimating()
    }
    
    private func centerActivityIndicatorInButton() {
        let xCenterConstraint = NSLayoutConstraint(item: self, attribute: .centerX, relatedBy: .equal, toItem: activityIndicator, attribute: .centerX, multiplier: 1, constant: 0)
        self.addConstraint(xCenterConstraint)
        
        let yCenterConstraint = NSLayoutConstraint(item: self, attribute: .centerY, relatedBy: .equal, toItem: activityIndicator, attribute: .centerY, multiplier: 1, constant: 0)
        self.addConstraint(yCenterConstraint)
    }
    
}
