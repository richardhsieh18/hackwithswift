//
//  ViewController.swift
//  myUdTravelMapBook
//
//  Created by chang on 2017/7/3.
//  Copyright © 2017年 chang. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import CoreData

class ViewController: UIViewController,MKMapViewDelegate,CLLocationManagerDelegate {
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var commentText: UITextField!

    var locationManager = CLLocationManager()
    var chosenLatitude : Double = 0
    var chosenLongitude : Double = 0
    
    var transmittedTitle = ""
    var transmittedSubtitle = ""
    var transmittedLatitude : Double = 0
    var transmittedLongitude : Double = 0
    var requestCLLocation = CLLocation()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        //新東西
        mapView.delegate = self
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        //新增gesture方法
        let recognizer = UILongPressGestureRecognizer(target: self, action: #selector(chooseLocation(gestureRecognizer:)))
        recognizer.minimumPressDuration = 3
        mapView.addGestureRecognizer(recognizer)
        
        //顯示資料
        if transmittedTitle != ""
        {
            let annotation = MKPointAnnotation()
            let coordinate = CLLocationCoordinate2D(latitude: self.transmittedLatitude, longitude: self.transmittedLongitude)
            annotation.coordinate = coordinate
            annotation.title = self.transmittedTitle
            annotation.subtitle = self.transmittedSubtitle
            self.mapView.addAnnotation(annotation)
            
            self.nameText.text = self.transmittedTitle
            self.commentText.text = self.transmittedSubtitle
        }
        
        
    }
    //這也是沒看過的東西
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = CLLocationCoordinate2DMake(locations[0].coordinate.latitude, locations[0].coordinate.longitude)
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        
        let region = MKCoordinateRegion(center: location, span: span)
        self.mapView.setRegion(region, animated: true)
    }
    //自己新增method，選擇的地方
    func chooseLocation(gestureRecognizer: UILongPressGestureRecognizer)
    {
        if gestureRecognizer.state == UIGestureRecognizerState.began
        {
            //觸碰在營幕上的點
            let touchedPoint = gestureRecognizer.location(in: self.mapView)
            let chosenCoordinates = self.mapView.convert(touchedPoint, toCoordinateFrom: self.mapView)
            self.chosenLatitude = chosenCoordinates.latitude
            self.chosenLongitude = chosenCoordinates.longitude
            
            //大頭針
            let annotation = MKPointAnnotation()
            annotation.coordinate = chosenCoordinates
            annotation.title = nameText.text
            annotation.subtitle = commentText.text
            self.mapView.addAnnotation(annotation)
        }
        
    }
    //存取coreData需要先作的事
    @IBAction func saveBtnClicked(_ sender: UIButton) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let newLocation = NSEntityDescription.insertNewObject(forEntityName: "Locations", into: context)
        
        newLocation.setValue(nameText.text, forKey: "title")
        newLocation.setValue(commentText.text, forKey: "subtitle")
        newLocation.setValue(self.chosenLatitude, forKey: "latitude")
        newLocation.setValue(self.chosenLongitude, forKey: "longitude")
        //Error handling
        do {
            try context.save()
            print("存檔囉")
        }catch{
            print("出錯了")
        }
        NotificationCenter.default.post(name: NSNotification.Name(rawValue:"新位置已儲存"), object: nil)
        //navigation使用 pop
        self.navigationController?.popViewController(animated: true)
        
    }
    //客製化大頭針畫面
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation{
            return nil
        }
        
        let reuseId = "myAnnotation"
        
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as?MKPinAnnotationView
        
        if pinView == nil {
                pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView?.canShowCallout = true
            pinView?.pinTintColor = UIColor.blue
            
            let button = UIButton(type: .detailDisclosure)
            pinView?.rightCalloutAccessoryView = button
        }else{
            pinView?.annotation = annotation
        }
        return pinView
    }
    //mkmapview placemark 最後一章 L102 Navigation Builder
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if transmittedLatitude != 0{
            if transmittedLongitude != 0{
                self.requestCLLocation = CLLocation(latitude: transmittedLatitude, longitude: transmittedLongitude)
            }
        }
        CLGeocoder().reverseGeocodeLocation(requestCLLocation) { (placemarks, error) in
            if let placemark = placemarks{
                if placemark .count > 0 {
                    let newPlaceMark = MKPlacemark(placemark: placemark[0])
                    let item = MKMapItem(placemark: newPlaceMark)
                    item.name = self.transmittedTitle
                    //選擇啟用導航時的選項
                    let lanuchOptions = [MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeWalking]
                    item.openInMaps(launchOptions: lanuchOptions)
                }
            }
        }
    }

}

