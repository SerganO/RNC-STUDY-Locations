//
//  LocationsViewController.swift
//  MyLocationsApp
//
//  Created by Trainee on 2/15/19.
//  Copyright © 2019 Trainee. All rights reserved.
//

import UIKit
import CoreData
import CoreLocation

class LocationsViewController: UITableViewController {
    var managedObjectContext: NSManagedObjectContext!
    var locations = [Location]()
    
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        let fetchRequest = NSFetchRequest<Location>()
        
        let entity = Location.entity()
        fetchRequest.entity = entity
        
        let sortDescriptor = NSSortDescriptor(key: "date", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        do{
            locations = try
                managedObjectContext.fetch(fetchRequest)}
        catch{
            fatalCoreDataError(error)
        }
    }
    
    
    
    // MARK: - Table View Delegates
    override func tableView(_ tableView: UITableView,
                            numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) ->
        UITableViewCell {
            let cell = tableView.dequeueReusableCell(
                withIdentifier: "LocationCell",
                for: indexPath)
            
            let descriptionLabel = cell.viewWithTag(100) as! UILabel
            descriptionLabel.text = "If you can see this"
            
            let addressLabel = cell.viewWithTag(101) as! UILabel
            addressLabel.text = "Then it works!"
            
            return cell
    }
}