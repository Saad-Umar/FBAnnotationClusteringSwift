//
//  FBAnnotation.swift
//  FBAnnotationClusteringSwift
//
//  Created by Robert Chen on 4/2/15.
//  Copyright (c) 2015 Robert Chen. All rights reserved.
//

import Foundation
import CoreLocation
import MapKit
import Photos

open class FBAnnotation: NSObject {
    
    open var coordinate = CLLocationCoordinate2D()
    open var title: String?
    open var asset: PHAsset
    
    public init(coordinate: CLLocationCoordinate2D = CLLocationCoordinate2D(), title: String? = nil, asset: PHAsset) {
        self.coordinate = coordinate
        self.title = title
        self.asset = asset
    }
}

extension FBAnnotation : MKAnnotation { }
