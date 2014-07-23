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
    NSMutableDictionary *mutDictionary;
    // A dictionary object
    NSDictionary *dictionary;
    NSCountedSet *countedSet;
    NSMutableArray *arrayGroup;
    NSMutableArray *arrayGroupSearch;
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
    //return 1;
    
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        
        return [arrayGroupSearch count];
        
    } else {
        
        return [arrayGroup count];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //return myObject.count  ;
    
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        
        //return myObjectSearch.count;
        
        NSString *nameFilter = [NSString stringWithFormat:@"%@*", [arrayGroupSearch objectAtIndex:section]];
        
        
        NSPredicate *resultPredicate = [NSPredicate
                                        predicateWithFormat:@"(CreatedByUserName LIKE [cd]%@)",
                                        nameFilter];
        
        
        return [[myObjectSearch filteredArrayUsingPredicate:resultPredicate] count] ;

    } else {
        
        //return myObject.count;
    
    
        NSString *nameFilter = [NSString stringWithFormat:@"%@*", [arrayGroup objectAtIndex:section]];
        
        
        NSPredicate *resultPredicate = [NSPredicate
                                        predicateWithFormat:@"(CreatedByUserName LIKE [cd]%@)",
                                        nameFilter];
        
       
        return [[myObject filteredArrayUsingPredicate:resultPredicate] count] ;

    
    }
    
    
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{

    if (tableView == self.searchDisplayController.searchResultsTableView) {
        return  [arrayGroupSearch objectAtIndex:section];
    }
    else
    {
        return  [arrayGroup objectAtIndex:section];
    }
    
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    


 
    if (isConnectionOK == true) {
        
        NSDictionary *tmpDict = nil;

        if (tableView == self.searchDisplayController.searchResultsTableView) {
            
            
            NSString *nameFilter = [NSString stringWithFormat:@"%@*", [arrayGroupSearch objectAtIndex:indexPath.section]];
            
            
            NSPredicate *resultPredicate = [NSPredicate
                                            predicateWithFormat:@"(CreatedByUserName LIKE [cd]%@)",
                                            nameFilter];
            
            // NSLog(@"numberOfRowsInSection %lu",(unsigned long)[[myObject filteredArrayUsingPredicate:resultPredicate] count]);
            tmpDict =  [[myObjectSearch filteredArrayUsingPredicate:resultPredicate] objectAtIndex:indexPath.row ] ;
            

            
            
            //tmpDict = [myObjectSearch objectAtIndex:indexPath.row];
            
        } else {
            
            
            NSString *nameFilter = [NSString stringWithFormat:@"%@*", [arrayGroup objectAtIndex:indexPath.section]];
            
            
            NSPredicate *resultPredicate = [NSPredicate
                                            predicateWithFormat:@"(CreatedByUserName LIKE [cd]%@)",
                                            nameFilter];
            
            // NSLog(@"numberOfRowsInSection %lu",(unsigned long)[[myObject filteredArrayUsingPredicate:resultPredicate] count]);
            tmpDict =  [[myObject filteredArrayUsingPredicate:resultPredicate] objectAtIndex:indexPath.row ] ;

            
            
//            tmpDict = [myObject objectAtIndex:indexPath.row];
//            NSLog(@"tmpDict ---> %@",tmpDict);

        }
        
         NSLog(@"isection %ld",(long)indexPath.section);
        NSLog(@"Item0 %@",[tmpDict objectForKey:@"CreatedByUserName"]);
        NSLog(@"Item1 %@",[arrayGroup objectAtIndex:indexPath.section]);
        
       // if ([tmpDict objectForKey:@"CreatedByUserName"] == [arrayGroup objectAtIndex:indexPath.section]) {
            
            cell.textLabel.text = [tmpDict objectForKey:@"HiritMessage"];
            cell.detailTextLabel.text =[NSString stringWithFormat:@"Created By %@",[tmpDict objectForKey:@"CreatedByUserName"]] ;

            
       // }
       //// else
       // {
       //     cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
      //  }
    
        
      
        
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
        
        NSString *messageGUID = @"";//   [NSString stringWithFormat:@"%@",[[myObject objectAtIndex:path.row] objectForKey:@"MessageGUID"]];
        NSString *hiritMessage = @"";// [NSString stringWithFormat:@"%@",[[myObject objectAtIndex:path.row] objectForKey:@"HiritMessage"]];
        NSString *createdBy = @"";//[NSString stringWithFormat:@"%@",[[myObject objectAtIndex:path.row] objectForKey:@"CreatedBy"]];
        NSString *answer1 = @"";//[NSString stringWithFormat:@"%@",[[myObject objectAtIndex:path.row] objectForKey:@"Answer"]];
        
        
        NSDictionary *tmpDict = nil;

        
        if ([self.searchDisplayController isActive]) {
            
            path = [self.searchDisplayController.searchResultsTableView indexPathForSelectedRow];
            
            NSString *nameFilter = [NSString stringWithFormat:@"%@*", [arrayGroupSearch objectAtIndex:path.section]];
            
            
            NSPredicate *resultPredicate = [NSPredicate
                                            predicateWithFormat:@"(CreatedByUserName LIKE [cd]%@)",
                                            nameFilter];
            
            tmpDict =  [[myObjectSearch filteredArrayUsingPredicate:resultPredicate] objectAtIndex:path.row ] ;
            
            
//            
//            
//            
//            messageGUID = [NSString stringWithFormat:@"%@",[[myObjectSearch objectAtIndex:path.row] objectForKey:@"MessageGUID"]];
//            hiritMessage = [NSString stringWithFormat:@"%@",[[myObjectSearch objectAtIndex:path.row] objectForKey:@"HiritMessage"]];
//            createdBy = [NSString stringWithFormat:@"%@",[[myObjectSearch objectAtIndex:path.row] objectForKey:@"CreatedBy"]];
//            answer1 = [NSString stringWithFormat:@"%@",[[myObjectSearch objectAtIndex:path.row] objectForKey:@"Answer"]];
            
        }
        else
        {
            
            NSString *nameFilter = [NSString stringWithFormat:@"%@*", [arrayGroup objectAtIndex:path.section]];
            
            
            NSPredicate *resultPredicate = [NSPredicate
                                            predicateWithFormat:@"(CreatedByUserName LIKE [cd]%@)",
                                            nameFilter];
            
            tmpDict =  [[myObject filteredArrayUsingPredicate:resultPredicate] objectAtIndex:path.row ] ;
            
            
            
        }
        
        messageGUID = [NSString stringWithFormat:@"%@",[tmpDict objectForKey:@"MessageGUID"]];
        hiritMessage = [NSString stringWithFormat:@"%@",[tmpDict objectForKey:@"HiritMessage"]];
        createdBy = [NSString stringWithFormat:@"%@",[tmpDict objectForKey:@"CreatedBy"]];
        answer1 = [NSString stringWithFormat:@"%@",[tmpDict objectForKey:@"Answer"]];

        
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
    NSData *jsonSource = [NSData dataWithContentsOfURL:[NSURL URLWithString:x]];
    
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
    
    countedSet = [NSCountedSet set];
    
    for (NSDictionary *dataDict in jsonObjects) {
        NSString *messageGUID = [dataDict objectForKey:@"MessageGUID"];
        NSString *hiritMessage = [dataDict objectForKey:@"HiritMessage"];
        NSString *createdByUserName = [dataDict objectForKey:@"CreatedByUserName"];
        NSString *createdByDeviceID = [dataDict objectForKey:@"CreatedByDeviceID"];
        NSString *createdDate = [dataDict objectForKey:@"CreatedDate"];
        NSString *answer1 = [dataDict objectForKey:@"Answer1"];
        
//        NSLog(@"MessageGUID: %@",messageGUID);
//        NSLog(@"Message: %@",hiritMessage);
//        NSLog(@"CreatedByUserName: %@",createdByUserName);
//        NSLog(@"CreatedByDeviceID: %@",createdByDeviceID);
//        NSLog(@"CreatedDate: %@",createdDate);
        
        dictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                      messageGUID, MessageGUID,
                      hiritMessage, HiritMessage,
                      createdByUserName,CreatedByUserName,
                      createdByDeviceID,CreatedByDeviceID,
                      [self mfDateFromDotNetJSONString:createdDate], @"DateCreated",
                      answer1, Answer1,
                      nil];
        [myObject addObject:dictionary];
        
        [countedSet addObject:createdByUserName];
        
        
    }
    
    arrayGroup = [[NSMutableArray alloc]init];
    
    
    for (NSString *s in countedSet) {
        [arrayGroup addObject:s];
    }
    
    [self getJsonData];
    
    
}


