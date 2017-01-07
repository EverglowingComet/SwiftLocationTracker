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
	
	var locationManager = LocationManager()
	var currentLocation: CLLocation?
	
	var showLocation: ((String) -> ())?
	
	
	// MARK: - lifecycle methods
	
	override init() {
		super.init()
		
	}
	
	func startLocationTracking() {
		let request = locationManager.getLocation(withAccuracy: .room, frequency: .continuous, timeout: nil, onSuccess: self.retreiveLocationHandler) { (lastValidLocation, error) in
			print("location tracking failed with error: \(error)")
		}
		request.cancel()
		request.pause()
		request.start()
	}
	
	
	// MARK: - location handler
	
	func retreiveLocationHandler(location: CLLocation) {
		currentLocation = location
		print("-----------------------\nretreive location: \(Float((currentLocation?.coordinate.latitude)!)), \(Float((currentLocation?.coordinate.longitude)!))")
		
		let address = String(format: "%f, %f\n", (currentLocation?.coordinate.latitude)!, (currentLocation?.coordinate.longitude)!)
		print("-------------------\n\(address)\n")
		showLocation?(address)
		
		let request = locationManager.reverse(coordinates: currentLocation!.coordinate, onSuccess: self.reverseLocationHandler) { error in
			print("reverse location failed with error: \(error)")
		}
		request.cancel()
		request.pause()
		request.start()
	}
	
	
	func reverseLocationHandler(placeMark: CLPlacemark) {
		print("revserd location \(placeMark)\n")
		
		let address = String(format: "%f, %f\n", (currentLocation?.coordinate.latitude)!, (currentLocation?.coordinate.longitude)!)
		print("-------------------\n\(address)\n")
		showLocation?(address)
	}
}
