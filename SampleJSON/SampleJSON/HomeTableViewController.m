//
//  HomeTableViewController.m
//  SampleJSON
//
//  Created by Archie Angeles on 7/7/14.
//  Copyright (c) 2014 PachieOrg. All rights reserved.
//

#import "HomeTableViewController.h"
#import "TestViewController.h"
#import "DeviceActivationViewController.h"

@interface HomeTableViewController ()

@end

@implementation HomeTableViewController

@synthesize DeviceGUID;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}


-(void)viewDidAppear:(BOOL)animated
{
    
    
    
    NSString *uniqueIdentifier = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    
    DeviceGUID = uniqueIdentifier;
    
    NSString *url =[NSString stringWithFormat:@"http://www.riverwayauto.com:1980/WcfService2/Service1.svc/GetUserByDeviceID/%@",DeviceGUID];
    
    NSData *allCoursesData = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:url]];
    
    NSError *error;
    NSMutableDictionary *allCourses = [NSJSONSerialization JSONObjectWithData:allCoursesData options:NSJSONReadingMutableContainers error:&error];
    
    if (error) {
        NSLog(@"%@",[error localizedDescription]);
    }
    else {
        //NSArray *monday = allCourses[@"Monday"];
        for ( NSDictionary *user in allCourses )
        {
            NSLog(@"Checking if device is already registered with device id %@", DeviceGUID);
            //NSLog(@"Title: %@", theCourse[@"title"] );
            
            DeviceGUID = user[@"DeviceGUID"];
            _Email = user[@"Email"];
            _PhoneNumber = user[@"PhoneNumber"];
            _IsDeviceActivated = user[@"isDeviceActivated"];
            
        }
        
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Storyboard" bundle:nil];
        
        if ([_IsDeviceActivated isEqualToString:@"NO"]) {
            DeviceActivationViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"acid"];
            [vc setModalPresentationStyle:UIModalPresentationFullScreen];
            vc.deviceGUID = DeviceGUID;
            vc.emailAddress = _Email;
            
            
            [self presentViewController:vc animated:YES completion:nil];
        }
        else if ([_IsDeviceActivated isEqualToString:@"YES"])
        {
                    
            return;
        }
        else
        {
            
            TestViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"register"];
            [vc setModalPresentationStyle:UIModalPresentationFullScreen];
            vc.DeviceGUID = DeviceGUID;
            
            
            [self presentViewController:vc animated:YES completion:nil];
        }
        
        
        
        
    }
    
    
    
    
}

- (void)viewDidLoad
{
//    [super viewDidLoad];
//    
//    NSString *uniqueIdentifier = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
//    
//    DeviceGUID = uniqueIdentifier;
//    
//    NSString *url =[NSString stringWithFormat:@"http://www.riverwayauto.com:1980/WcfService2/Service1.svc/GetUserByDeviceID/%@",DeviceGUID];
//    
//    NSData *allCoursesData = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:url]];
//    
//    NSError *error;
//    NSMutableDictionary *allCourses = [NSJSONSerialization JSONObjectWithData:allCoursesData options:NSJSONReadingMutableContainers error:&error];
//    
//    if (error) {
//        NSLog(@"%@",[error localizedDescription]);
//    }
//    else {
//        //NSArray *monday = allCourses[@"Monday"];
//        for ( NSDictionary *user in allCourses )
//        {
//            NSLog(@"Checking if device is already registered with device id %@", DeviceGUID);
//            //NSLog(@"Title: %@", theCourse[@"title"] );
//            
//            DeviceGUID = user[@"DeviceGUID"];
//            _Email = user[@"Email"];
//            _PhoneNumber = user[@"PhoneNumber"];
//            _IsDeviceActivated = user[@"isDeviceActivated"];
//            
//        }
//        
//        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Storyboard" bundle:nil];
//        if ([_IsDeviceActivated isEqualToString:@"NO"]) {
//            DeviceActivationViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"acid"];
//            [vc setModalPresentationStyle:UIModalPresentationFullScreen];
//            vc.deviceGUID = DeviceGUID;
//            vc.emailAddress = _Email;
//            
//            
//            [self presentViewController:vc animated:YES completion:nil];
//        }
//        else if ([_IsDeviceActivated isEqualToString:@"YES"])
//        {
//            return;
//        }
//        else
//        {
//            
//            TestViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"register"];
//            [vc setModalPresentationStyle:UIModalPresentationFullScreen];
//            vc.DeviceGUID = DeviceGUID;
//            
//            
//            [self presentViewController:vc animated:YES completion:nil];
//        }
//        
//        
//        
//        
//    }
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
