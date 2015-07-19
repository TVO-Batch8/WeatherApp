//
//  ViewController.m
//  FinalWeather
//
//  Created by TATUYEN on 7/8/15.
//  Copyright (c) 2015 tuyenta. All rights reserved.
//

#import "ViewController.h"
#import "WeatherViewController.h"

@interface ViewController ()
@property(nonatomic,strong) CLLocationManager *locationManager;
@property(nonatomic,strong) CLGeocoder *geocoder;
@property (nonatomic,strong)CLPlacemark *placemark;
@property(nonatomic,strong) CLLocation *currentLocation;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //self.navigationController.navigationBar.hidden = YES;
  
    
    if ([CLLocationManager locationServicesEnabled]) {
        self.locationManager = [[CLLocationManager alloc] init];
        self.locationManager.delegate =self;
       [self.locationManager startUpdatingLocation];
        if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
            [self.locationManager requestWhenInUseAuthorization];
            NSLog(@"Location Service enabled");
        }
    }
    else
    {
        NSLog(@"Location Service are not Enable");
    }
    self.geocoder = [[CLGeocoder alloc]init];
    
}
-(void)viewWillAppear:(BOOL)animated
{
    //[self.navigationController.navigationBar setHidden:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    NSLog(@"%@",[locations lastObject]);
    self.currentLocation = [locations lastObject];
    
    if (self.currentLocation != nil) {
        
        self.latitude.text = [NSString stringWithFormat:@"%.8f", self.currentLocation.coordinate.latitude];
        self.longitude.text = [NSString stringWithFormat:@"%.8f", self.currentLocation.coordinate.longitude];
        
    }
    else
    {
        NSLog(@"Latitude & Longitude are nil");
    }
    [self.geocoder reverseGeocodeLocation:self.currentLocation completionHandler:^(NSArray *placemarks, NSError *error) {
        
        if (error == nil && [placemarks count] > 0) {
            
            self.placemark = [placemarks lastObject];
            
            self.address.text = [NSString stringWithFormat:@"%@",self.placemark.administrativeArea];
            /*
             NSLog(@"======================");
             NSLog(@"%@",self.placemark.subThoroughfare);
             NSLog(@"%@",self.placemark.thoroughfare);
             NSLog(@"%@",self.placemark.postalCode);
             NSLog(@"%@",self.placemark.locality);
             NSLog(@"Ctiy Name %@",self.placemark.administrativeArea);
             NSLog(@"%@",self.placemark.country);
             */
            
        } else {
            
            NSLog(@"%@", error.debugDescription);
            
        }
        
    } ];
    
    
}
-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"Error : %@",error);
    NSLog(@"Failed get to location");
}
- (IBAction)btnPessed:(id)sender {
    NSLog(@"Hello Button");
    //self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    //[self.locationManager startUpdatingLocation];
    [self.locationManager stopUpdatingLocation];
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSString *sendaddress = [NSString stringWithFormat:@"%@",self.placemark.administrativeArea];
    NSString *sendlatitude= [NSString stringWithFormat:@"%.8f",self.currentLocation.coordinate.latitude];
    NSString *sendlongitude= [NSString stringWithFormat:@"%.8f",self.currentLocation.coordinate.longitude];
   
//    [[NSUserDefaults standardUserDefaults] setObject:sendaddress forKey:@"Address"];
//    [[NSUserDefaults standardUserDefaults] setObject:sendlatitude forKey:@"Latitude"];
//    [[NSUserDefaults standardUserDefaults] setObject:sendlongitude forKey:@"Longitude"];
    if ([segue.identifier isEqualToString:@"SegueView"])
    {
    
        
        WeatherViewController *destViewController = segue.destinationViewController;
        destViewController.receviceLatitude = sendlatitude;
        destViewController.receviceLongitude = sendlongitude;
        destViewController.receviceAddress.text = sendaddress;
        
    }
    
}


@end
