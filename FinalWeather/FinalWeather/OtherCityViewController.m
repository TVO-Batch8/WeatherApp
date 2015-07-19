//
//  OtherCityViewController.m
//  FinalWeather
//
//  Created by TATUYEN on 7/9/15.
//  Copyright (c) 2015 tuyenta. All rights reserved.
//

#import "OtherCityViewController.h"
#import "OtherViewController.h"
#import "WeatherViewController.h"

@interface OtherCityViewController ()
@property(nonatomic,strong) NSString* cityName;

@end

@implementation OtherCityViewController

{
    NSArray *arrayCity;
    NSArray *arrayLatitude;
    NSArray *arrayLongitude;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title =@"City";
   /*
    NSDictionary *dict = @{ @"name": @"Hà Nội",
                            @"lat": @"21.03000069",
                            @"longi": @"105.80726624"};
    NSDictionary *dict_DaLat = @{ @"name": @"Đà Nẵng",
                                  @"lat": @"16.03000069",
                                  @"longi": @"108.18000031"
                                  };
    NSDictionary *dict_HCM = @{ @"name": @"Cần Thơ",
                                  @"lat": @"10.0341527",
                                  @"longi": @"105.7564947"
                                  };
    arrayCity = @[[dict objectForKey:@"name"],[dict_DaLat objectForKey:@"name"],[dict_HCM objectForKey:@"name"]]
    ;
     arrayLatitude= @[[dict objectForKey:@"lat"],[dict_DaLat objectForKey:@"lat"],[dict_HCM objectForKey:@"lat"]];
    arrayLongitude = @[[dict objectForKey:@"longi"],[dict_DaLat objectForKey:@"longi"],[dict_HCM objectForKey:@"longi"]];
    */


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSManagedObjectContext *)managedObjectContext {
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    // Fetch the devices from persistent data store
    NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Province"];
    self.arrayProvince = [[managedObjectContext executeFetchRequest:fetchRequest error:nil] mutableCopy];
    
    [self.tableview reloadData];
}

#pragma mark TableView Datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    //return [arrayCity count];
    return [self.arrayProvince count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *reuseIdentifier = @"Cell";
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if(cell==nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    }
    
    // Configure the cell...
    NSManagedObject *province = [self.arrayProvince objectAtIndex:indexPath.row];
    //cell.textLabel.text = [arrayCity objectAtIndex:indexPath.row];
    [cell.textLabel setText:[NSString stringWithFormat:@"%@",[province valueForKey:@"name"]]];

    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    //self.cityName =[arrayCity objectAtIndex:indexPath.row];
    //NSLog(@"Name of City: %@",self.cityName);
    NSManagedObject *selectedProvince = [self.arrayProvince objectAtIndex:[[self.tableview indexPathForSelectedRow] row]];
    self.cityName = [selectedProvince valueForKey:@"name"];
    
    [self performSegueWithIdentifier:@"detailSegue" sender:self];
    
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSManagedObjectContext *context = [self managedObjectContext];
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete object from database
        [context deleteObject:[self.arrayProvince objectAtIndex:indexPath.row]];
        
        NSError *error = nil;
        if (![context save:&error]) {
            NSLog(@"Can't Delete! %@ %@", error, [error localizedDescription]);
            return;
        }
        
        // Remove device from table view
        [self.arrayProvince removeObjectAtIndex:indexPath.row];
        [self.tableview deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}


#pragma Segue
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"detailSegue"]) {
        NSIndexPath *indexPath = [self.tableview indexPathForSelectedRow];
        
        //         OtherViewController *destViewController = segue.destinationViewController;
        //         destViewController.receviceCity = [arrayLatitude objectAtIndex:indexPath.row];
        
        NSManagedObject *selectedProvince = [self.arrayProvince objectAtIndex:indexPath.row];
        
        WeatherViewController *destViewController = segue.destinationViewController;
        /*
        destViewController.receviceLatitude = [arrayLatitude objectAtIndex:indexPath.row];
        destViewController.receviceLongitude =[arrayLongitude objectAtIndex:indexPath.row];
        destViewController.receviceCity = [arrayCity objectAtIndex:indexPath.row];
         */
        destViewController.receviceCity = [selectedProvince valueForKey:@"name"];
        destViewController.receviceLatitude =[selectedProvince valueForKey:@"latitude"];
        destViewController.receviceLongitude =[selectedProvince valueForKey:@"longitude"];
        NSLog(@"Prepare Segue %@",destViewController.receviceCity);
        
        
        
        
    }
}
@end
