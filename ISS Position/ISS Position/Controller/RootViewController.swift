//
//  RootViewController.swift
//  ISS Position
//
//  Created by Marcin Kuswik on 12.09.2018.
//  Copyright © 2018 Marcin Kuświk. All rights reserved.
//

import UIKit
import Mapbox

class RootViewController: UIViewController {
    
    private let mapViewZoomLevel: Double = 3
    
    private var mapView: MGLMapView?
    
    private var mapAnnotation: MGLPointAnnotation?
    
    private var taskManager: ScheduledTaskManager?
    
    private var astronauts: [Astronaut]?
    
    private var issPosition: ISSNow? {
        didSet {
            onISSPositionDidSet()
        }
    }
    
    private var coordinates: CLLocationCoordinate2D? {
        get {
            if let longitudeString = issPosition?.issPosition.longitude, let latitudeString = issPosition?.issPosition.latitude {
                let longitude = Double(longitudeString)
                let latitude = Double(latitudeString)
                return CLLocationCoordinate2D(latitude: latitude!, longitude: longitude!)
            }
            return nil
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        
        setupData()
    }
    
    private func setupView() {
        mapView = MGLMapView(frame: view.bounds)
        mapView?.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        mapView?.styleURL = MGLStyle.satelliteStyleURL
        mapView?.delegate = self
        view.addSubview(mapView!)
    }
    
    private func setupData() {
        getISSPosition()
        getAstronauts()
        
        taskManager = ScheduledTaskManager(interval: 5.0, repeats: true, delegate: self)
        taskManager?.start()
        
        NotificationCenter.default.addObserver(self, selector: #selector(onApplicationWillResignActive), name: Notification.Name.UIApplicationWillResignActive, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(onApplicationWillEnterForeground), name: Notification.Name.UIApplicationWillEnterForeground, object: nil)
    }
    
    @objc func onApplicationWillResignActive() {
        taskManager?.stop()
    }
    
    @objc func onApplicationWillEnterForeground() {
        taskManager?.start()
    }
    
    private func getISSPosition() {
        ISSInfoService.getISSPosition { (result, error) in
            if let result = result {
                self.issPosition = result
            }
        }
    }

    private func onISSPositionDidSet() {
        if let mapView = mapView, let annotations = mapView.annotations {
            mapView.removeAnnotations(annotations)
        }
        if let coordinates = self.coordinates {
            updateMapViewCenter(withCoordinates: coordinates)
        }
        getAstronauts()
    }
    
    private func getAstronauts() {
        ISSInfoService.getISSAstronauts { (result, error) in
            var subtitle: String?
            if let result = result {
                self.astronauts = result.people
                subtitle = self.prepareAstronautsString(withAstronatus: self.astronauts)
            }
            if let error = error {
                subtitle = "There was a problem while checking astronauts on ISS! Error: \(error)"
            }
            if let coordinates = self.coordinates {
                let mapAnnotation = self.prepareMapViewAnnotation(withTitle: "Astronauts on ISS", subtitle: subtitle!, andCoorinates: coordinates)
                self.mapView?.addAnnotation(mapAnnotation)
            }
        }
    }
    
    private func prepareAstronautsString(withAstronatus astronauts: [Astronaut]?) -> String? {
        if let astros = astronauts {
            return astros.map({ $0.name }).joined(separator: "\n")
        }
        return nil
    }
    
    private func prepareMapViewAnnotation(withTitle title: String, subtitle: String, andCoorinates coordinates: CLLocationCoordinate2D) -> MGLPointAnnotation {
        let annotation = MGLPointAnnotation()
        annotation.coordinate = coordinates
        annotation.title = title
        annotation.subtitle = subtitle
        return annotation
    }
    
    private func updateMapViewCenter(withCoordinates coordinates: CLLocationCoordinate2D) {
        self.mapView?.setCenter(coordinates, zoomLevel: mapViewZoomLevel, animated: true)
    }
    
}

extension RootViewController: MGLMapViewDelegate, ScheduledTaskDelegate {
    
    // MARK: MGLMapViewDelegate methods
    
    func mapView(_ mapView: MGLMapView, annotationCanShowCallout annotation: MGLAnnotation) -> Bool {
        return true
    }
    
    func mapView(_ mapView: MGLMapView, calloutViewFor annotation: MGLAnnotation) -> MGLCalloutView? {
        return CustomCallOutView(annotation: annotation)
    }
    
    // MARK: ScheduledTaskDelegate methods
    
    func performTask() {
        getISSPosition()
    }
        
}
