//
//  MapViewController.swift
//  getWeather
//
//  Created by Zhora Babkahanyan on 25.01.22.
//

import UIKit
import MapKit


class MapViewController: UIViewController, UIGestureRecognizerDelegate{
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var myView: UIView!
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var removeButton: UIButton!
    
    var camera: MKMapCamera?
    let distance: CGFloat = 14000000
    let pitch: CGFloat = 0
    let heading = 1.0

    var weatherManager = WeatherManager()
    var objOfDefaultPlaces = DefaultPlaces()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
         mapView.delegate = self
         weatherManager.delegate = self
        
         defaultPlaces()
        
         myView.layer.cornerRadius = 18
         myView.layer.masksToBounds = true
         removeButton.backgroundColor = .red
         removeButton.layer.cornerRadius = 10
         removeButton.layer.masksToBounds = true
        
          
         let coordinate = CLLocationCoordinate2D(latitude: 40.1811, longitude: 44.5136)
        
         camera = MKMapCamera(lookingAtCenter: coordinate, fromDistance: distance, pitch: pitch, heading: heading)
         mapView.camera = camera!
        
         let oLongTapGesture = UILongPressGestureRecognizer(target: self, action: #selector(MapViewController.handleLongtapGesture(gestureRecogniazer:)))
         self.mapView.addGestureRecognizer(oLongTapGesture)
    }
    
    func defaultPlaces(){
        for i in 0...objOfDefaultPlaces.places.count - 1  {
            makePins(latitude: objOfDefaultPlaces.places[i].latitude, longitude: objOfDefaultPlaces.places[i].longitude)
        }
    }
    
    @IBAction func removePinButton(_ sender: UIButton) {
        mapView.removeAnnotations(mapView.annotations)
    }
    
    
    // Press Recognizer
    
    @objc func handleLongtapGesture(gestureRecogniazer: UILongPressGestureRecognizer){
        if gestureRecogniazer.state != UIGestureRecognizer.State.ended{
           
            let touchLocation = gestureRecogniazer.location(in: mapView)
            let locationCoordinate = mapView.convert(touchLocation, toCoordinateFrom: mapView)
              makePins(latitude: locationCoordinate.latitude, longitude: locationCoordinate.longitude)
        }
    }
    
    
    func makePins(latitude : CLLocationDegrees , longitude : CLLocationDegrees){
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        annotation.title = "Tap Please"
        mapView.addAnnotation(annotation)
        
    }
    
}

//MARK: - WeatherManagerDelegate


extension MapViewController: WeatherManagerDelegate {
    
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel){
        DispatchQueue.main.async {
            self.temperatureLabel.text = weather.tempatureString
            self.conditionImageView.image = UIImage(systemName: weather.conditionName)
            self.cityLabel.text = weather.cityName
        }
        
    }
    func didFailWithError(error: Error) {
        print(error)
    }
}



// MARK: - MKMapViewDelegate

extension MapViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView){
        
        let lon = view.annotation?.coordinate.longitude
        let lat = (view.annotation?.coordinate.latitude)!
        weatherManager.fetchWeather(latitude: lat, longitute: lon!)
        
    }
}
