//
//  ViewController.swift
//  AppleMaps
//
//  Created by Kevin Harris on 6/26/16.
//  Copyright © 2016 Guild/SA. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let location = CLLocationCoordinate2D(latitude: 33.171000,longitude: -96.831992)
        
        let span = MKCoordinateSpanMake(0.05, 0.05)

        let region = MKCoordinateRegion(center: location, span: span)

        mapView.setRegion(region, animated: true)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = location
        annotation.title = "Guild/SA"
        annotation.subtitle = "Guild of Software Architects"
        
        mapView.addAnnotation(annotation)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func mapViewDidFinishRenderingMap(mapView: MKMapView, fullyRendered: Bool) {
        print("mapViewDidFinishRenderingMap: \(fullyRendered)")
    }
    
    @IBAction func onValueChangedSegment(sender: UISegmentedControl) {
        
        switch sender.selectedSegmentIndex {
            case 0:
                mapView.mapType = MKMapType.Standard
            case 1:
                mapView.mapType = MKMapType.Satellite
            case 2:
                mapView.mapType = MKMapType.Hybrid
                //setUpCamera()
            default:
                break
        }
        
    }
    
    private func setUpCamera() {
        mapView.camera.altitude = 1500
        mapView.camera.pitch = 60
        mapView.camera.heading = 180
    }
    
    @IBAction func onShowTrafficBtn(sender: UIButton) {

        mapView.showsTraffic = !mapView.showsTraffic
        
        if(mapView.showsTraffic == true) {
            sender.setTitle("Hide Traffic", forState: UIControlState.Normal)
        } else {
            sender.setTitle("Show Traffic", forState: UIControlState.Normal)
        }
    }
    
    @IBAction func onShowCompassBtn(sender: UIButton) {

        mapView.showsCompass = !mapView.showsCompass
        
        if(mapView.showsCompass == true) {
            sender.setTitle("Hide Compass", forState: UIControlState.Normal)
        } else {
            sender.setTitle("Show Compass", forState: UIControlState.Normal)
        }
    }

}

