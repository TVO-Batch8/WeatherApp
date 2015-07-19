//
//  HourlyWeather.m
//  FinalWeather
//
//  Created by TATUYEN on 7/16/15.
//  Copyright (c) 2015 tuyenta. All rights reserved.
//

#import "HourlyWeather.h"

@implementation HourlyWeather

-(instancetype)initWithHourly:(NSString *)getCivil andIcon:(NSString *)getIcon andTemp:(NSString *)getTemp

{
    self=[super init];
    if(self)
    {
        self.civil=getCivil;
        self.iconforhour=getIcon;
        self.tempmetric= getTemp;
    }
    return self;
    
}

@end
