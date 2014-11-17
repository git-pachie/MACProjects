//
//  RemittanceTableViewController.m
//  ToPeso
//
//  Created by pachie on 12/9/14.
//  Copyright (c) 2014 Private. All rights reserved.
//

#import "RemittanceTableViewController.h"
#import "com_pachie_topesoAppDelegate.h"
#import "CustomTableViewCell.h"
#import "Remittance.h"
#import "AgentDetailsTableViewController.h"
#import "CoreDataToPeso.h"
#import "SendAndRequest.h"
#import "CommonAddMob.h"
#import "CommonFunction.h"



@interface RemittanceTableViewController ()

{
    com_pachie_topesoAppDelegate *del;
    UIRefreshControl *refreshControl;
    UIActivityIndicatorView *spinner;
    dispatch_queue_t que;
    //UIView *abView;
    commonAddMob *_commonBanner;
    //UISegmentedControl *segmentedControl;
    
    NSFetchedResultsController *_fetchedHighest;
    NSFetchedResultsController *_fetchedRecent;
    UIView *xView;
    
}

@end

@implementation RemittanceTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    //UIView *xView = [[UIView alloc]init];
    _commonBanner = [[commonAddMob alloc]init];
    self.labelHeader.hidden = true;
    self.labelHeader.layer.cornerRadius = 4;
    self.labelHeader.clipsToBounds = YES;
    
    self.interstitial = [self createAndLoadInterstitial];
    
//    del = (com_pachie_topesoAppDelegate *)[[UIApplication sharedApplication]delegate];
//    
//    NSError *error;
//    if (![[self fetched] performFetch:&error]) {
//        // Update to handle the error appropriately.
//        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
//        exit(-1);  // Fail
//    }
    
    
    
    refreshControl = [[UIRefreshControl alloc]init];
    
    [self.tableView addSubview:refreshControl];
    
    [refreshControl addTarget:self action:@selector(refreshTable) forControlEvents:UIControlEventValueChanged];
    
    
    if (!que) {
        que = dispatch_queue_create("loadingque", NULL);
    }
    
    del = (com_pachie_topesoAppDelegate *)[[UIApplication sharedApplication]delegate];
    
    dispatch_async(que, ^{
        
        
        [self showHideLoadingBar:true];
        

    });
    
    
    [self refreshTable];
    

    
    //abView = [commonAddMob ImplementBanerBottom:self];
    //[self.view addSubview:[_commonBanner ImplementBanerBottom:self]];
    
 //   [self.tableView setContentInset:UIEdgeInsetsMake(60, 0, 0, 0)];
    
//    segmentedControl = [[UISegmentedControl alloc]initWithItems:[NSArray arrayWithObjects:@"Highest to Lowest", @"Most Recent Update", nil]];
//    segmentedControl.frame = CGRectMake(((segmentedControl.frame.size.width)/2)- 130 , 20, (self.view.bounds.size.width) - 20 , 34);
//
    
    [self.tableView registerNib:[UINib nibWithNibName:@"View" bundle:nil] forCellReuseIdentifier:@"Cell"];

    
    UIColor *selectedColor = [UIColor colorWithRed: 98/255.0 green:156/255.0 blue:247/255.0 alpha:1.0];
    UIColor *deselectedColor = [UIColor colorWithRed: 54/255.0 green:52/255.0 blue:48/255.0 alpha:1.0];
    
    for (UIControl *subview in [self.segmentOutlet subviews]) {
        if ([subview isSelected])
            [subview setTintColor:selectedColor];
        else
            [subview setTintColor:deselectedColor];
    }

    
    

}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    UIBarButtonItem *shareButton = [[UIBarButtonItem alloc]
                                    initWithBarButtonSystemItem:UIBarButtonSystemItemAction
                                    target:self
                                    action:@selector(shareAction:)];
    self.navigationItem.rightBarButtonItem = shareButton;
}


-(void)actionSheet:(UIActionSheet *)popup clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (popup.tag == 1) {
        if (buttonIndex == 0) {
            NSLog(@"You click facebook");
            [self shareToSocial:@"facebook"];
        }
        else if (buttonIndex == 1)
        {
            NSLog(@"You click twitter");
            [self shareToSocial:@"twitter"];
        }
        else if (buttonIndex == 2)
        {
            NSLog(@"You click mail");
            [self shareToSocial:@"email"];
            
        }
        else if (buttonIndex==3)
        {
            NSLog(@"You calick camera roll");
            [self shareToSocial:@"gallery"];
        }
        else
        {
            NSLog(@"You click default cancel");
        }
    }
    
}

