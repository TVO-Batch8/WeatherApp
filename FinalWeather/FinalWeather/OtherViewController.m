//
//  OtherViewController.m
//  FinalWeather
//
//  Created by TATUYEN on 7/9/15.
//  Copyright (c) 2015 tuyenta. All rights reserved.
//

#import "OtherViewController.h"
#import <CoreData/CoreData.h>

@interface OtherViewController ()

@end

@implementation OtherViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (NSManagedObjectContext *)managedObjectContext {
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}


- (IBAction)btnCancel:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)btnSave:(id)sender {
    NSManagedObjectContext *context = [self managedObjectContext];
    
    // Create a new managed object
    NSManagedObject *newDevice = [NSEntityDescription insertNewObjectForEntityForName:@"Province" inManagedObjectContext:context];
    [newDevice setValue:self.txtName.text forKey:@"name"];
    [newDevice setValue:self.txtLatitude.text forKey:@"latitude"];
    [newDevice setValue:self.txtLongitude.text forKey: @"longitude"];
    
    NSError *error = nil;
    // Save the object to persistent store
    if (![context save:&error]) {
        NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}
@end
