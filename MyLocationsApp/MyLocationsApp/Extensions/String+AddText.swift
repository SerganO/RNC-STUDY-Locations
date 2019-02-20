//
//  String+AddText.swift
//  MyLocationsApp
//
//  Created by Trainee on 2/20/19.
//  Copyright © 2019 Trainee. All rights reserved.
//

import Foundation

extension String
{
    mutating func add(text: String?, separatedBy separator: String = "")
    {
        if let text = text
        {
            if !isEmpty
            {
                self += separator
            }
            self+=text
        }
    }
}
