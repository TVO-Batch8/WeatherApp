//
//  AppleMapViewController.h
//  FinalWeather
//
//  Created by TATUYEN on 7/13/15.
//  Copyright (c) 2015 tuyenta. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>



@interface AppleMapViewController : UIViewController<MKMapViewDelegate,UIActionSheetDelegate, CLLocationManagerDelegate>

    
@property (weak, nonatomic) IBOutlet MKMapView *mapView;

- (IBAction)btnChooseMap:(id)sender;


@property (nonatomic,strong) NSString *thirdlatitude;
@property (nonatomic,strong) NSString *thirdLongitude;

@end