-(void)getJsonData
{
    NSString *uniqueIdentifier = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    
    DeviceGUID = uniqueIdentifier;
    
    CommonFunction *common = [[CommonFunction alloc]init];
    
    NSString *url =[common GetJsonConnection:[NSString stringWithFormat:@"GetUserByDeviceID/%@",DeviceGUID]];
    
    NSData *allCoursesData = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:url]];
    
    if ([common CheckNSD:allCoursesData] == false) {
        
        UIAlertView* mes=[[UIAlertView alloc] initWithTitle:@"Connection Error"
                                                    message:@"Connection error" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        
        [mes show];
        [self performSelector:@selector(stopRefresh) withObject:nil afterDelay:2.5];
        return;
    }
    
    
    NSError *error;
    NSMutableDictionary *allHirit= [NSJSONSerialization JSONObjectWithData:allCoursesData options:NSJSONReadingMutableContainers error:&error];
    
    if (error) {
        NSLog(@"%@",[error localizedDescription]);
    }
    else {
        for (NSDictionary *dic in allHirit )
        {
            NSLog(@"Checking if device is already registered with device id %@", DeviceGUID);
            
            self.DeviceGUID = dic[@"DeviceGUID"];
            self.Email = dic[@"Email"];
            self.PhoneNumber = dic[@"PhoneNumber"];
            self.IsDeviceActivated = dic[@"isDeviceActivated"];
            
        }
        
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Storyboard" bundle:nil];
        
        if ([_IsDeviceActivated isEqualToString:@"NO"]) {
            DeviceActivationViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"acid"];
            [vc setModalPresentationStyle:UIModalPresentationFullScreen];
            vc.deviceGUID = DeviceGUID;
            vc.emailAddress = self.Email;
            
            [self presentViewController:vc animated:YES completion:nil];
        }
        else if ([self.IsDeviceActivated isEqualToString:@"YES"])
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

/*
 #pragma mark - Filter
 */
// Search Filter
- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
{

    NSString *nameFilter = [NSString stringWithFormat:@"%@*", searchText];
    NSString *desFilter = [NSString stringWithFormat:@"*%@*", searchText];
    
    NSPredicate *resultPredicate = [NSPredicate
                                    predicateWithFormat:@"(CreatedByUserName LIKE [cd]%@) or (HiritMessage LIKE [cd] %@)",
                                    nameFilter, desFilter];

    myObjectSearch = [myObject filteredArrayUsingPredicate:resultPredicate];
    
    
    [countedSet removeAllObjects];
    for (NSDictionary *dic in myObjectSearch) {
        [countedSet addObject:[dic objectForKey:@"CreatedByUserName"]];
    }
    
    arrayGroupSearch = [[NSMutableArray alloc]init];
    
    
    
    
    for (NSString *s in countedSet) {
        [arrayGroupSearch addObject:s];
    }
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
