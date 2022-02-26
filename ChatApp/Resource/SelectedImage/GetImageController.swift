//
//  GetImageController.swift
//  unicita
//
//  Created by mohamed-maya on 4/11/18.
//  Copyright © 2018 mohamed-maya. All rights reserved.
//

import UIKit

protocol selectedImageDelegate {
    func imageselected(image64:String, img : UIImage , imageSourceName : String)
}

class GetImageController: UIView , UIImagePickerControllerDelegate , UINavigationControllerDelegate  {
    
    var imagePicker = UIImagePickerController()
    var wrapperView :  UIViewController!
    var img64 : String!
    var selectedImage : selectedImageDelegate!
    var IsBig : Bool = false
    var SourceName : String!
    @IBAction func imagePickerAciton(_ sender: UIButton) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.savedPhotosAlbum){
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerController.SourceType.savedPhotosAlbum;
            imagePicker.allowsEditing = true
            wrapperView.present(imagePicker, animated: true, completion: nil)
        }
    }
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool)
    {
        imagePicker.navigationBar.isTranslucent = false
        imagePicker.navigationBar.tintColor = UIColor.white
        imagePicker.navigationBar.barTintColor = UIColor(red: 254/255.0, green: 175/255.0, blue: 38/255.0, alpha: 1.0)
        imagePicker.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor : UIColor.white
        ]
    }
    @IBAction func VideoPickerAction(_ sender: UIButton) {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            imagePicker.allowsEditing = true
            imagePicker.sourceType = UIImagePickerController.SourceType.camera
            imagePicker.cameraCaptureMode = .photo
            imagePicker.modalPresentationStyle = .fullScreen
            imagePicker.delegate = self
            wrapperView.present(imagePicker,animated: true,completion: nil)
        }
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        imagePicker.dismiss(animated: true, completion: { () -> Void in})
        self.removeFromSuperview()
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imagePicker.dismiss(animated: true, completion: { () -> Void in})
        var image = UIImage()
        if let editedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            image = editedImage
        } else if let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            image = originalImage
        }
        img64 = image.resizeWith(percentage: 0.5)?.base64(ImageFormat.png)
        selectedImage.imageselected(image64: img64, img: image, imageSourceName: SourceName)
        
        self.removeFromSuperview()
    }
    
    @IBAction func CancelAction(_ sender: UIButton) {
        self.removeFromSuperview()
    }
    

    

}

