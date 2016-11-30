//
//  SurveysVC.swift
//  Rewards
//
//  Created by Fabio Barboza on 10/12/16.
//  Copyright © 2016 PUCRS. All rights reserved.
//

import UIKit
import Parse
import CoreLocation

class SurveysVC: UIViewController, CLLocationManagerDelegate, UITableViewDataSource, UITableViewDelegate {

    let navTitle = "Pesquisas"
    let surveyCellID = "SurveyCell"
    let surveySegue = "SurveySegue"
    let profileSegue = "ProfileSegue"
    let warningTitle = "Reload the list"
    let surveyQueryError = "Occured an error trying to get the surveys"
    
    var surveyList = NSMutableArray()
    let locationManager = CLLocationManager()
    var userLocation: CLLocationCoordinate2D?
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView! {
        didSet{
            tableView.delegate = self
            tableView.dataSource = self
            tableView.tableFooterView = UIView(frame: CGRect.zero)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = navTitle
        requestLocation()
        loadObjects()
    }
    
    //MARK: - Data
    
    func loadObjects() {
        loading(true)
        RWSurveysWS.surveys(success: { (list) in
            self.surveyList = NSMutableArray(array: list)
            for survey in self.surveyList {
                guard let s = survey as? RWSurvey else {
                    break
                }
                s.isNear = self.isNear(survey: s)
            }
            self.tableView.reloadData()
            self.loading(false)
        }) { (error) in
            let alertController = UIAlertController.basicMessage(self.warningTitle, message: self.surveyQueryError)
            self.present(alertController, animated: true, completion: nil)
            self.loading(false)
        }
        
    }
    
    func loading(_ enable: Bool) {
        if enable == true {
            activityIndicator.startAnimating()
        } else {
            activityIndicator.stopAnimating()
        }
    }
    
    //MARK: - Tableview
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return surveyList.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:RWSurveyCell = tableView.dequeueReusableCell(withIdentifier: surveyCellID)! as! RWSurveyCell
        let survey = surveyList[indexPath.row] as! RWSurvey
        if survey.isNear {
            cell.surveyImage?.alpha = 1.0
            cell.startButton.isHidden = false
        } else {
            cell.startButton.isHidden = true
            cell.surveyImage?.alpha = 0.5
        }
        cell.surveyTitle.text = survey.title
        if let name = survey.company?.companyName {
            cell.surveyLocation.text = "\(name)" + " " + "\(survey.locationInMeters)" + "km"
        } else {
            cell.surveyLocation.text = "\(survey.locationInMeters)" + "km"
        }
        cell.surveyReward.text = survey.reward
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView .deselectRow(at: indexPath, animated: true)
        guard let survey = self.surveyList[indexPath.row] as? RWSurvey else {
            return
        }
        if survey.isNear {
            performSegue(withIdentifier: surveySegue, sender: indexPath)
        }
    }
    
    //MARK: - Navigation
    
    @IBAction func showProfile(_ sender: AnyObject) {
        self.performSegue(withIdentifier: profileSegue, sender: sender);
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == surveySegue {
            let navController = segue.destination as! UINavigationController
            let surveyVC = navController.viewControllers.first as! DataLoaderVC
            let indexPath = sender as! IndexPath
            surveyVC.survey = surveyList[indexPath.row] as? RWSurvey
        }
    }
    
    //MARK: - Location
    
    func requestLocation() {
        locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let loc = manager.location?.coordinate else {
            return
        }
        if userLocation == nil {
            self.tableView.reloadData()
        }
        userLocation = loc
        print("locations = \(loc.latitude) \(loc.longitude)")
    }
    
    func isNear(survey: RWSurvey) -> Bool {
        guard let surveyLatitude = survey.company?.geoPoint?.latitude,
            let surveyLongitude = survey.company?.geoPoint?.longitude,
            let location = userLocation else {
                return false
        }
        let userLoc = CLLocation(latitude: location.latitude, longitude: location.longitude)
        let surveyLoc = CLLocation(latitude: surveyLatitude, longitude: surveyLongitude)
        let distance = userLoc.distance(from: surveyLoc)
        let kmValue = distance / 1000
        survey.locationInMeters = kmValue.roundTo(places: 1)
        if distance <= 2000 {
            return true
        }
        return false
    }
}
