//
//  LocationDetailsViewController.swift
//  MyLocationsApp
//
//  Created by Trainee on 2/14/19.
//  Copyright © 2019 Trainee. All rights reserved.
//
private let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .medium
    formatter.timeStyle = .short
    return formatter
    }()

import UIKit
import CoreLocation
import CoreData



class LocationDetailsViewController: UITableViewController
{
    
    var managedObjectContext: NSManagedObjectContext!

    
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var latitudeLabel: UILabel!
    @IBOutlet weak var longitudeLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    var coordinate = CLLocationCoordinate2D(latitude: 0,
                                               longitude: 0)
    var placemark: CLPlacemark?
    var categoryName = "No Category"
    var date = Date()
    var descriptionText = ""
    
    var locationToEdit: Location?
    {
        didSet
        {
            if let location = locationToEdit
            {
                descriptionText = location.locationDescription
                categoryName = location.category
                date = location.date
                coordinate = CLLocationCoordinate2DMake(location.latitude,location.longitude)
                placemark = location.placemark
            }
        }
    }
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        if let location = locationToEdit
        {
            title = "Edit Location"
        }
        
        descriptionTextView.text = descriptionText
        categoryLabel.text = categoryName
        
        latitudeLabel.text = String(format: "%.8f",
                                    coordinate.latitude)
        longitudeLabel.text = String(format: "%.8f",
                                     coordinate.longitude)
        
        if let placemark = placemark
        {
            addressLabel.text = string(from: placemark)
        }
        else
        {
            addressLabel.text = "No Address Found"
        }
        
        dateLabel.text = format(date: date)
        
        // Hide keyboard
        let gestureRecognizer = UITapGestureRecognizer(target: self,
                                                       action: #selector(hideKeyboard))
        
        
        gestureRecognizer.cancelsTouchesInView = false
        tableView.addGestureRecognizer(gestureRecognizer)
    }
    
    // MARK:- Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "PickCategory"
        {
            let controller = segue.destination as!
            CategoryPickerViewController
            controller.selectedCategoryName = categoryName
        }
    }
    
    //Helper Methods
    func string(from placemark: CLPlacemark) -> String
    {
        var text = ""
        
        if let s = placemark.subThoroughfare
        {
            text += s + " "
        }
        if let s = placemark.thoroughfare
        {
            text += s + ", "
        }
        if let s = placemark.locality
        {
            text += s + ", "
        }
        if let s = placemark.administrativeArea
        {
            text += s + " "
        }
        if let s = placemark.postalCode
        {
            text += s + ", "
        }
        if let s = placemark.country
        {
            text += s
        }
        return text
    }
    
    func format(date: Date) -> String
    {
        return dateFormatter.string(from: date)
    }
    
    //Actions
    @IBAction func done()
    {
        let hudView = HudView.hud(inView: view, animated:true)
        let location: Location
        if let temp = locationToEdit
        {
            hudView.text = "Updated"
            location = temp
        }
        else
        {
            hudView.text = "Tagged"
            location = Location(context: managedObjectContext)
        }
        location.locationDescription = descriptionTextView.text
        location.category = categoryName
        location.latitude = coordinate.latitude
        location.longitude = coordinate.longitude
        location.date = date
        location.placemark = placemark
        do
        {
            
            try managedObjectContext.save()
            afterDelay(0.6)
            {
                hudView.hide()
                self.navigationController?.popViewController(animated: true)
            }
        }
        catch
        {
            fatalCoreDataError(error)
        }
        
        
    }
    
    @IBAction func cancel()
    {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func categoryPickerDidPickCategory(
        _ segue: UIStoryboardSegue)
    {
        let controller = segue.source as! CategoryPickerViewController
        categoryName = controller.selectedCategoryName
        categoryLabel.text = categoryName
    }
    
    // MARK:- Table View Delegates
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath?
    {
        if indexPath.section == 0 || indexPath.section == 1
        {
            return indexPath
        }
        else
        {
            return nil
        }
    }
    
    override func tableView(_ tableView: UITableView,  didSelectRowAt indexPath: IndexPath)
    {
        if indexPath.section == 0 && indexPath.row == 0
        {
            descriptionTextView.becomeFirstResponder()
        }
    }
  
    @objc func hideKeyboard(_ gestureRecognizer: UIGestureRecognizer)
    {
        let point = gestureRecognizer.location(in: tableView)
        let indexPath = tableView.indexPathForRow(at: point)
        
        if indexPath != nil && indexPath!.section == 0 && indexPath!.row == 0
        {
            return
        }
        descriptionTextView.resignFirstResponder()
    }
    
}
