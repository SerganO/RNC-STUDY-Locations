//
//  MyTabBarController.swift
//  MyLocationsApp
//
//  Created by Trainee on 2/20/19.
//  Copyright © 2019 Trainee. All rights reserved.
//

import UIKit

class MyTabBarController: UITabBarController
{
    override var preferredStatusBarStyle: UIStatusBarStyle
    {
        return .lightContent
    }
    
    override var childForStatusBarStyle: UIViewController?
    {
        return nil;
    }
    
    
}
