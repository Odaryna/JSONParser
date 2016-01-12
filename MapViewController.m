//
//  MapViewController.m
//  JSONParser
//
//  Created by Admin on 1/12/16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import "MapViewController.h"
#import "BuildingPin.h"
#import "Building.h"

@interface MapViewController ()

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (nonatomic,strong) CLLocationManager * locationManager;

@end

@implementation MapViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self startLocationManager];
    [self.mapView setShowsUserLocation:true];
    [self.mapView setDelegate:self];
    
    for (Building * object in self.selectedPins)
    {
        BuildingPin* pin = [BuildingPin new];
        [pin setCoordinate:CLLocationCoordinate2DMake(object.latitude, object.longitude)];
        pin.title = object.title;
        [self.mapView addAnnotation:pin];
    }
    

}


-(void)viewWillAppear:(BOOL)animated
{
    [self.mapView setRegion:MKCoordinateRegionMake([[self.mapView annotations] objectAtIndex:0].coordinate, MKCoordinateSpanMake(0.1f, 0.1f)) animated:true];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)startLocationManager
{
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    self.locationManager.distanceFilter = kCLDistanceFilterNone;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
    [self.locationManager startUpdatingLocation];
    [self.locationManager requestWhenInUseAuthorization];
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MKUserLocation class]])
    {
        return nil;
    }
    
    static NSString* myIdentifier = @"myIdentifier";
    MKPinAnnotationView *pinView = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:myIdentifier];
    
    if (!pinView)
    {
        pinView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:myIdentifier];
        pinView.canShowCallout = YES;
        pinView.image = [UIImage imageNamed:@"marker@2x.png"];

    }
    return pinView;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
