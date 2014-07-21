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
#import "MessageDetailViewController.h"
#import "CommonFunction.h"
#import "AppDelegate.h"

@interface HomeTableViewController ()
{
    NSMutableArray *myObject;
    NSArray *myObjectSearch;
    // A dictionary object
    NSDictionary *dictionary;
    // Define keys
    
    bool isConnectionOK;
    
    
    
    NSString *MessageGUID ;
    NSString *HiritMessage ;
    NSString *CreatedByUserName ;
    NSString *CreatedByDeviceID ;
    NSDate *CreatedDate;
    NSString *Answer1;
}

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
    if (isConnectionOK == NO) {
        return;
    }
    
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    if ([delegate.isDeviceRegistered isEqualToString:@"NO"]) {
        
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Storyboard" bundle:nil];
        
        
            DeviceActivationViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"acid"];
            [vc setModalPresentationStyle:UIModalPresentationFullScreen];
            vc.deviceGUID = DeviceGUID;
            vc.emailAddress = _Email;
            
            
            [self presentViewController:vc animated:YES completion:nil];
        
        
    }

    
}


- (void)viewDidLoad
{
    
    UIRefreshControl *refresh = [[UIRefreshControl alloc] init];
    
    refresh.attributedTitle = [[NSAttributedString alloc] initWithString:@"Pull to Refresh"];
    
    [refresh addTarget:self action:@selector(LoadTable)forControlEvents:UIControlEventValueChanged];
    
    self.refreshControl = refresh;
    
    [self LoadTable];
}

- (void)stopRefresh

{
    if (isConnectionOK==true) {
        [self.tableView reloadData];
    }
    [self.refreshControl endRefreshing];
    
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
    //return myObject.count  ;
    
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        
        return myObjectSearch.count;
        
        
        
    } else {
        
        return myObject.count;
        
        
        
    }
    
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
   // UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    if (isConnectionOK == true) {
        
        
        NSDictionary *tmpDict = nil;//[myObject objectAtIndex:indexPath.row];
        
        
        
        if (tableView == self.searchDisplayController.searchResultsTableView) {
            
            tmpDict = [myObjectSearch objectAtIndex:indexPath.row];
            
            
        } else {
            
            tmpDict = [myObject objectAtIndex:indexPath.row];
            
            
        }

        
        cell.textLabel.text = [tmpDict objectForKey:@"HiritMessage"];
        cell.detailTextLabel.text =[NSString stringWithFormat:@"Created By %@",[tmpDict objectForKey:@"CreatedByUserName"]] ;
        
        
    }
    return cell;
    
    
}



/*
#pragma mark - Navigation
*/
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"MessageDetail"]) {
              
        NSIndexPath *path = [self.tableView indexPathForSelectedRow];
        
        MessageDetailViewController *dv = segue.destinationViewController;
        NSLog(@"clPanelSeguePathRow = %ld", (long)path.row);
        NSLog(@"myobject = %@", [[myObject objectAtIndex:path.row] objectForKey:@"templateid"]);
        NSString *messageGUID = [NSString stringWithFormat:@"%@",[[myObject objectAtIndex:path.row] objectForKey:@"MessageGUID"]];
        NSString *hiritMessage = [NSString stringWithFormat:@"%@",[[myObject objectAtIndex:path.row] objectForKey:@"HiritMessage"]];
        NSString *createdBy = [NSString stringWithFormat:@"%@",[[myObject objectAtIndex:path.row] objectForKey:@"CreatedBy"]];
        NSString *answer1 = [NSString stringWithFormat:@"%@",[[myObject objectAtIndex:path.row] objectForKey:@"Answer"]];
        
        dv.MessageGUID = messageGUID;
        dv.HiritMessage = hiritMessage;
        dv.CreatedBy = createdBy;
        dv.Answer = answer1;
        
        
        
    }

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        [self performSegueWithIdentifier: @"MessageDetail" sender: self];
    }
}

- (NSDate *)mfDateFromDotNetJSONString:(NSString *)string {
    static NSRegularExpression *dateRegEx = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dateRegEx = [[NSRegularExpression alloc] initWithPattern:@"^\\/date\\((-?\\d++)(?:([+-])(\\d{2})(\\d{2}))?\\)\\/$" options:NSRegularExpressionCaseInsensitive error:nil];
    });
    NSTextCheckingResult *regexResult = [dateRegEx firstMatchInString:string options:0 range:NSMakeRange(0, [string length])];
    
    if (regexResult) {
        // milliseconds
        NSTimeInterval seconds = [[string substringWithRange:[regexResult rangeAtIndex:1]] doubleValue] / 1000.0;
        // timezone offset
        if ([regexResult rangeAtIndex:2].location != NSNotFound) {
            NSString *sign = [string substringWithRange:[regexResult rangeAtIndex:2]];
            // hours
            seconds += [[NSString stringWithFormat:@"%@%@", sign, [string substringWithRange:[regexResult rangeAtIndex:3]]] doubleValue] * 60.0 * 60.0;
            // minutes
            seconds += [[NSString stringWithFormat:@"%@%@", sign, [string substringWithRange:[regexResult rangeAtIndex:4]]] doubleValue] * 60.0;
        }
        
        return [NSDate dateWithTimeIntervalSince1970:seconds];
    }
    return nil;
}

