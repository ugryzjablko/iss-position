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
    
    var presenter: RootViewPresenter!
    
    
    private let persistane: Persistence = PersistenceUserDefaults()
    
    private let mapViewZoomLevel: Double = 3
    
    private var statusLabel: UILabel?
    
    private var mapView: MGLMapView?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        
        setupObservers()
        
        presenter.updateListOfAtronatus()
        
        presenter.updateISSPosition()
        
        presenter.startUpdatingISSPosition()
    }
    
    private func setupView() {
        
        setupMapView()
        
        setupStatusLabel()
        
    }
    
    private func setupMapView() {
        mapView = MGLMapView(frame: view.bounds)
        mapView?.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        mapView?.styleURL = MGLStyle.satelliteStyleURL
        mapView?.delegate = self
        view.addSubview(mapView!)
    }
    
    private func setupStatusLabel() {
        statusLabel = UILabel()
        statusLabel?.backgroundColor = UIColor.white
        statusLabel?.alpha = 0.75
        statusLabel?.textColor = UIColor.black
        statusLabel?.translatesAutoresizingMaskIntoConstraints = false
        statusLabel?.numberOfLines = 0
        statusLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
        
        view.addSubview(statusLabel!)
        view.bringSubview(toFront: statusLabel!)
        
        statusLabel?.heightAnchor.constraint(equalToConstant: 30)
        statusLabel?.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        statusLabel?.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        
        if #available(iOS 11, *) {
            let guide = view.safeAreaLayoutGuide
            statusLabel?.topAnchor.constraintEqualToSystemSpacingBelow(guide.topAnchor, multiplier: 1.0).isActive = true
        } else {
            let standardSpacing: CGFloat = 8.0
            statusLabel?.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor, constant: standardSpacing).isActive = true
        }
    }
    
    private func setupObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(onApplicationWillResignActive), name: Notification.Name.UIApplicationWillResignActive, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(onApplicationWillEnterForeground), name: Notification.Name.UIApplicationWillEnterForeground, object: nil)
    }
    
    @objc func onApplicationWillResignActive() {
        presenter.stopUpdatingISSPosition()
    }
    
    @objc func onApplicationWillEnterForeground() {
        presenter.startUpdatingISSPosition()
    }

}

extension RootViewController: MGLMapViewDelegate, RootView {
    
    
    // MARK: RootView methods
    
    func setStatus(status: String) {
        statusLabel?.text = status
    }
    
    func setPosition(withCoordinates coordinates: CLLocationCoordinate2D) {
        self.mapView?.setCenter(coordinates, animated: true)
    }
    
    func removeMapAnnotations() {
        if let mapView = mapView, let annotations = mapView.annotations {
            mapView.removeAnnotations(annotations)
        }
    }
    
    func addMapAnnotation(withAnnotation annotation: MGLPointAnnotation) {
        if let mapView = mapView {
            mapView.addAnnotation(annotation)
        }
    }
    
    
    // MARK: MGLMapViewDelegate methods
    
    func mapView(_ mapView: MGLMapView, annotationCanShowCallout annotation: MGLAnnotation) -> Bool {
        return true
    }
    
    func mapView(_ mapView: MGLMapView, calloutViewFor annotation: MGLAnnotation) -> MGLCalloutView? {
        return CustomCallOutView(annotation: annotation)
    }
        
}

