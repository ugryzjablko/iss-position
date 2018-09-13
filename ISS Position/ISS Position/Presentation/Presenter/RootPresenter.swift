//
//  RootPresenter.swift
//  ISS Position
//
//  Created by Marcin Kuswik on 13.09.2018.
//  Copyright © 2018 Marcin Kuświk. All rights reserved.
//

import Foundation
import Mapbox

class RootPresenter: RootViewPresenter {
    

    unowned let view: RootView
    
    let issInfoService: ISSInfoService
    
    var taskManager: ScheduledTaskManager?
    
    var astronauts: [Astronaut]?
    
    
    required init(view: RootView, service: ISSInfoService) {
        self.view = view
        self.issInfoService = service
        self.setup()
    }
    
    private func setup() {
        taskManager = ScheduledTaskManager(interval: 5, repeats: true, delegate: self)
    }
    
    func updateListOfAtronatus() {
        issInfoService.getISSAstronauts { (astronatus, error) in
            if let astronauts = astronatus {
                self.astronauts = astronauts.people
            }
        }
    }
    
    func updateISSPosition() {
        issInfoService.getISSPosition { (issPosition, error) in
            if let position = issPosition {
                self .onGetISSPositionSuccess(issPostion: position)
            }
        }
    }
    
    private func onGetISSPositionSuccess(issPostion position: ISSNow) {
        let coordinates = prepareLocationCoordinates(withLatitude: position.issPosition.latitude, andLongitude: position.issPosition.longitude)
        view.setPosition(withCoordinates: coordinates)
        
        let status = self.prepareStatus(withISSPosition: position) ?? NSLocalizedString("RootPresenter.status-default-message", comment: "")
        view.setStatus(status: status)
        
        view.removeMapAnnotations()
        
        let mapAnnotationSubtitle = prepareAstronautsString(withAstronatus: astronauts) ?? NSLocalizedString("RootView.annotation.subtitle", comment: "")
        let mapAnnotation = prepareMapViewAnnotation(withTitle: NSLocalizedString("RootView.annotation.title", comment: ""), subtitle: mapAnnotationSubtitle, andCoorinates: coordinates)
        view.addMapAnnotation(withAnnotation: mapAnnotation)
        
        issInfoService.saveISSPosition(issPosition: position)
    }
    
    private func prepareLocationCoordinates(withLatitude latitude: Double, andLongitude longitude: Double) -> CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    private func prepareStatus(withISSPosition position: ISSNow?) -> String? {
        if let position = position {
            let formatStatus = NSLocalizedString("RootView.status.template", comment: "")
            return String.localizedStringWithFormat(formatStatus, position.issPosition.latitude, position.issPosition.longitude, position.timestamp.customDateStringFormat())
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
    
    private func prepareAstronautsString(withAstronatus astronauts: [Astronaut]?) -> String? {
        if let astros = astronauts {
            return astros.map({ $0.name }).joined(separator: "\n")
        }
        return nil
    }
    
    func startUpdatingISSPosition() {
        taskManager?.start()
    }
    
    func stopUpdatingISSPosition() {
        taskManager?.stop()
    }
}

extension RootPresenter: ScheduledTaskDelegate {
    
    // MARK: ScheduledTaskDelegate methods
    func performTask() {
        updateISSPosition()
    }

}
