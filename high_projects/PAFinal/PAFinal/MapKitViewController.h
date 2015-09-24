//
//  MapKitViewController.h
//  PAFinal
//
//  Created by STANLEY CALIXTE on 5/26/14.
//  Copyright (c) 2014 STANLEY CALIXTE. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import "FeatureManagerViewController.h"

@interface MapKitViewController : FeatureManagerViewController<MKMapViewDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@end
