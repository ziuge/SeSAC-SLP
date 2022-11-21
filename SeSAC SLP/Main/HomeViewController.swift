//
//  HomeViewController.swift
//  SeSAC SLP
//
//  Created by CHOI on 2022/11/14.
//

import UIKit
import MapKit

class HomeViewController: BaseViewController {
    
    let mapView: MKMapView = {
        let map = MKMapView()
        return map
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        mapView.delegate = self
    }
}

extension HomeViewController: MKMapViewDelegate {
    
}
