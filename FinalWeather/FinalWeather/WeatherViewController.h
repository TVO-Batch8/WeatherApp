//
//  WeatherViewController.h
//  FinalWeather
//
//  Created by TATUYEN on 7/8/15.
//  Copyright (c) 2015 tuyenta. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface WeatherViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate>


// Current Day
@property (weak, nonatomic) IBOutlet UILabel *receviceAddress;
@property (weak, nonatomic) IBOutlet UILabel *statusweather;
@property (weak, nonatomic) IBOutlet UIImageView *imageweather;

@property (weak, nonatomic) IBOutlet UILabel *temperature;
@property (weak, nonatomic) IBOutlet UILabel *lblhumidity;
@property (weak, nonatomic) IBOutlet UILabel *lblDatetime;
@property (weak, nonatomic) IBOutlet UITableView *myTableView;

@property (weak, nonatomic) IBOutlet UICollectionView *myCollectionView;

@property (nonatomic,strong) NSString *receviceLatitude;
@property(nonatomic,strong) NSString *receviceLongitude;
@property (nonatomic, strong) NSString *receviceCity;
@property (nonatomic,strong)NSString *setTemp;


@end
