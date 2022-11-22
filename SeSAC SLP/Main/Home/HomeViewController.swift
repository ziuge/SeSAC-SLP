//
//  HomeViewController.swift
//  SeSAC SLP
//
//  Created by CHOI on 2022/11/14.
//

import UIKit
import NMapsMap
import CoreLocation

class HomeViewController: BaseViewController {
    
    var locationManager = CLLocationManager()
    
    let mapView: NMFMapView = {
        let map = NMFMapView()
//        map.showLocationButton = true
        return map
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        
        DispatchQueue.main.async { [weak self] in
            if CLLocationManager.locationServicesEnabled() {
                print("위치 서비스 On 상태")
                self?.locationManager.startUpdatingLocation()
                print(self?.locationManager.location?.coordinate)
                

//                let marker = NMFMarker()
//                marker.position = NMGLatLng(lat: self?.locationManager.location?.coordinate.latitude ?? 0, lng: self?.locationManager.location?.coordinate.longitude ?? 0)
//                marker.mapView = self?.mapView
            } else {
                print("위치 서비스 Off 상태")
            }
        }
        
    }
    
    override func configure() {
        [mapView].forEach {
            view.addSubview($0)
        }
    }
    override func setConstraints() {
        mapView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
            make.top.equalTo(view)
        }
        
    }
    
}

extension HomeViewController: CLLocationManagerDelegate {
    // 위치 정보 계속 업데이트 -> 위도 경도 받아옴
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("didUpdateLocations")
        if let location = locations.first {
            print("위도: \(location.coordinate.latitude)")
            print("경도: \(location.coordinate.longitude)")
            
            //현 위치로 카메라 이동
            let cameraUpdate = NMFCameraUpdate(scrollTo: NMGLatLng(lat: location.coordinate.latitude, lng: location.coordinate.longitude))
            cameraUpdate.animation = .easeIn
            mapView.moveCamera(cameraUpdate)
        }
    }
    
    // 위도 경도 받아오기 에러
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}

extension HomeViewController: NMFMapViewCameraDelegate {
    
}


