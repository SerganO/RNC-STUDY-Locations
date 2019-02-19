//
//  UIImage+Resize.swift
//  MyLocationsApp
//
//  Created by Trainee on 2/19/19.
//  Copyright © 2019 Trainee. All rights reserved.
//

import UIKit

extension UIImage
{
    func resized(withBounds bounds: CGSize) -> UIImage
    {
        let horizontalRatio = bounds.width / size.width
        let verticalRatio = bounds.height / size.height
        let ratio = max(horizontalRatio, verticalRatio)
        let newSize = CGSize(width: size.width * ratio,height: size.height * ratio)
        
        UIGraphicsBeginImageContextWithOptions(newSize, true, 0)
        draw(in: CGRect(origin: CGPoint.zero, size: newSize))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
}
