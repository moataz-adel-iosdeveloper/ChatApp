//
//  ImageExtension.swift
//  unicita
//
//  Created by mohamed-maya on 4/11/18.
//  Copyright © 2018 mohamed-maya. All rights reserved.
//

import Foundation
import UIKit


extension UIImage {
    
    public func base64(_ format: ImageFormat) -> String {
        var imageData: Data
        switch format {
        case .png: imageData = self.pngData()!
        case .jpeg(let compression): imageData = self.jpegData(compressionQuality: compression)!  //UIImageJPEGRepresentation(self, compression)!
        }
        return imageData.base64EncodedString(options: .lineLength64Characters)
    }
    func resizeWith(percentage: CGFloat) -> UIImage? {
        let imageView = UIImageView(frame: CGRect(origin: .zero, size: CGSize(width: size.width * percentage, height: size.height * percentage)))
        imageView.contentMode = .scaleAspectFit
        imageView.image = self
        UIGraphicsBeginImageContextWithOptions(imageView.bounds.size, false, scale)
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        imageView.layer.render(in: context)
        guard let result = UIGraphicsGetImageFromCurrentImageContext() else { return nil }
        UIGraphicsEndImageContext()
        return result
    }
    func resizeWith(width: CGFloat) -> UIImage? {
        let imageView = UIImageView(frame: CGRect(origin: .zero, size: CGSize(width: width, height: CGFloat(ceil(width/size.width * size.height)))))
        imageView.contentMode = .scaleAspectFit
        imageView.image = self
        UIGraphicsBeginImageContextWithOptions(imageView.bounds.size, false, scale)
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        imageView.layer.render(in: context)
        guard let result = UIGraphicsGetImageFromCurrentImageContext() else { return nil }
        UIGraphicsEndImageContext()
        return result
    }
}

//extension UIImage{
//    func toBase64() -> String{
//        let imageData = UIImagePNGRepresentation(self)!
//        return imageData.base64EncodedString(options: Data.Base64EncodingOptions.lineLength64Characters)
//    }
//}

public enum ImageFormat {
    case png
    case jpeg(CGFloat)
}
