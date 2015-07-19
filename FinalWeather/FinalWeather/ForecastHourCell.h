//
//  ForecastHourCell.h
//  FinalWeather
//
//  Created by TATUYEN on 7/15/15.
//  Copyright (c) 2015 tuyenta. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ForecastHourCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *lblHourly;
@property (weak, nonatomic) IBOutlet UIImageView *imgHourly;

@property (weak, nonatomic) IBOutlet UILabel *lblTempHour;

@end
