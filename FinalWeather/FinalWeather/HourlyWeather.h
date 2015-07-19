//
//  HourlyWeather.h
//  FinalWeather
//
//  Created by TATUYEN on 7/16/15.
//  Copyright (c) 2015 tuyenta. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HourlyWeather : NSObject
// Forecast Day;
@property(nonatomic,strong) NSString *civil; // 6AM
@property(nonatomic,strong) NSString *iconforhour;
@property(nonatomic,strong) NSString *tempmetric;
//@property(nonatomic,strong) NSString *tempenglish;

-(instancetype)initWithHourly:(NSString *)civil andIcon:(NSString *)getIcon andTemp:(NSString *)getTemp;

@end