- (IBAction)Join:(id)sender {
    UIAlertView* mes=[[UIAlertView alloc] initWithTitle:@"Pickup Lines"
                                                message:@"Sorry function not yet ready" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
    
    [mes show];
}



-(void)LoadTable
{
    MessageGUID = @"MessageGUID";
    HiritMessage = @"HiritMessage";
    CreatedByUserName = @"CreatedByUserName";
    CreatedByDeviceID = @"CreatedByDeviceID";
    CreatedDate=    [NSDate date];
    Answer1 = @"Answer";
    
    
    myObject = [[NSMutableArray alloc] init];
    CommonFunction *common = [[CommonFunction alloc]init];
    
    NSString *x = [common GetJsonConnection:@"GetHiritMessage"];
    
    NSData *jsonSource = [NSData dataWithContentsOfURL:
                          [NSURL URLWithString:x]];
    
    
    if ([common CheckNSD:jsonSource] == false) {
        
        UIAlertView* mes=[[UIAlertView alloc] initWithTitle:@"Connection Error"
                                                    message:@"Connection error" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        
        isConnectionOK = NO;
        [mes show];
        
        [self performSelector:@selector(stopRefresh) withObject:nil afterDelay:2.5];
        
        return;
    }
    
    isConnectionOK = YES;
    
    
    id jsonObjects = [NSJSONSerialization JSONObjectWithData:
                      jsonSource options:NSJSONReadingMutableContainers error:nil];
    

    
    for (NSDictionary *dataDict in jsonObjects) {
        NSString *messageGUID = [dataDict objectForKey:@"MessageGUID"];
        NSString *hiritMessage = [dataDict objectForKey:@"HiritMessage"];
        NSString *createdByUserName = [dataDict objectForKey:@"CreatedByUserName"];
        NSString *createdByDeviceID = [dataDict objectForKey:@"CreatedByDeviceID"];
        NSString *createdDate = [dataDict objectForKey:@"CreatedDate"];
        NSString *answer1 = [dataDict objectForKey:@"Answer1"];
        
        
        
        NSLog(@"MessageGUID: %@",messageGUID);
        NSLog(@"Message: %@",hiritMessage);
        NSLog(@"CreatedByUserName: %@",createdByUserName);
        NSLog(@"CreatedByDeviceID: %@",createdByDeviceID);
        NSLog(@"CreatedDate: %@",createdDate);
        
        
        
        dictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                      messageGUID, MessageGUID,
                      hiritMessage, HiritMessage,
                      createdByUserName,CreatedByUserName,
                      createdByDeviceID,CreatedByDeviceID,
                      [self mfDateFromDotNetJSONString:createdDate], @"DateCreated",
                      answer1, Answer1,
                      nil];
        [myObject addObject:dictionary];
    }
    
    [self getJsonData];
    
    
}


-(void)getJsonData
{
    NSString *uniqueIdentifier = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    
    DeviceGUID = uniqueIdentifier;
    
    CommonFunction *common = [[CommonFunction alloc]init];
    
    NSString *url =[common GetJsonConnection:[NSString stringWithFormat:@"GetUserByDeviceID/%@",DeviceGUID]];
    
    
    //    NSString *url =[NSString stringWithFormat:[common GetJsonConnection:[NSString stringWithFormat:@"GetUserByDeviceID/%@",DeviceGUID]]];
    
    NSData *allCoursesData = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:url]];
    
    //CommonFunction *common = [[CommonFunction alloc]init];
    
    if ([common CheckNSD:allCoursesData] == false) {
        
        UIAlertView* mes=[[UIAlertView alloc] initWithTitle:@"Connection Error"
                                                    message:@"Connection error" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        
        [mes show];
        [self performSelector:@selector(stopRefresh) withObject:nil afterDelay:2.5];
        return;
    }
    
    
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
            
            AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
            delegate.DeviceGUID = DeviceGUID;
            delegate.isDeviceRegistered = @"YES";
            delegate.EmailAddress = _Email;

            [self performSelector:@selector(stopRefresh) withObject:nil afterDelay:2.5];
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

- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
{
//    NSPredicate *resultPredicate = [NSPredicate
//                                    predicateWithFormat:@"CreatedByUserName contains[cd] %@",
//                                    searchText];
//
    NSString *nameFilter = [NSString stringWithFormat:@"%@*", searchText];
    NSString *desFilter = [NSString stringWithFormat:@"*%@*", searchText];
    
    NSPredicate *resultPredicate = [NSPredicate
                                    predicateWithFormat:@"(CreatedByUserName LIKE [cd]%@) or (HiritMessage LIKE [cd] %@)",
                                    nameFilter, desFilter];

    
    myObjectSearch = [myObject filteredArrayUsingPredicate:resultPredicate];
}

-(BOOL)searchDisplayController:(UISearchDisplayController *)controller
shouldReloadTableForSearchString:(NSString *)searchString
{
    [self filterContentForSearchText:searchString
                               scope:[[self.searchDisplayController.searchBar scopeButtonTitles]
                                      objectAtIndex:[self.searchDisplayController.searchBar
                                                     selectedScopeButtonIndex]]];
    
    return YES;
}
@end