-(void)shareAction:(id)sender
{
    UIActionSheet *pop= [[UIActionSheet alloc]initWithTitle:@"You can Share or Save to Camera Roll the current remittance rate by choosing one of the options below" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Facebook"
    ,@"Twitter"
    ,@"Email"
    ,@"Save to Camera Roll"
    ,@"Rate this app", nil];
    
    
    pop.tag = 1;
    [pop showInView:[UIApplication sharedApplication].keyWindow];
    
    return;
    
    
    
    
    
//    UIAlertController *controller = [UIAlertController alertControllerWithTitle: @"Share or Save"
//                                                                        message: @"You can share or save the current remittance rate by choosing one of the options below"
//                                                                 preferredStyle: UIAlertControllerStyleAlert];
//    
//    
//    
//    UIAlertAction *alertFacebook = [UIAlertAction actionWithTitle: @"Facebook" style: UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
//        NSLog(@"Facebook");
//        [self shareToSocial:@"facebook"];
//    }];
//    
//    
//    [controller addAction: alertFacebook];
//    
//    UIAlertAction *alertTwitter = [UIAlertAction actionWithTitle: @"Twitter" style: UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
//        NSLog(@"Twitter");
//        [self shareToSocial:@"twitter"];
//    }];
//    [controller addAction: alertTwitter];
//    
//    UIAlertAction *alertEmail = [UIAlertAction actionWithTitle: @"Email" style: UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
//        NSLog(@"Email");
//        [self shareToSocial:@"email"];
//    }];
//    [controller addAction: alertEmail];
//    
//    UIAlertAction *alertGallery = [UIAlertAction actionWithTitle: @"Save to Gallery" style: UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
//        NSLog(@"Save to gallery");
//        [self shareToSocial:@"gallery"];
//    }];
//    [controller addAction: alertGallery];
//    
//    
//    
//    UIAlertAction *alertAction = [UIAlertAction actionWithTitle: @"Cancel"
//                                                          style: UIAlertActionStyleDestructive
//                                                        handler: ^(UIAlertAction *action) {
//                                                            NSLog(@"Dismiss button tapped!");
//                                                        }];
//    [controller addAction: alertAction];
//
//    
//    [self presentViewController: controller animated: YES completion: nil];
}

//-(void)changeSegment
//{
//    NSLog(@"Segment %ld",(long)segmentedControl.selectedSegmentIndex);
//    
//    if (segmentedControl.selectedSegmentIndex==0) {
//        self.fetched = [self fetchedHighest];
//    }
//    else
//    {
//        self.fetched = [self fetchedRecent];
//    }
//    
//    NSError *error;
//    if (![self.fetched performFetch:&error]) {
//        // Update to handle the error appropriately.
//        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
//        exit(-1);  // Fail
//    }
//
//    [self.tableView reloadData];
//    
//    //[self refreshTable];
//}

//- (void)scrollViewDidScroll:(UIScrollView *)scrollView
//{
//    if (!self.isFromNotification) {
//        
//        xView = [_commonBanner ImplementBanerBottom:self];
//        
//        
//        CGRect fixedFrame = xView.frame;
//        fixedFrame.origin.y = 0 + scrollView.contentOffset.y + 64;
//        xView.frame = fixedFrame;
//
//    }
//    else
//    {
//        self.isFromNotification = false;
//    }
//    
//}

-(void)showHideLoadingBar :(BOOL)isShow
{
    dispatch_async(dispatch_get_main_queue(), ^{
        
    if (isShow == true) {
        spinner = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        
        CGRect loadingSize = CGRectMake((self.view.bounds.size.width-120)/2, (self.view.bounds.size.height-300) / 2, 120, 100);
        
        spinner.frame = loadingSize;
        spinner.tag = 12;
        [spinner startAnimating];
        
        UIView *shaddow = [[UIView alloc]initWithFrame:loadingSize];
        [shaddow setBackgroundColor:[UIColor blackColor]];
        [shaddow.layer setOpacity:0.5];
        shaddow.layer.cornerRadius = 10;
        shaddow.tag = 12;
        
        [self.view addSubview:shaddow];
        
        [self.view addSubview:spinner];
        [self.view bringSubviewToFront:spinner];
        
    }
    else{
        
        dispatch_async(que, ^{
            
            sleep(2);
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [spinner stopAnimating];
                [[self.view viewWithTag:12] removeFromSuperview];
                
            });
            
            

        });
        
        
    }
    
        
    });
    
    
}

