//
//  MyAnomation.m
//  FinalWeather
//
//  Created by TATUYEN on 7/13/15.
//  Copyright (c) 2015 tuyenta. All rights reserved.
//

#import "MyAnomation.h"

@implementation MyAnomation

- (instancetype)initWithCoordinate:(CLLocationCoordinate2D)coordinate title:(NSString *)title andSubtitle:(NSString *)subtitle {
    self = [super init];
    if (self) {
        _coordinate = coordinate;
        _title = title;
        _subtitle = subtitle;
    }
    return self;
}


@end
