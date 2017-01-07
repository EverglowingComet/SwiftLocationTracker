//
//  TabViewModel.swift
//  LocationTracking
//
//  Created by Com on 07/01/2017.
//  Copyright © 2017 Com. All rights reserved.
//

import Foundation
import MapKit
import CoreLocation
import SwiftLocation


class TabViewModel: NSObject {
	
	var locationManager = CLLocationManager()
	var geocoder = CLGeocoder()
	var currentLocation: CLLocation?
	
	var allLocations = [CLLocation]()
	
	var totalDistance: CLLocationDistance = 0.0 {
		didSet {
			if totalDistance >= 50 {
				saveMove()
				refresh()
				showBanner?()
			}
		}
	}
	
	var allMoves = [[String: Any]]()
	
	var showLocation: ((String) -> ())?
	var showDistance: ((String) -> ())?
	var showBanner: (() -> ())?
	
	
	// MARK: - lifecycle methods
	
	override init() {
		super.init()
		
		locationManager.delegate = self
		locationManager.desiredAccuracy = kCLLocationAccuracyBest
		locationManager.requestAlwaysAuthorization()
		locationManager.startUpdatingLocation()
		
		if UserDefaults.standard.value(forKey: "allMoves") != nil {
			allMoves = UserDefaults.standard.value(forKey: "allMoves") as! [[String : Any]]
		}
	}
	
	func pauseTracking() {
		locationManager.stopUpdatingLocation()
		refresh()
	}
	
	func startTracking() {
		locationManager.startUpdatingLocation()
	}
	
	func saveMove() {
		let date = Date()
		let dict = ["distance": totalDistance as Any,
		            "date": date.description]
		allMoves.append(dict)
		
		UserDefaults.standard.setValue(allMoves, forKey: "allMoves")
	}
	
	func refresh() {
		totalDistance = 0.0
		allLocations.removeAll()
		currentLocation = nil
	}
	
	func getDistance() {
		if allLocations.count < 2 {
			return
		}
		let last = allLocations[allLocations.count - 2]
		let meter = last.distance(from: currentLocation!)
		totalDistance += meter
		
		let meterString = String(format: "%f m", totalDistance)
		print("total distance: \(meterString)")
		self.showDistance?(meterString)
	}
	
	func reverseAddress() {
		let curLoc = self.currentLocation
		
		geocoder.reverseGeocodeLocation(currentLocation!, completionHandler: {(placemarks, error) in
			if (error != nil) {
				print("reverse error failed with \(error)")
				return
			}
			
			let placemark = placemarks?[0]
			
			let loc = String(format: "%f, %f\n", (curLoc?.coordinate.latitude)!, (curLoc?.coordinate.longitude)!)
			
			let address = self.getAddress(from: placemark!)
			
			self.showLocation?(loc + "\n" + address)
		})
	}
	
	func getAddress(from placemark: CLPlacemark) -> String {
		var addressString : String = ""
		if placemark.isoCountryCode == "TW" /*Address Format in Chinese*/ {
			if placemark.country != nil {
				addressString = placemark.country!
			}
			if placemark.subAdministrativeArea != nil {
				addressString = addressString + placemark.subAdministrativeArea! + ", "
			}
			if placemark.postalCode != nil {
				addressString = addressString + placemark.postalCode! + " "
			}
			if placemark.locality != nil {
				addressString = addressString + placemark.locality!
			}
			if placemark.thoroughfare != nil {
				addressString = addressString + placemark.thoroughfare!
			}
			if placemark.subThoroughfare != nil {
				addressString = addressString + placemark.subThoroughfare!
			}
		} else {
			if placemark.subThoroughfare != nil {
				addressString = placemark.subThoroughfare! + " "
			}
			if placemark.thoroughfare != nil {
				addressString = addressString + placemark.thoroughfare! + ", "
			}
			if placemark.postalCode != nil {
				addressString = addressString + placemark.postalCode! + " "
			}
			if placemark.locality != nil {
				addressString = addressString + placemark.locality! + ", "
			}
			if placemark.administrativeArea != nil {
				addressString = addressString + placemark.administrativeArea! + " "
			}
			if placemark.country != nil {
				addressString = addressString + placemark.country!
			}
		}
		
		return addressString
	}
}


extension TabViewModel: CLLocationManagerDelegate {
	public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
		currentLocation = locations.last
		
		allLocations.append(currentLocation!)
		
		reverseAddress()
		getDistance()
	}
}
