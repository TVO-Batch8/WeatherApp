//
//  WeatherObject.m
//  FinalWeather
//
//  Created by TATUYEN on 7/11/15.
//  Copyright (c) 2015 tuyenta. All rights reserved.
//

#import "WeatherObject.h"

@implementation WeatherObject

-(instancetype)initWithWeakday:(NSString *)getWeekday Hightemp:(NSString *)getHightemp Lowtemp:(NSString *)getLowtemp IconWeather:(NSString *)getIconweather
{
    self=[super init];
    if(self)
    {
        self.weakday= getWeekday;
        self.hightemp= getHightemp;
        self.lowtemp = getLowtemp;
        self.iconweather =getIconweather;
    }
    return self;
    
}
@end