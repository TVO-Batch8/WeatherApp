//
//  SettingViewController.h
//  FinalWeather
//
//  Created by TATUYEN on 7/19/15.
//  Copyright (c) 2015 tuyenta. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingViewController : UIViewController
@property (weak, nonatomic) IBOutlet UISegmentedControl *chooseTemp;
@property (nonatomic,strong) NSString *choose;
- (IBAction)chooseTemp:(id)sender;


@end
