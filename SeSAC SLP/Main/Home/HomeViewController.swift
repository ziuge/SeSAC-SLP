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
    let centerImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "marker")
        return image
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        
        mapView.addCameraDelegate(delegate: self)
        
    }
    
    override func configure() {
        [mapView, centerImage].forEach {
            view.addSubview($0)
        }
    }
    override func setConstraints() {
        mapView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
            make.top.equalTo(view)
        }
        centerImage.snp.makeConstraints { make in
            make.centerX.centerY.equalTo(view.safeAreaLayoutGuide)
            make.width.equalTo(35)
            make.height.equalTo(45)
        }
    }
    
}

extension HomeViewController: CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch CLLocationManager.authorizationStatus() {
        case .authorizedAlways, .authorizedWhenInUse:
            // do what is needed if you have access to location
            if CLLocationManager.locationServicesEnabled() {
                print("위치 서비스 On 상태")
//                self.locationManager.startUpdatingLocation()
//                print(self.locationManager.location?.coordinate)
//                //현 위치로 카메라 이동
//                let location = self.locationManager.location?.coordinate
//                let cameraUpdate = NMFCameraUpdate(scrollTo: NMGLatLng(lat: location?.latitude ?? 0, lng: location?.longitude ?? 0))
//                cameraUpdate.animation = .easeIn
//                self.mapView.moveCamera(cameraUpdate)
                
                
                // 시뮬 빌드를 위한 위치 변경 (새싹)
                let cameraUpdate = NMFCameraUpdate(scrollTo: NMGLatLng(lat: 37.517833650056794, lng: 126.88634053113901))
                cameraUpdate.animation = .easeIn
                self.mapView.moveCamera(cameraUpdate)

            } else {
                print("위치 서비스 Off 상태")
            }
        case .denied, .restricted:
            // do what is needed if you have no access to location
            showToast(message: "위치 권한을 허용해주세요")
        case .notDetermined:
            self.locationManager.requestWhenInUseAuthorization()
        @unknown default:
            // raise an error - This case should never be called
            print("error")
        }
    }
    
    // 위치 정보 계속 업데이트 -> 위도 경도 받아옴
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        print("didUpdateLocations")
//        if let location = locations.first {
//            print("위도: \(location.coordinate.latitude)")
//            print("경도: \(location.coordinate.longitude)")
//        }
//    }
    
    // 위도 경도 받아오기 에러
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}

extension HomeViewController: NMFMapViewCameraDelegate {
    func mapView(_ mapView: NMFMapView, cameraIsChangingByReason reason: Int) {
        print("카메라 변경됨: reason: \(reason)")
        let cameraPosition = mapView.cameraPosition
        
        print("위도:", cameraPosition.target.lat)
        print("경도:", cameraPosition.target.lng)
    }
}


