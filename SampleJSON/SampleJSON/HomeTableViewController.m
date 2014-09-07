//
//  HomeTableViewController.m
//  SampleJSON
//
//  Created by Archie Angeles on 7/7/14.
//  Copyright (c) 2014 PachieOrg. All rights reserved.
//

#import "HomeTableViewController.h"
//#import "TestViewController.h"
//#import "DeviceActivationViewController.h"
//#import "MessageDetailViewController.h"
#import "MessageDetail2TableViewController.h"
#import "CommonFunction.h"
#import "AppDelegate.h"
#import "CustomLoader.h"
#import "PhoneBookTableViewController.h"
#import "CommonSendRequest.h"
#import "PickupLineTableViewCell.h"



@interface HomeTableViewController ()
{
    dispatch_queue_t myQueue;
    
    NSMutableArray *myObject;
    NSArray *myObjectSearch;
    NSMutableDictionary *mutDictionary;

    NSDictionary *dictionary;
    NSCountedSet *countedSet;
    NSMutableArray *arrayGroup;
    NSMutableArray *arrayGroupSearch;
    
    bool isConnectionOK;
    CustomLoader *customLoader;
    AppDelegate *delegate;
    CommonSendRequest *comReq;
    
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





-(void)doneButtonPressed:(id)sender
{
    UIAlertView* mes=[[UIAlertView alloc] initWithTitle:@"Pickup Lines"
                                                message:@"Sorry function not yet ready" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
    
    [mes show];
    
}

- (void)viewDidLoad
{

    [self.tableView registerNib:[UINib nibWithNibName:@"PickupLine" bundle:nil] forCellReuseIdentifier:@"Cell"];
    
    comReq = [[CommonSendRequest alloc]init];
    delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    customLoader = [[CustomLoader alloc]init];
    
    [customLoader InitializeLoader:self];

//    UIRefreshControl *refresh = [[UIRefreshControl alloc] init];
//    
//    refresh.attributedTitle = [[NSAttributedString alloc] initWithString:@"Pull to Refresh"];
//    
//    [refresh addTarget:self action:@selector(LoadTable)forControlEvents:UIControlEventValueChanged];
//    
   
    //self.refreshControl = [CommonFunction CommonRefreshControl:@selector(LoadTable):self];
    
    self.tableView.sectionHeaderHeight = 52;
    
    
    
    
    self.refreshControl = [CommonFunction CommonRefreshControl:@selector(LoadTable) Controller:self];
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = TRUE;
    
    //UINavigationController *navCon  = (UINavigationController*) [self.navigationController.viewControllers objectAtIndex:0];
    //navCon.navigationItem.title = @"Loading...";
    
    
    customLoader.label.text = @"Loading...";
    //        [customLoader.xview addSubview:customLoader.spinner];
    //        [customLoader.xview addSubview:customLoader.label];
    //        [customLoader.xview bringSubviewToFront:customLoader.spinner];
    [self.view addSubview:customLoader.xview];
    
    [self.view addSubview:customLoader.spinner];
    [self.view addSubview:customLoader.label];
    
    [customLoader.spinner startAnimating];

    if (!myQueue) {
        myQueue = dispatch_queue_create("com.samplejson", NULL);
    }
    
    dispatch_async(myQueue, ^{
        
        [self LoadTable];
        
    });
    

   

    
}



- (void)stopRefresh

{
   // dispatch_async(dispatch_get_main_queue(), ^{
//        if (isConnectionOK==true) {
//            [self.tableView reloadData];
//        }
        [self.refreshControl endRefreshing];
    //});
    
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    if (tableView == self.searchDisplayController.searchResultsTableView)
    {
       return [arrayGroupSearch count];
        
    } else {
        
        return [arrayGroup count];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    if (tableView == self.searchDisplayController.searchResultsTableView) {

        NSString *nameFilter = [NSString stringWithFormat:@"%@*", [arrayGroupSearch objectAtIndex:section]];
        NSPredicate *resultPredicate = [NSPredicate predicateWithFormat:@"(DateCreatedSTR LIKE [cd]%@)",nameFilter];
        return [[myObjectSearch filteredArrayUsingPredicate:resultPredicate] count] ;

    } else {
        
        NSString *nameFilter = [NSString stringWithFormat:@"%@*", [arrayGroup objectAtIndex:section]];
        NSPredicate *resultPredicate = [NSPredicate predicateWithFormat:@"(DateCreatedSTR LIKE [cd]%@)", nameFilter];
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


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return  70;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    PickupLineTableViewCell *cell = (PickupLineTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil)
    {
        //cell = [[PickupLineTableViewCell alloc] initWithStyle:uita reuseIdentifier:CellIdentifier];
        
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"PickupLine" owner:self options:nil];
        cell = (PickupLineTableViewCell *) [nib objectAtIndex:0];

    }
    

    //if (isConnectionOK == true) {
        
        NSDictionary *tmpDict = nil;

        if (tableView == self.searchDisplayController.searchResultsTableView) {
        
            NSString *nameFilter = [NSString stringWithFormat:@"%@*", [arrayGroupSearch objectAtIndex:indexPath.section]];
        
            NSPredicate *resultPredicate = [NSPredicate predicateWithFormat:@"(DateCreatedSTR LIKE [cd]%@)",nameFilter];

            tmpDict =  [[myObjectSearch filteredArrayUsingPredicate:resultPredicate] objectAtIndex:indexPath.row ] ;

            
        } else {
            
            
            NSString *nameFilter = [NSString stringWithFormat:@"%@*", [arrayGroup objectAtIndex:indexPath.section]];
            NSPredicate *resultPredicate = [NSPredicate predicateWithFormat:@"(DateCreatedSTR LIKE [cd]%@)",nameFilter];
            tmpDict =  [[myObject filteredArrayUsingPredicate:resultPredicate] objectAtIndex:indexPath.row ] ;
        }
        
//            cell.textLabel.text = [tmpDict objectForKey:@"HiritMessage"];
//            cell.detailTextLabel.text =[NSString stringWithFormat:@"Created By %@",[tmpDict objectForKey:@"CreatedByUserName"]] ;
//
    

    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd MMM yyyy"];
    NSString *xdate = [dateFormatter stringFromDate:[tmpDict objectForKey:@"DateCreated"]];
    
    
    
            cell.lblPickupLine.text =[tmpDict objectForKey:@"HiritMessage"];
            cell.lblSubmitted.text = [NSString stringWithFormat:@"By %@ - %@",[tmpDict objectForKey:@"CreatedByUserName"], xdate] ;
            cell.lblPoints.text = @"Points 100";
    
    
    
    cell.imgUserImage.image =  [UIImage imageNamed:@"noprofile.png"];
    
    
    // download the image asynchronously
    
    NSString *userImage = [CommonFunction ProfieImageURLByPhone:[tmpDict objectForKey:@"CreatedByPhonNumber"]];
    
    //NSLog(@"userimage %@",userImage);
    
    [comReq downloadImageWithURL:[NSURL URLWithString:userImage] completionBlock:^(BOOL succeeded, UIImage *image) {
        if (succeeded) {
            
            if (image != nil) {
                
                cell.imgUserImage.image= image;
                [CommonFunction applyRoundBorderToImage:cell.imgUserImage];

            
            }
            else
            {
                cell.imageView.alpha = 0.4;
            }
        
        }
        
    }];
    
    
   // }
    
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 52;
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section
{
    
    

    view.tintColor = [UIColor purpleColor];
    UITableViewHeaderFooterView *header = (UITableViewHeaderFooterView *)view;
    [header.textLabel setTextColor:[UIColor whiteColor]];
    
    view.layer.cornerRadius = view.frame.size.height / 2;
    view.layer.masksToBounds = YES;
    
    view.alpha  = 0.8;
    view.layer.borderColor = [UIColor whiteColor].CGColor;
    view.layer.borderWidth = 10;
    
    
    [header.textLabel setTextAlignment:NSTextAlignmentCenter];
    
    
    //button.alpha = 0.6;
    

}



/*
#pragma mark - Navigation
*/
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
  
    if ([segue.identifier isEqualToString:@"MessageDetail"]) {
              
        NSIndexPath *path = [self.tableView indexPathForSelectedRow];
        
        MessageDetail2TableViewController *dv = segue.destinationViewController;
        
        NSString *messageGUID = @"";
        NSString *hiritMessage = @"";
        NSString *createdBy = @"";
        NSString *answer1 = @"";
        NSString *answer2 = @"";
        NSString *answer3 = @"";
        
        
        dv.sendMessageDelegate = self;
        
        NSDictionary *tmpDict = nil;

        
        if ([self.searchDisplayController isActive]) {
            
            path = [self.searchDisplayController.searchResultsTableView indexPathForSelectedRow];
            
            NSString *nameFilter = [NSString stringWithFormat:@"%@*", [arrayGroupSearch objectAtIndex:path.section]];
            
            NSPredicate *resultPredicate = [NSPredicate
                                            predicateWithFormat:@"(DateCreatedSTR LIKE [cd]%@)",
                                            nameFilter];
            
            tmpDict =  [[myObjectSearch filteredArrayUsingPredicate:resultPredicate] objectAtIndex:path.row ] ;
   
            
        }
        else
        {
            
            NSString *nameFilter = [NSString stringWithFormat:@"%@*", [arrayGroup objectAtIndex:path.section]];
            
            NSPredicate *resultPredicate = [NSPredicate
                                            predicateWithFormat:@"(DateCreatedSTR LIKE [cd]%@)",
                                            nameFilter];
            
            tmpDict =  [[myObject filteredArrayUsingPredicate:resultPredicate] objectAtIndex:path.row ] ;
        
            
        }
        
        messageGUID = [NSString stringWithFormat:@"%@",[tmpDict objectForKey:@"MessageGUID"]];
        hiritMessage = [NSString stringWithFormat:@"%@",[tmpDict objectForKey:@"HiritMessage"]];
        createdBy = [NSString stringWithFormat:@"%@",[tmpDict objectForKey:@"CreatedBy"]];
        answer1 = [NSString stringWithFormat:@"%@",[tmpDict objectForKey:@"Answer1"]];
        answer2 = [NSString stringWithFormat:@"%@",[tmpDict objectForKey:@"Answer2"]];
        answer3 = [NSString stringWithFormat:@"%@",[tmpDict objectForKey:@"Answer3"]];


        dv.MessageGUID = messageGUID;
        dv.HiritMessage = hiritMessage;
        dv.CreatedBy = createdBy;
        dv.Answer = answer1;
        dv.Answer22 = answer2;
        dv.Answer33 = answer3;
        dv.createdByPhoneNumber = [tmpDict objectForKey:@"CreatedByPhonNumber"];
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //if (tableView == self.searchDisplayController.searchResultsTableView) {
        [self performSegueWithIdentifier: @"MessageDetail" sender: nil];
    //}
    
    
    
}


- (IBAction)Join:(id)sender {
    UIAlertView* mes=[[UIAlertView alloc] initWithTitle:@"Pickup Lines"
                                                message:@"Sorry function not yet ready" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
    
    [mes show];
}

-(void)LoadTable
{
    myObject = [[NSMutableArray alloc] init];

    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        CommonSendRequest *comreq = [[CommonSendRequest alloc]init];
        [comreq getJSONPickupLines:^(NSDictionary *jsonData, NSError *er) {
            
            if (er == nil) {
                
                [comreq ConvertJsonToArrary:jsonData withBlock:^(NSMutableArray *jsonData1)
                 {
                     [myObject addObjectsFromArray:jsonData1];
                     
                    // NSLog(@"myObject %@ ",myObject);
                     
                     countedSet = [NSCountedSet set];
                     
                     for (NSDictionary *x in myObject) {
                         [countedSet addObject:[x objectForKey:@"DateCreatedSTR"]];
                         //NSLog(@"%@",[x objectForKey:@"DateCreatedSTR"]);
                     }
                     
                     arrayGroup = [self SortObjects:arrayGroup CountedOjbect:countedSet];
                     [self performSelector:@selector(stopRefresh) withObject:nil afterDelay:2.5];
                     
                     [self performSelector:@selector(releadreload) withObject:nil];
                     
                     
                     
                     
                 }];
            }
            else
            {
                [self performSelector:@selector(stopRefresh) withObject:nil afterDelay:2.5];
                
                [self performSelector:@selector(releadreload) withObject:nil];
                
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Network Error" message:@"Unable to connect to Pickup Line server" delegate:nil cancelButtonTitle:@"Close" otherButtonTitles: nil];
                
                [alert show];
                
            }
            
            
            
            
        } ];
        
        
        
    });
    
    
    
}

-(void)releadreload
{
    
   // [self.tableView reloadData];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self HideLoading];
    });
    
}




-(void)HideLoading
{
    
    dispatch_async(dispatch_get_main_queue(),^{

    sleep(1);

    self.navigationItem.title = @"Home";
    [UIApplication sharedApplication].networkActivityIndicatorVisible = false ;
    
    [customLoader.spinner stopAnimating];
    
    for (UIView *subview in [self.view subviews]) {
        // Only remove the subviews with tag not equal to 1
        if (subview.tag == 1) {
            [subview removeFromSuperview];
        }
    }
        
        [self.tableView reloadData];
        
        
    });
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
    arrayGroupSearch = [[NSMutableArray alloc]init];
    
    countedSet = [NSCountedSet set];
    
    [countedSet removeAllObjects];
    for (NSDictionary *dic in myObjectSearch) {
        [countedSet addObject:[dic objectForKey:@"DateCreatedSTR"]];
    }
    
    //arrayGroupSearch = [[NSMutableArray alloc]init];
    
    
    
    
    for (NSString *s in countedSet) {
        [arrayGroupSearch addObject:s];
    }
    
    
    if (![countedSet count] ==0 ) {
        arrayGroupSearch = [self SortObjects:arrayGroupSearch CountedOjbect:countedSet];
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


-(NSMutableArray *) SortObjects:(NSMutableArray *)ArraryToSort CountedOjbect:(NSCountedSet *) countedset;
{
    ArraryToSort = [[NSMutableArray alloc]init];
    
    for (NSString *s in countedset ) {
        [ArraryToSort addObject:s];
    }
    
    countedset = [NSCountedSet setWithArray:ArraryToSort];
    
    NSCountedSet *totalSet = [NSCountedSet setWithArray:ArraryToSort];
    NSMutableArray *dictArray = [NSMutableArray array];
    for (NSNumber *num in totalSet) {
        NSDictionary *dict = @{@"number":num, @"count":@([totalSet countForObject:num])};
        [dictArray addObject:dict];
    }
    NSArray *final = [dictArray sortedArrayUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"number" ascending:YES ]]];
    //NSLog(@"%@",final);
    
    [ArraryToSort removeAllObjects];
    
    
    for (int i=0; i <= [final count] - 1 ; i++) {
        
        NSDictionary *dict2 = [final objectAtIndex:i];
        
        [ArraryToSort addObject:[dict2 objectForKey:@"number"]];
    }
    
    return ArraryToSort;
    

}


-(void)sendMessageToSelectedPerson:(EntityPerson *)selectedPerson MessageGUID:(NSString *)messageGUID selectedAnswer:(NSString *)selectedAnswer
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
    });
    
    //AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    if ([selectedPerson.Number isEqualToString:@""] || [selectedPerson.Number isEqualToString:@""])
    {
        UIAlertView* mes=[[UIAlertView alloc] initWithTitle:@"Invalid Input"
                                                    message:@"Phone number required" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        
        [mes show];
        return;
    }
    
    CommonSendRequest *sendRequest = [[CommonSendRequest alloc]init];
    [sendRequest SendPickupLines:delegate.DevinceToken :selectedPerson.Number :messageGUID selectedAnswer:selectedAnswer ];

}

-(void)alertView:(UIAlertView *)alertView willDismissWithButtonIndex:    (NSInteger)buttonIndex
{
    if(buttonIndex==0)
    {
        //Code that will run after you press ok button
        //[self.navigationController popViewControllerAnimated:YES ];
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}

@end
