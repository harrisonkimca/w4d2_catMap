//
//  MapViewController.m
//  2w4d2_catMap
//
//  Created by Seantastic31 on 18/07/2017.
//  Copyright © 2017 Seantastic31. All rights reserved.
//

#import "MapViewController.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "Photo.h"

@interface MapViewController () <CLLocationManagerDelegate, MKMapViewDelegate>

@property (nonatomic) MKMapView *mapView;
@property (nonatomic) CLLocationManager *locationManager;

@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.locationManager = [[CLLocationManager alloc]init];
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    self.locationManager.distanceFilter = 5;
    [self.locationManager requestWhenInUseAuthorization];
    [self.locationManager startUpdatingLocation];
    
    self.mapView = [[MKMapView alloc]initWithFrame:self.view.bounds];
    self.mapView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    self.mapView.showsUserLocation = YES;
    self.mapView.showsBuildings = YES;
    self.mapView.showsTraffic = YES;
    self.mapView.showsPointsOfInterest = YES;
    self.mapView.delegate = self;
    [self.view addSubview:self.mapView];
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    MKPointAnnotation *myPoint = [[MKPointAnnotation alloc]init];
    myPoint.coordinate = CLLocationCoordinate2DMake(self.photo.latitude, self.photo.longitude);
    MKCoordinateSpan span = MKCoordinateSpanMake(.5f, .5f);
    self.mapView.region = MKCoordinateRegionMake(myPoint.coordinate, span);
    [self.mapView addAnnotation:myPoint];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations
{
    CLLocation *lastLocation = [locations lastObject];
    [self.mapView setRegion:MKCoordinateRegionMake(lastLocation.coordinate, MKCoordinateSpanMake(0.01, 0.01))animated:YES];
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    MKPinAnnotationView *pin = (MKPinAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:@"pin"];
    if (pin == nil)
    {
        pin = [[MKPinAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:@"pin"];
    }
    else
    {
        pin.annotation = annotation;
    }
    [pin setCanShowCallout:YES];
    
    return pin;
}



@end
