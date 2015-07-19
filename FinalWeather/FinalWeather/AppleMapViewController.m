//
//  AppleMapViewController.m
//  FinalWeather
//
//  Created by TATUYEN on 7/13/15.
//  Copyright (c) 2015 tuyenta. All rights reserved.
//

#import "AppleMapViewController.h"
#import "MyAnomation.h"

@interface AppleMapViewController ()
@property(nonatomic,strong) CLLocationManager *locationManager;
@end

@implementation AppleMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title =@"MAP";
    
    float lat= [self.thirdlatitude floatValue];
    float lon =[self.thirdLongitude floatValue];
    /*
     NSLog(@"Hi %.8f",lat);
     NSLog(@"Hi Long %.8f",lon);
     */
    
    MyAnomation *myAnnotation = [[MyAnomation alloc] initWithCoordinate:CLLocationCoordinate2DMake(lat,lon) title:@"TPHCM" andSubtitle:@"Saigon"];
    
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(CLLocationCoordinate2DMake(lat,lon), 100000, 100000);
    [self.mapView setRegion:region animated:YES];
    [self.mapView addAnnotation:myAnnotation];
    self.mapView.mapType =MKMapTypeStandard;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
    MKAnnotationView *view = nil;
    if ([annotation isKindOfClass:[MyAnomation class]]) {
        view = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"myAnnotation"];
        view.image = [UIImage imageNamed:@"clear"];
        view.centerOffset = CGPointMake(0, -16);
        view.canShowCallout = YES;
    }
    return view;
}

- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view {
    NSLog(@"did select annotation");
}

- (IBAction)btnChooseMap:(id)sender {
    
    NSString *title, *canncel;
    title = @"Choose Map";
    canncel = @"Cancel";
    
    // Intilization actionSheet
    UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                  initWithTitle:title delegate:self
                                  cancelButtonTitle:canncel
                                  destructiveButtonTitle:nil
                                  otherButtonTitles:@"Map", @"Satellite", @"Hybrid", nil];
    [actionSheet showInView:self.view];
}
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0:
            self.mapView.mapType = MKMapTypeStandard;
            break;
        case 1:
            self.mapView.mapType =MKMapTypeSatellite;
            break;
        case 2:
            self.mapView.mapType =MKMapTypeHybrid;
            break;
        default:
            break;
    }
    
}
@end