-(void)refreshTable
{
    
    
        CoreDataToPeso *core = [[CoreDataToPeso alloc]init];
        //[core insertTempData];
        SendAndRequest *send = [[SendAndRequest alloc]init];
        
        NSString *lastModified = [core getLastUpdatedAgent];
        
        
        
        [send getLastesAgent:lastModified withBlock:^(NSArray *array, NSError *connectionError)
         {
             
             
             if (connectionError!=nil) {
                 
                 UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Connection Error" message:@"Unable to connect to fetched latest updates" delegate:self cancelButtonTitle:@"Close" otherButtonTitles:nil];//, nil
                 
                 //[self showHideLoadingBar:false];
                 
                 dispatch_async(dispatch_get_main_queue(), ^{
                     
                     [self showHideLoadingBar:false];
                     
                 });
                 
                 [alert show];
                 
             }
             else
             {
                 //image
                 
                 for (NSDictionary *dic in array) {
                     NSString *strImg = [dic objectForKey:@"logo"];
                     NSString *strURL = [NSString stringWithFormat:@"%@%@",[SendAndRequest UrlImageConnection],strImg];
                     
                     [send downloadImageWithURL:[NSURL URLWithString:strURL] completionBlock:^(BOOL succeeded, UIImage *image) {
                         
                         //UIImage *im = image;
                         
                         if (image != nil)
                         {
                             
                             NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
                             NSString *documentsDirectory = [paths objectAtIndex:0];
                             NSString *path = [documentsDirectory stringByAppendingPathComponent:strImg];
                             NSData *data = UIImagePNGRepresentation(image);
                             [data writeToFile:path atomically:YES];
                             
                         }
                         
                     }];
                 }
                 
                 
             }
             
             [core syncCoreDataAgent:array];
             
             NSError *error;
             if (![self.fetched performFetch:&error]) {
                 // Update to handle the error appropriately.
                 NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
                 exit(-1);  // Fail
             }
             else
             {
                 
             }
             
             [self showHideLoadingBar:false];
             
             if (del.isFromNotification== true) {
                 
                 
                 [self performSelector:@selector(doSeg) withObject:nil afterDelay:3];
                 
                 
             }
             else
             {
                 //[self.view addSubview:[_commonBanner ImplementBanerBottom:self]];
                 [self performSelector:@selector(Done) withObject:nil afterDelay:1];
             }
             
             
             
             
             
         }];
        

    
}

-(void)doSeg
{
    [self performSegueWithIdentifier:@"agentDetails" sender:self];
}

