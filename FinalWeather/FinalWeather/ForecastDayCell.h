//
//  ForecastDayCell.h
//  FinalWeather
//
//  Created by TATUYEN on 7/15/15.
//  Copyright (c) 2015 tuyenta. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ForecastDayCell : UITableViewCell

@property (nonatomic,weak) IBOutlet UILabel *lbldayofWeek;
@property (nonatomic,weak) IBOutlet UILabel *lblHighTemp;
@property (nonatomic,weak) IBOutlet UILabel *lblLowTemp;

@property (weak, nonatomic) IBOutlet UIImageView *dayImage;



@end
