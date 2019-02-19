//
//  MapViewController.swift
//  MyLocationsApp
//
//  Created by Trainee on 2/19/19.
//  Copyright © 2019 Trainee. All rights reserved.
//

import UIKit
import MapKit
import CoreData

class MapViewController: UIViewController
{
    @IBOutlet weak var mapView: MKMapView!
    
    var managedObjectContext: NSManagedObjectContext!
    
    //Actions
    @IBAction func showUser()
    {
        let region = MKCoordinateRegion(
            center: mapView.userLocation.coordinate,
            latitudinalMeters: 1000,longitudinalMeters: 1000)
        
        mapView.setRegion(mapView.regionThatFits(region),animated: true)
    }
    
    @IBAction func showLocations()
    {
        
    }

}

extension MapViewController: MKMapViewDelegate
{
    
}