-(void)Done
{
    [refreshControl endRefreshing];
    [self.tableView reloadData];
    
    if ([self.interstitial isReady]) {
        [self.interstitial presentFromRootViewController:self];
    }


}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    id sections = [self.fetched sections];
    
    return [sections count];
    
    //return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    id sections = [[self.fetched sections]objectAtIndex:section];
    
    return  [sections numberOfObjects];
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    id<NSFetchedResultsSectionInfo> sectionInfo = [[self.fetched sections]objectAtIndex:section];
    
    
    CoreDataToPeso *core = [[CoreDataToPeso alloc]init];
    
    Country *country = [core getCountryByCurrencyKey:[sectionInfo name]];
    
    
    NSString *headerText = [NSString stringWithFormat:@"%@, %@", country.countryName, [sectionInfo name]];
    
    
    return headerText;
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section
{
    
    
    
    //view.tintColor = [UIColor purpleColor];
    UITableViewHeaderFooterView *header = (UITableViewHeaderFooterView *)view;
    [header.textLabel setTextColor:[UIColor grayColor]];
    //[header.textLabel setFont:<#(UIFont *)#>]
    
    //view.layer.cornerRadius = view.frame.size.height / 2;
    //view.layer.masksToBounds = YES;
    
    view.alpha  = 0.9;
    //view.layer.borderColor = [UIColor whiteColor].CGColor;
    //view.layer.borderWidth = 10;
    
    
    [header.textLabel setTextAlignment:NSTextAlignmentCenter];
    
    
    //button.alpha = 0.6;
    
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CustomTableViewCell *cell = (CustomTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    
    if (cell == nil)
    {
        //cell = [[PickupLineTableViewCell alloc] initWithStyle:uita reuseIdentifier:CellIdentifier];
        
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"View" owner:self options:nil];
        cell = (CustomTableViewCell *) [nib objectAtIndex:0];
        
        
    }
    
//    
//    NSSet *unique = [NSSet setWithArray:[mArray valueForKey:@"CountryName"]];
//    
//    NSString *arUnique = [[unique allObjects] objectAtIndex:indexPath.section];
//    
//    NSArray *ar = [mArray filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"CountryName like [cd] %@",arUnique]];
//    
//    
//    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"CountryName" ascending:YES];
//    
//    NSArray * sortedArray=[ar sortedArrayUsingDescriptors:@[sort]];
    
    //    NSArray *sortedArray = [ar sortedArrayUsingComparator:^NSComparisonResult(NSString *p1, NSString *p2){
    //
    //        return [p1 compare:p2];
    //
    //    }];
    
    //NSArray * sortedArray = [ar sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    
    Remittance *rem = [self.fetched objectAtIndexPath:indexPath];
    
    
    
    cell.lblRemmitanceName.text = rem.remittanceName;
    
//    NSNumberFormatter *numberformatter = [[NSNumberFormatter alloc]init];
//    
//    [numberformatter setNumberStyle:NSNumberFormatterDecimalStyle];
//    
    
    NSNumberFormatter *numFormat = [[NSNumberFormatter alloc]init];
    [numFormat setNumberStyle:NSNumberFormatterDecimalStyle];
    [numFormat setMaximumFractionDigits:2];
    [numFormat setMinimumFractionDigits:2];
   
    
    
    
    NSString *str = [numFormat stringFromNumber:rem.rate];
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
    NSDateFormatter *timeFormat = [[NSDateFormatter alloc]init];
    
    [dateFormat setDateFormat:@"dd MMM yyy"];
    [timeFormat setDateFormat:@"hh:mm a"];
    
   
    //NSString *strTime = [timeFormat stringFromDate:rem.asofDate];
    
    

//    NSDateFormatter *format = [[NSDateFormatter alloc]init];
//    [format setDateFormat:@"hh:mm a"];
    
    NSTimeZone *gmt = [NSTimeZone timeZoneWithAbbreviation:@"GMT"];
    
    [dateFormat setTimeZone:gmt];
    [timeFormat setTimeZone:gmt];
    
     NSString *strDate = [dateFormat stringFromDate:rem.asofDate];
    cell.lblRate.text =[NSString stringWithFormat:@"%@ as of %@",str,strDate];
    
    
//    NSDateFormatter *dateFormate = [[NSDateFormatter alloc]init];
//    [dateFormate setDateFormat:@"dd MMMM yyyy hh:mm a"];
//    NSTimeZone *gmt = [NSTimeZone timeZoneWithAbbreviation:@"GMT"];
//    
//    [dateFormate setTimeZone:gmt];
//
//    self.lblAsOfDate.text =[NSString stringWithFormat:@"As of date %@",[dateFormate stringFromDate:self.remitanceAgent.asofDate]];

    
    
    
    
    cell.lbltime.text = [timeFormat stringFromDate:rem.asofDate];
    
    

    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                         NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString* path = [documentsDirectory stringByAppendingPathComponent:
                      [rem valueForKey:@"logo"]];
    UIImage* image = [UIImage imageWithContentsOfFile:path];

    
    
    if (image == nil) {
        image = [UIImage imageNamed:@"default.png"];
    }
    
    
    cell.imgRemittanceImage.image = image;
    cell.imgRemittanceImage.layer.cornerRadius = 6;
    cell.imgRemittanceImage.clipsToBounds = YES;
    cell.imgRemittanceImage.layer.borderWidth = .2;
    cell.imgRemittanceImage.layer.borderColor = [UIColor grayColor].CGColor;
    
    
    //cell.imgOver1.image = image;
    cell.imgOver1.layer.cornerRadius = 6;
    cell.imgOver1.clipsToBounds = YES;
    cell.imgOver1.layer.borderWidth = .2;
    cell.imgOver1.layer.borderColor = [UIColor grayColor].CGColor;
    [cell.imgOver1.layer setOpacity:.5];
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    [self imageRound:cell.imgRemittanceImage];
    
    //UIImageView *v = [[UIImageView alloc] initWithImage:image];
    
    //cell.imgRemittanceImage.image = [self imageRound:v].image;
    
    
    //find favorite
    
    BOOL isFav = [self isAgentFavoriteByGuid:rem.remmittanceGUID];
    
    if (isFav == true) {
        
        cell.imgOver1.hidden = false;
    }
    else
    {
        cell.imgOver1.hidden = true;
    }
    
    return cell;
                            
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"agentDetails" sender:self];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqual:@"agentDetails"]) {
        
        NSIndexPath *indexpath = [self.tableView indexPathForSelectedRow];
        
        
      AgentDetailsTableViewController *agent = (AgentDetailsTableViewController *) segue.destinationViewController;
        
    
        
        Remittance *rem = [self.fetched objectAtIndexPath:indexpath];
        
        if (del.isFromNotification== true) {
            
            rem = [self getAgentDetail:del.notifcationAgentID];
        }
        else
        {
            rem  = [self.fetched objectAtIndexPath:indexpath];
        }
        
        //AgentDetailsTableViewController *viewController = [[AgentDetailsTableViewController alloc] init];
        
        
        agent.remitanceAgent = rem;
        agent.country = self.country;
        
       // [self presentViewController:viewController animated:YES completion:nil];
        
        //[self presentViewController:agent animated:YES completion:nil];
        
        
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 54;
}

