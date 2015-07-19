//
//  OtherViewController.h
//  FinalWeather
//
//  Created by TATUYEN on 7/9/15.
//  Copyright (c) 2015 tuyenta. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>


@interface OtherViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *txtName;
@property (weak, nonatomic) IBOutlet UITextField *txtLatitude;
@property (weak, nonatomic) IBOutlet UITextField *txtLongitude;



- (IBAction)btnCancel:(id)sender;
- (IBAction)btnSave:(id)sender;

@end
