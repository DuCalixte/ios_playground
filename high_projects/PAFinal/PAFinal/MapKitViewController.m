//
//  MapKitViewController.m
//  PAFinal
//
//  Created by STANLEY CALIXTE on 5/26/14.
//  Copyright (c) 2014 STANLEY CALIXTE. All rights reserved.
//

#import "MapKitViewController.h"

#define METERS_PER_MILE 1609.344

@interface MapKitViewController ()

@end

@implementation MapKitViewController

@synthesize mapView = _mapView;

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation NS_AVAILABLE(10_9, 4_0)
{
    self.mapView.centerCoordinate = userLocation.location.coordinate;
}

- (MKAnnotationView *)mapView:(MKMapView *)map viewForAnnotation:(id <MKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MKUserLocation class]])
    {
        ((MKUserLocation *)annotation).title = @"My Current Location";
        return nil;  //return nil to use default blue dot view
    }
    
    return nil;
}

- (void) loadMapView
{
    MKUserLocation *userLocation = self.mapView.userLocation;
    
    MKCoordinateRegion region  = MKCoordinateRegionMakeWithDistance(userLocation.coordinate, 0.5 *METERS_PER_MILE, 0.5*METERS_PER_MILE);
    [self.mapView setRegion:region animated:YES];

}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void) awakeFromNib
{
    [super awakeFromNib];
    
    [self loadMapView];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"MapKit";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
 */



@end