#pragma mark -fetched controller

- (NSFetchedResultsController *)fetchedHighest{
    
    if (_fetchedHighest) {
        return _fetchedHighest;
    }
        
        NSFetchRequest *request = [[NSFetchRequest alloc]init];
        
        NSEntityDescription *entity = [NSEntityDescription entityForName:@"Remittance" inManagedObjectContext:del.managedObjectContext];
        
        [request setEntity:entity];
        
        NSSortDescriptor *sort1 = [[NSSortDescriptor alloc]initWithKey:@"rate" ascending:NO];
        
        NSSortDescriptor *sort2 = [[NSSortDescriptor alloc]initWithKey:@"remittanceName" ascending:YES];
        
        
        [request setSortDescriptors:[NSArray arrayWithObjects:sort1,sort2, nil]];
        
        //[request setPredicate:[NSPredicate predicateWithFormat:@"isDeleted1 == YES"]];
        
        
        NSPredicate *pred ;
        
        if (del.isFromNotification == true) {
            
            pred = [NSPredicate predicateWithFormat:@"countryCode = %@ AND isDeleted1 = %@",del.notficationCountryCode,@"NO"];
        }
        else
        {
            pred = [NSPredicate predicateWithFormat:@"countryCode = %@ AND isDeleted1 = %@",self.country.countryCode,@"NO"];
        }
        
        
        
        
        [request setPredicate:pred];
        
        NSFetchedResultsController *f = [[NSFetchedResultsController alloc] initWithFetchRequest:request managedObjectContext:del.managedObjectContext sectionNameKeyPath:@"currencyKey" cacheName:nil];
        
        _fetchedHighest = f;
        
        [_fetchedHighest setDelegate: self];
    
    _fetched = _fetchedHighest;
        
        return _fetched;
    

}

- (NSFetchedResultsController *)fetchedRecent {
    
    if (_fetchedRecent) {
        return _fetchedRecent;
    }
    
    
        
        NSFetchRequest *request = [[NSFetchRequest alloc]init];
        
        NSEntityDescription *entity = [NSEntityDescription entityForName:@"Remittance" inManagedObjectContext:del.managedObjectContext];
        
        [request setEntity:entity];
        
        NSSortDescriptor *sort1 = [[NSSortDescriptor alloc]initWithKey:@"asofDate" ascending:NO];
        
        //NSSortDescriptor *sort2 = [[NSSortDescriptor alloc]initWithKey:@"remittanceName" ascending:YES];
        
        
        [request setSortDescriptors:[NSArray arrayWithObjects:sort1, nil]];
        
        //[request setPredicate:[NSPredicate predicateWithFormat:@"isDeleted1 == YES"]];
        
        
        NSPredicate *pred ;
        
        if (del.isFromNotification == true) {
            
            pred = [NSPredicate predicateWithFormat:@"countryCode = %@ AND isDeleted1 = %@",del.notficationCountryCode,@"NO"];
        }
        else
        {
            pred = [NSPredicate predicateWithFormat:@"countryCode = %@ AND isDeleted1 = %@",self.country.countryCode,@"NO"];
        }
        
        
        
        
        [request setPredicate:pred];
        
        NSFetchedResultsController *f = [[NSFetchedResultsController alloc] initWithFetchRequest:request managedObjectContext:del.managedObjectContext sectionNameKeyPath:@"currencyKey" cacheName:nil];
        
        _fetchedRecent = f;
        
        [_fetchedRecent setDelegate: self];
    
    _fetched = _fetchedRecent;
    
        return _fetched;
        
        

}





