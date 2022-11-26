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
    var studyRecommend: [String] = []
    var studyQueue: [String] = []
    
    // MARK: UI
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
    let matchButton: UIButton = {
        let view = UIButton()
        view.setImage(UIImage(named: "Property 1=default"), for: .normal)
        return view
    }()
    let gpsButton: UIButton = {
        let view = UIButton()
        view.setImage(UIImage(named: "bt_gps"), for: .normal)
        return view
    }()
    
    // MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarController?.tabBar.isHidden = false
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        
        mapView.addCameraDelegate(delegate: self)
        matchButton.addTarget(self, action: #selector(searchSesac), for: .touchUpInside)
        gpsButton.addTarget(self, action: #selector(setGPS), for: .touchUpInside)
    }
    
    @objc func searchSesac() {
        let vc = SearchSesacViewController()
        vc.tagList = studyRecommend
        vc.studyQueueList = studyQueue
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func setGPS() {
        //현 위치로 카메라 이동
        let location = self.locationManager.location?.coordinate
        let cameraUpdate = NMFCameraUpdate(scrollTo: NMGLatLng(lat: location?.latitude ?? 0, lng: location?.longitude ?? 0))
        cameraUpdate.animation = .easeIn
        self.mapView.moveCamera(cameraUpdate)
        
        // 시뮬 빌드를 위한 위치 변경 (새싹)
//        let cameraUpdate = NMFCameraUpdate(scrollTo: NMGLatLng(lat: 37.517833650056794, lng: 126.88634053113901))
//        cameraUpdate.animation = .easeIn
//        self.mapView.moveCamera(cameraUpdate)
    }
    
    func fetchSesac(lat: Double, long: Double) {
        let api = SeSACAPI.main(lat: lat, long: long)
        Network.shared.requestSeSAC(type: Main.self, url: api.url, method: .post, parameters: api.parameters, headers: api.headers) { [weak self] response in
            switch response {
            case .success(let success):
                print("sesac success")
                
                for user in success.fromQueueDB {
                    print(user)
                    let marker = NMFMarker()
                    marker.position = NMGLatLng(lat: user.lat, lng: user.long)
                    marker.iconImage = NMFOverlayImage(image: UIImage(named: "sesac_face_\(user.sesac + 1)")!)
                    marker.width = 83
                    marker.height = 83
                    marker.mapView = self?.mapView
                    self?.studyQueue.append(contentsOf: user.studylist)
                }
                
                self?.studyRecommend = success.fromRecommend
                print("success recommend", success.fromRecommend)
                print("recommend:", self?.studyRecommend)
            case .failure(let error):
                print("sesac error", error)
            }
        }
    }
    
    override func configure() {
        [mapView, centerImage, matchButton, gpsButton].forEach {
            view.addSubview($0)
        }
    }
    override func setConstraints() {
        mapView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
            make.top.equalTo(view)
        }
        centerImage.snp.makeConstraints { make in
            make.centerX.equalTo(mapView)
            make.centerY.equalTo(mapView).offset(-45)
            make.width.equalTo(35)
            make.height.equalTo(45)
        }
        matchButton.snp.makeConstraints { make in
            make.bottom.trailing.equalTo(view.safeAreaLayoutGuide).offset(-16)
            make.height.width.equalTo(64)
        }
        gpsButton.snp.makeConstraints { make in
            make.height.width.equalTo(48)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(16)
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-16)
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
                let cameraUpdate = NMFCameraUpdate(scrollTo: NMGLatLng(lat: 37.48511640269022, lng: 126.92947109241517))
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
//        fetchSesac(lat: cameraPosition.target.lat, long: cameraPosition.target.lng)
    }
    
    func mapViewCameraIdle(_ mapView: NMFMapView) {
        let cameraPosition = mapView.cameraPosition
        fetchSesac(lat: cameraPosition.target.lat, long: cameraPosition.target.lng)
    }
}


