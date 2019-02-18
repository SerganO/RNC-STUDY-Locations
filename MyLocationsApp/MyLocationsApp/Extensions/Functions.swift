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

let applicationDocumentsDirectory: URL = {
    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    return paths[0]
}()

let CoreDataSaveFailedNotification = Notification.Name(rawValue: "CoreDatasaveFailedNotification")

func fatalCoreDataError(_ error: Error)
{
    print("*** fatal error: /\(error)")
    NotificationCenter.default.post(
        name: CoreDataSaveFailedNotification, object: nil
    )
}