-(NSFetchedResultsController *)fetched
{
    
    if (_fetched) {
        return _fetched;
    }
    
    
    NSFetchRequest *request = [[NSFetchRequest alloc]init];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Remittance" inManagedObjectContext:del.managedObjectContext];
    
    [request setEntity:entity];
    
    NSSortDescriptor *sort1 = [[NSSortDescriptor alloc]initWithKey:@"currencyKey" ascending:YES];
   
    NSSortDescriptor *sort2 = [[NSSortDescriptor alloc]initWithKey:@"remittanceName" ascending:YES];
    
    
    [request setSortDescriptors:[NSArray arrayWithObjects:sort1,sort2, nil]];
    
    //[request setPredicate:[NSPredicate predicateWithFormat:@"isDeleted1 == YES"]];
    
    
    NSPredicate *pred ;
    
    if (del.isFromNotification == true) {
        pred = [NSPredicate predicateWithFormat:@"countryCode = %@ AND isDeleted1 = %@",del.notficationCountryCode,@"NO"];
    }
    else
    {
        pred = [NSPredicate predicateWithFormat:@"countryCode = %@ AND isDeleted1 = %@",self.country.countryCode,@"NO"];
    }
    
    
    
    
    [request setPredicate:pred];
    
    NSFetchedResultsController *f = [[NSFetchedResultsController alloc] initWithFetchRequest:request managedObjectContext:del.managedObjectContext sectionNameKeyPath:@"currencyKey" cacheName:nil];
    
    self.fetched = f;
    
    [self.fetched setDelegate: self];
    
    return self.fetched;
    
    
}

-(Remittance *)getAgentDetail :(NSString *)remittanceGUID
{
    CoreDataToPeso *core = [[CoreDataToPeso alloc]init];
    
    return [core getRemittanceByID:del.notifcationAgentID];
    
    
}

-(BOOL)isAgentFavoriteByGuid: (NSString *)remittanceGUID
{
    NSManagedObjectContext *context = del.managedObjectContext;
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Notification" inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    // Specify criteria for filtering which objects to fetch
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"remittanceGUID ==[cd]%@", remittanceGUID];
    [fetchRequest setPredicate:predicate];
    // Specify how the fetched objects should be sorted
    //    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"<#key#>"
    //                                                                   ascending:YES];
    // [fetchRequest setSortDescriptors:[NSArray arrayWithObjects:sortDescriptor, nil]];
    
    
    NSError *error = nil;
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
    if (fetchedObjects == nil) {
        NSLog(@"Error %@", fetchedObjects);
    }
    
    
    if ([fetchedObjects count] == 0) {
        return  false;
    }
    else
    {
        return true;
    }
    
    
    //return [fetchedObjects objectAtIndex:0];
    
}


-(UIImageView *)imageRound:(UIImageView *)imview;
{
    
    //imview.layer.cornerRadius = 10;
    //imview.layer.masksToBounds = YES;
    
    //imview.frame = CGRectMake(0,0,32,32);
    
    //[imview.layer setFrame:CGRectMake(0,0,20,20)];
    //return imview;
    
    
    UIGraphicsBeginImageContextWithOptions(imview.bounds.size, NO, [UIScreen mainScreen].scale);
    
    // Add a clip before drawing anything, in the shape of an rounded rect
    
    [[UIBezierPath bezierPathWithRoundedRect:imview.bounds
                                cornerRadius:6 ] addClip];
    // Draw your image
    [imview.image drawInRect:imview.bounds];
    
    // Get the image, here setting the UIImageView image
    imview.image = UIGraphicsGetImageFromCurrentImageContext();
    
    //            cell.imageView.layer.borderWidth  =1;
    //            cell.imageView.layer.borderColor = [UIColor grayColor].CGColor;
    //
    // Lets forget about that we were drawing
    
    
    UIGraphicsEndImageContext();
    
    return imview;
}


