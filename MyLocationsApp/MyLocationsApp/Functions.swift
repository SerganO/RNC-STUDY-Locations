//
//  Functions.swift
//  MyLocationsApp
//
//  Created by Trainee on 2/15/19.
//  Copyright © 2019 Trainee. All rights reserved.
//

import Foundation

func afterDelay(_ seconds: Double, run: @escaping () -> Void)
{
    DispatchQueue.main.asyncAfter(deadline: .now() + seconds, execute: run)
}
