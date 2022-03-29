//
//  ViewController.swift
//  TravelBook
//
//  Created by Furkan Sarı on 26.03.2022.
//

import UIKit
import MapKit
import CoreLocation
import CoreData

class ViewController: UIViewController,MKMapViewDelegate,CLLocationManagerDelegate {

    @IBOutlet weak var placeName: UITextField!
    @IBOutlet weak var placeDesc: UITextField!
    @IBOutlet weak var mapView: MKMapView!
    let locationManager=CLLocationManager()
    var choosenLatitude = Double()
    var choosenLongitude = Double()
    var choosenTitle = ""
    var choosenId : UUID?
    var annotationLatitude = Double()
    var annotationLongitude = Double()
    override func viewDidLoad() {
        super.viewDidLoad()
       
        mapView.delegate=self
        locationManager.delegate=self
        locationManager.desiredAccuracy=kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        let gestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(longPress))
        gestureRecognizer.minimumPressDuration=2
        mapView.addGestureRecognizer(gestureRecognizer)
        //Data boş değil ise yapılacak işlemler
        if choosenTitle != "" {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Places")
            var stringId = choosenId?.uuidString
            fetchRequest.returnsObjectsAsFaults = false
            fetchRequest.predicate = NSPredicate(format: "id=%@", stringId!)
            
            do{
                let results = try context.fetch(fetchRequest)
                for result in results as! [NSManagedObject]{
                    if let place = result.value(forKey: "title") as? String{
                        placeName.text = place
                    }
                    if let id = result.value(forKey: "id") as? UUID{
                        print(id)
                    }
                    if let desc = result.value(forKey: "subtitle") as? String{
                        placeDesc.text = desc
                    }
                    if let latitude = result.value(forKey: "latitude") as? Double{
                        annotationLatitude = latitude
                        
                    }
                    if let longitude = result.value(forKey: "longitude") as? Double{
                        annotationLongitude = longitude
                        let annotation=MKPointAnnotation()
                        annotation.title=placeName.text
                        annotation.subtitle = placeDesc.text
                        let coordinate = CLLocationCoordinate2D(latitude: annotationLatitude, longitude: annotationLongitude)
                        annotation.coordinate = coordinate
                        mapView.addAnnotation(annotation)
                        let span = MKCoordinateSpan(latitudeDelta: 0.04, longitudeDelta: 0.04)
                        let region = MKCoordinateRegion(center: coordinate, span: span)
                        mapView.setRegion(region, animated: true)
                    }
                }
            }catch {
                print("Error choosenTitle")
            }
            
            
        }
        
        
        // Do any additional setup after loading the view.
    }
    
    @objc func longPress(gestureRecognizer:UILongPressGestureRecognizer){
        if gestureRecognizer.state == .began{
            let touchedPoint = gestureRecognizer.location(in: self.mapView)
            let touchedCoordinates = self.mapView.convert(touchedPoint, toCoordinateFrom: self.mapView)
            choosenLatitude=touchedCoordinates.latitude
            choosenLongitude=touchedCoordinates.longitude
            let annotation = MKPointAnnotation()
            annotation.coordinate = touchedCoordinates
            annotation.title = placeName?.text
            annotation.subtitle=placeDesc?.text
            self.mapView.addAnnotation(annotation)
        }
        
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if choosenTitle == "" {
            let location=CLLocationCoordinate2D(latitude: locations[0].coordinate.latitude, longitude: locations[0].coordinate.longitude)
            let span=MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
            let region=MKCoordinateRegion(center: location, span: span)
            mapView.setRegion(region, animated: true)
            
        }
        
    }
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            return nil
        }
        var reuseId="myAnnotation"
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId)
        if pinView == nil{
            return pinView
        }
    }

    @IBAction func saveButton(_ sender: Any) {
        let appDelegate=UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let newPlaces=NSEntityDescription.insertNewObject(forEntityName: "Places", into: context)
        
        newPlaces.setValue(placeName.text, forKey: "title")
        newPlaces.setValue(placeDesc.text, forKey: "subtitle")
        newPlaces.setValue(choosenLatitude, forKey: "latitude")
        newPlaces.setValue(choosenLongitude, forKey: "longitude")
        newPlaces.setValue(UUID(), forKey: "id")
        do{
            try context.save()
            print("success")
        }catch{
            print("error")
        }
        NotificationCenter.default.post(name: NSNotification.Name("newData"), object: nil)
        self.navigationController?.popViewController(animated: true)
    }
}

