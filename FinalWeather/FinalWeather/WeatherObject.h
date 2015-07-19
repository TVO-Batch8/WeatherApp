//
//  WeatherObject.h
//  FinalWeather
//
//  Created by TATUYEN on 7/11/15.
//  Copyright (c) 2015 tuyenta. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WeatherObject : NSObject


// Forecast Day;
@property(nonatomic,strong) NSString *weakday; // Monday -- Sunday
@property(nonatomic,strong) NSString *hightemp; // Fasherenhit F - Celsius C
@property(nonatomic,strong) NSString *lowtemp; // Fasherenhit F - Celsius C
@property(nonatomic,strong) NSString *iconweather; // icon

-(instancetype)initWithWeakday:(NSString *)Weakday Hightemp:(NSString *)getHightemp Lowtemp:(NSString *)getLowtemp IconWeather:(NSString *)getIconweather;

@end
