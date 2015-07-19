//
//  WeatherViewController.m
//  FinalWeather
//
//  Created by TATUYEN on 7/8/15.
//  Copyright (c) 2015 tuyenta. All rights reserved.
//

#import "WeatherViewController.h"
#import "WeatherObject.h"
#import "AppleMapViewController.h"
#import "ForecastHourCell.h"
#import "ForecastDayCell.h"
#import "HourlyWeather.h"

@interface WeatherViewController ()

{
    NSData *jsonData;
    NSDictionary *dataDictionary;

    
}
@property(nonatomic,strong) NSMutableArray *objectHolderArray;
@property(nonatomic,strong) NSMutableArray *objectHourArray;
@property(nonatomic,strong) NSString *tmp;



@end

@implementation WeatherViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     [self.navigationController.navigationBar setHidden:NO];
    [self.myTableView setBounces:NO];
    [self.myCollectionView setBounces:NO];
    
    self.receviceAddress.text =self.receviceCity;
    
    [self.navigationController.navigationBar setBackgroundColor:[UIColor clearColor]];
    self.navigationController.navigationBar.translucent = YES;
    [self.myCollectionView registerNib:[UINib nibWithNibName:@"CustomCollectionCell" bundle:nil] forCellWithReuseIdentifier:@"myCell"];
  
    self.title =@"Weather";
    NSLog(@"Setting Tempanature: %@",self.setTemp);
    NSLog(@"Recevice Latitude: %@, Longitude :%@",self.receviceLatitude,self.receviceLongitude);
    
    
    // Set Current Time
    NSDate *today = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"HH:mm:ss"];
    NSString *currentTime = [dateFormatter stringFromDate:today];
    [dateFormatter setDateFormat:@"dd.MM.yyyy"];
    NSString *currentDate = [dateFormatter stringFromDate:today];
    NSLog(@"Time:%@, Date: %@ ",currentTime,currentDate);
    
    // Call fetch Data
    [self FetchData];
    
    // CurrentDay
    NSArray *results =  [dataDictionary objectForKey:@"current_observation"];
    NSString *weather = [results valueForKey:@"weather"];
    if([self.setTemp isEqualToString:@"F"])
    {
        self.tmp = [results valueForKey:@"temp_f"];
        
    }
    else
    {
        self.tmp =[results valueForKey:@"temp_c"];
    }
    int value = [self.tmp intValue];
    
    // Độ ẩm = relative_humidity
    NSString *relative_humidity = [results valueForKey:@"relative_humidity"];
    // Icon thời tiết
    NSString *image =[results valueForKey:@"icon"];
    [self.imageweather setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@",image]]];
    
    NSLog(@"==============");
    NSLog(@"Current conditions:\n Weather:%@\n, Temperature: %i\n, Humudity %@\n, Icon %@\n", weather,value,relative_humidity,image);
    self.statusweather.text = weather;
    self.temperature.text = [NSString stringWithFormat:@"%d",value];
    self.lblhumidity.text =relative_humidity;
    self.lblDatetime.text = currentDate;
    
#pragma Melthod ForeCastDay
    // NSDictionary forecast
    NSDictionary *result =  [dataDictionary objectForKey:@"forecast"];
    // NSDictionary simpleforcast
    NSDictionary *results2 =  [result objectForKey:@"simpleforecast"];
    // NSArray forecastday
    NSArray *results3 =  [results2 objectForKey:@"forecastday"];
    //
    for(int i =0; i<7;i++)
    {
        NSDictionary *results4 =[results3 objectAtIndex:i];
        
        NSDictionary *results5 =[results4 objectForKey:@"date"];
        NSDictionary *results6 =[results4 objectForKey:@"high"];
        NSDictionary *results7 =[results4 objectForKey:@"low"];
        
        NSString *day = [results5 valueForKey:@"weekday"];
        NSString *hightemp = [results6 valueForKey:@"celsius"];
        NSString *lowtemp = [results7 valueForKey:@"celsius"];
        NSString *iconweather =[results4 valueForKey:@"icon"];
        NSLog(@"Day Of Week: %@\n High Temperature: %@\n Low Temperature: %@ \n Icon Wearther: %@",day,hightemp,lowtemp,iconweather);
        
        WeatherObject *currentWeather = [[WeatherObject alloc]initWithWeakday:day Hightemp:hightemp Lowtemp:lowtemp IconWeather:iconweather];
        [self.objectHolderArray addObject:currentWeather];
    }
    NSLog(@"HolderArray :%ld",(long)[self.objectHolderArray count]);
    
    
#pragma mark - Forecast Hourly;
    
    // Get Json Data
    NSString *JSON_URL2 = [NSString stringWithFormat:@"http://api.wunderground.com/api/1d1c2691bb0505d7/hourly/q/%@,%@.json",self.receviceLatitude,self.receviceLongitude];
    
    NSURL *blogURL2 = [NSURL URLWithString:JSON_URL2];
    jsonData = [NSData dataWithContentsOfURL:blogURL2];
    NSError *error2 = nil;
    dataDictionary = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:&error2];
    
    // Hourly Day
    NSArray *arrayHourly =  [dataDictionary objectForKey:@"hourly_forecast"];
    for (int i; i<[arrayHourly count]; i++)
    {
        NSDictionary *array1 = [arrayHourly objectAtIndex:i];
        NSDictionary *fcttime =[array1 objectForKey:@"FCTTIME"];
        NSDictionary *temp =[array1 objectForKey:@"temp"];
        NSString *civil = [fcttime valueForKey:@"civil"];
        NSString *metric = [temp valueForKey:@"metric"];
        NSString *iconforhour = [array1 valueForKey:@"icon"];
        //NSLog(@"Civil %@\n Metric: %@ \n Weather on Hour: %@",civil ,metric,iconforhour);
        HourlyWeather *hourWeather =[[HourlyWeather alloc]initWithHourly:civil andIcon:iconforhour andTemp:metric];
        [self.objectHourArray addObject:hourWeather];
        
        //  NSLog(@"HolderArray 2 :%ld",(long)[self.objectHourArray count]);
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

-(NSMutableArray *)objectHolderArray{
    if(!_objectHolderArray) _objectHolderArray = [[NSMutableArray alloc]init];
    return _objectHolderArray;
}

-(NSMutableArray *)objectHourArray{
    if(!_objectHourArray) _objectHourArray = [[NSMutableArray alloc]init];
    return _objectHourArray;
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.objectHolderArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *simpleTableIdentifier = @"TableCell";
    ForecastDayCell *cell = (ForecastDayCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil)
    {
        
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"CustomTableCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
        
    }
    WeatherObject *currentWeather = [self.objectHolderArray objectAtIndex:indexPath.row];
    cell.lbldayofWeek.text = currentWeather.weakday;
    cell.lblHighTemp.text = currentWeather.hightemp;
    cell.lblLowTemp.text = currentWeather.lowtemp;
    NSString *iconcell= currentWeather.iconweather;
    [cell.dayImage setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@",iconcell]]];
    return cell;
    
}
#pragma mark - Load Data
-(void) FetchData
{
    // Get Json Data
    NSString *JSON_URL = [NSString stringWithFormat:@"http://api.wunderground.com/api/1d1c2691bb0505d7/conditions/forecast7day/q/%@,%@.json",self.receviceLatitude,self.receviceLongitude];
    
    //NSString *JSON_URL =  @"http://api.wunderground.com/api/513c19f62f591775/conditions/forecast7day/q/10.77204960,106.65782780.json";
    
    NSURL *blogURL = [NSURL URLWithString:JSON_URL];
    jsonData = [NSData dataWithContentsOfURL:blogURL];
    NSError *error = nil;
    dataDictionary = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:&error];

}
#pragma mark - CollectonView data source
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1 ;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.objectHourArray count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIndentify=@"myCell";
    ForecastHourCell *myCell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIndentify forIndexPath:indexPath];
    
    if (myCell == nil)
    {
        
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"ForecastHourCell" owner:self options:nil];
        myCell = [nib objectAtIndex:0];
        
    }
    HourlyWeather *forcastHourly = [self.objectHourArray objectAtIndex:indexPath.row];
    myCell.lblHourly.text = forcastHourly.civil;
    myCell.lblTempHour.text =forcastHourly.tempmetric;
    NSString *icon2= forcastHourly.iconforhour;
    [myCell.imgHourly setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@",icon2]]];
    return myCell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"segueMap"])
    {
        NSString *lat= self.receviceLatitude;
        NSString *longitude = self.receviceLongitude;
        
        AppleMapViewController *destViewController = segue.destinationViewController;
        destViewController.thirdlatitude = lat;
        destViewController.thirdLongitude =longitude;
        
    }
}
@end