#pragma mark iAd Deleage



- (IBAction)ShareToFB:(id)sender {
    
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook])
    {
        SLComposeViewController *facebook = [SLComposeViewController
                                             composeViewControllerForServiceType:SLServiceTypeFacebook];
    
        
        [self prepareSocialMessage:facebook];
        
        [self presentViewController:facebook animated:YES completion:nil];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Facebook not configured" message:@"Unable to continue, your facebook account not yet configured. Please configure it in settings menu" delegate:nil cancelButtonTitle:@"Close" otherButtonTitles:nil];//, nil
        [alert show];
    }
    
}

-(void)shareToSocial :(NSString *)socialType
{
  
    
    if ([socialType isEqualToString:@"facebook"]) {
        if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook])
        {
            SLComposeViewController *facebook = [SLComposeViewController
                                                 composeViewControllerForServiceType:SLServiceTypeFacebook];
            
            
            [self prepareSocialMessage:facebook];
            
            [self presentViewController:facebook animated:YES completion:nil];
        }
        else
        {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Facebook not configured" message:@"Unable to continue, your facebook account not yet configured. Please configure it in settings menu" delegate:nil cancelButtonTitle:@"Close" otherButtonTitles:nil];//, nil
            [alert show];
        }
    }
    else if ([socialType isEqualToString:@"twitter"])
    {
        if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter])
        {
            SLComposeViewController *twitter = [SLComposeViewController
                                                 composeViewControllerForServiceType:SLServiceTypeTwitter];
            
            
            [self prepareSocialMessage:twitter];
            
            [self presentViewController:twitter animated:YES completion:nil];
        }
        else
        {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Facebook not configured" message:@"Unable to continue, your facebook account not yet configured. Please configure it in settings menu" delegate:nil cancelButtonTitle:@"Close" otherButtonTitles:nil];//, nil
            [alert show];
        }

    }
    else if ([socialType isEqualToString:@"email"])
    {
        // Email Subject
        NSString *emailTitle = @"ToPiso Remittance Rate for iOS";
        // Email Content
        NSString *messageBody =[NSString stringWithFormat:@"%@",[self generateSMSBody]] ; // Change the message body to HTML
        // To address
        //NSArray *toRecipents = [NSArray arrayWithObject:@"support@appcoda.com"];
        
        MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
        mc.mailComposeDelegate = self;
        [mc setSubject:emailTitle];
        [mc setMessageBody:messageBody isHTML:YES];
        
        self.labelHeader.text = [self generateHeaderText];
        self.labelHeader.hidden = false;
        self.segmentKo.hidden= true;
        
        UIImage *imageCapture = [[UIImage alloc]init];
        imageCapture = [CommonFunction getImageCapture:self.view FrameRect:CGRectMake(0, 0, self.view.bounds.size.width , 400)];
        
        self.labelHeader.hidden = true;
        self.segmentKo.hidden= false;
        
        
        NSData *imageData = UIImageJPEGRepresentation(imageCapture, 0.5);
        [mc addAttachmentData:imageData mimeType:@"image/jpeg" fileName:[NSString stringWithFormat:@"a.jpg"]];
        
        // Present mail view controller on screen
        [self presentViewController:mc animated:YES completion:NULL];

    }
    else if ([socialType isEqualToString:@"gallery"])
    {
        self.labelHeader.text = [self generateHeaderText];
        self.labelHeader.hidden = false;
        self.segmentKo.hidden= true;
        
        UIImage *imageCapture = [[UIImage alloc]init];
        imageCapture = [CommonFunction getImageCapture:self.view FrameRect:CGRectMake(0, 0, self.view.bounds.size.width , 400)];
        
        self.labelHeader.hidden = true;
        self.segmentKo.hidden= false;
        UIImageWriteToSavedPhotosAlbum(imageCapture, nil, nil, nil);
    }
    
}

