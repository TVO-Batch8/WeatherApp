//
//  SettingViewController.m
//  FinalWeather
//
//  Created by TATUYEN on 7/19/15.
//  Copyright (c) 2015 tuyenta. All rights reserved.
//

#import "SettingViewController.h"
#import "WeatherViewController.h"

@interface SettingViewController ()

@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)chooseTemp:(id)sender {
   if(self.chooseTemp.selectedSegmentIndex == 0)
   {
      self.choose = @"C";
   }
       
    else
        self.choose = @"F";
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"TempSegue"]) {
        
        
        WeatherViewController *destViewController = segue.destinationViewController;
        destViewController.setTemp= self.choose;
        
        
    }
}

@end
