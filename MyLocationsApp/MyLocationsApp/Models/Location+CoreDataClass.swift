//
//  Location+CoreDataClass.swift
//  MyLocationsApp
//
//  Created by Trainee on 2/15/19.
//  Copyright © 2019 Trainee. All rights reserved.
//
//

import Foundation
import CoreData
import MapKit

@objc(Location)
public class Location: NSManagedObject, MKAnnotation
{

    public var coordinate: CLLocationCoordinate2D
    {
        return CLLocationCoordinate2DMake(latitude,longitude)
    }

    public var title: String?
    {
        if locationDescription.isEmpty
        {
            return "(No Description)"
        }
        else
        {
            return locationDescription
        }
    }
    
    public var subtitle: String?
    {
        return category
    }
    
}