-(NSString *)generateSMSBody
{
    NSDate *today = [NSDate date];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"dd/MM/yyyy hh:mm:ss a"];
    NSString *dateString = [dateFormat stringFromDate:today];

    NSURL *ulr = [SendAndRequest AppStoreLink];
    
    return [NSString stringWithFormat:@"%@ rate as of %@.<br /><br />Install for iOS: %@",self.country.countryName,dateString,ulr];

    
}

- (IBAction)segmentAction:(id)sender {
    
    NSLog(@"Segment %ld",(long)self.segmentOutlet.selectedSegmentIndex);
    
    if (self.segmentOutlet.selectedSegmentIndex==0) {
        self.fetched = [self fetchedHighest];
    }
    else
    {
        self.fetched = [self fetchedRecent];
    }
    
    NSError *error;
    if (![self.fetched performFetch:&error]) {
        // Update to handle the error appropriately.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        exit(-1);  // Fail
    }
    
    [self.tableView reloadData];
    
}

-(void)prepareSocialMessage:(SLComposeViewController*)controller
{
    
    NSDate *today = [NSDate date];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"dd/MM/yyyy hh:mm a"];
    NSString *dateString = [dateFormat stringFromDate:today];
    
//    NSNumberFormatter *numFormat = [[NSNumberFormatter alloc]init];
//    [numFormat setNumberStyle:NSNumberFormatterDecimalStyle];
//    
//    NSString *strNumber = [numFormat stringFromNumber:self.remitanceAgent.rate];
//    
    NSURL *ulr = [SendAndRequest AppStoreLink];
    
    [controller setInitialText:[NSString stringWithFormat:@"%@ rate as of %@.\nInstall for iOS: %@",self.country.countryName,dateString,ulr]];
    
    //    [controller addImage:[UIImage imageNamed:@"aga_180_180.png"]];
    //    [controller addURL:[NSURL URLWithString:[CommonFunction getToPisoInstallURL]]];
    //
    
    // UIImageView *imgv = [[UIImageView alloc]init];
    //imgv.image = [UIImage imageNamed:@"aga_180_180.png"];
    //imgv.layer.cornerRadius = 10;
    // imgv.clipsToBounds = YES;
    //imgv.layer.borderWidth = 1;
    //[imgv.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    
    self.labelHeader.text = [self generateHeaderText];
    self.labelHeader.hidden = false;
    self.segmentKo.hidden= true;
    
    UIImage *imageCapture = [[UIImage alloc]init];
    imageCapture = [CommonFunction getImageCapture:self.view FrameRect:CGRectMake(0, 0, self.view.bounds.size.width , 400)];
    
    self.labelHeader.hidden = true;
    self.segmentKo.hidden= false;

    
    
    //[controller addImage:[UIImage imageNamed:@"aga_180_180.png"]];
    
    [controller addImage:imageCapture];
    
    // [controller addImage:imgv.image];
    //[controller addURL:[NSURL URLWithString:[CommonFunction getToPisoInstallURL]]];
}

- (void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    switch (result)
    {
        case MFMailComposeResultCancelled:
            NSLog(@"Mail cancelled");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Mail saved");
            break;
        case MFMailComposeResultSent:
            NSLog(@"Mail sent");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail sent failure: %@", [error localizedDescription]);
            break;
        default:
            break;
    }
    
    // Close the Mail Interface
    [self dismissViewControllerAnimated:YES completion:NULL];
}

-(NSString *)generateHeaderText
{
    NSDate *today = [NSDate date];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"MMMM dd, yyyy hh:mm a"];
    NSString *dateString = [dateFormat stringFromDate:today];
    

    NSString *strText = [NSString stringWithFormat:@"%@ ToPiso Remittance Rate as of %@",self.country.countryName,dateString];
    return strText;
}

#pragma Interstitial



- (void)interstitialDidDismissScreen:(GADInterstitial *)interstitial {
    self.interstitial = [self createAndLoadInterstitial];
    
    //self.interstitial = [commonAddMob ]
}


- (GADInterstitial *)createAndLoadInterstitial
{
    GADInterstitial *interstitial = [[GADInterstitial alloc] init];
    interstitial.adUnitID = @"ca-app-pub-3940256099942544/4411468910";
    interstitial.delegate = self;
    
    GADRequest *request = [GADRequest request];
    //request.testing = NO;
    
    [interstitial loadRequest:request];
    
    return interstitial;
}

@end
