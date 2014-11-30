//
//  NotificationTableViewController.m
//  ToPeso
//
//  Created by pachie on 15/9/14.
//  Copyright (c) 2014 Private. All rights reserved.
//

#import "NotificationTableViewController.h"
#import "com_pachie_topesoAppDelegate.h"
#import "Notification.h"
#import "SendAndRequest.h"
#import "AgentDetailsTableViewController.h"
#import "Remittance.h"
#import "CommonAddMob.h"

@interface NotificationTableViewController ()
{
    com_pachie_topesoAppDelegate *delegate;
    SendAndRequest *send;
    commonAddMob *_commonAddMob;
}
@end

@implementation NotificationTableViewController

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
    
    delegate = (com_pachie_topesoAppDelegate *)[[UIApplication sharedApplication]delegate];
    send = [[SendAndRequest alloc]init];
   // _commonAddMob = [[commonAddMob alloc]init];
    
    //[self.tableView setContentInset:UIEdgeInsetsMake(50, 0, 0, 0)];
    
    
    

}

-(void)viewDidAppear:(BOOL)animated
{
    NSError *error;
    if (![[self fetched] performFetch:&error]) {
        // Update to handle the error appropriately.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        exit(-1);  // Fail
    }
    
    [[self tableView]reloadData];
    
    UIView *adsView = [_commonAddMob ImplementBanerBottom:self];

    [self.view addSubview:adsView];
    
    self.editing = NO;
    

    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

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
                                cornerRadius:4.0 ] addClip];
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

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    id<NSFetchedResultsSectionInfo> sectionInfo = [[self.fetched sections]objectAtIndex:section];
    
    //return [sectionInfo name];
    
    
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 17)];
    
    //UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, sc, 14)];

    
    [view setBackgroundColor:[UIColor whiteColor]];
    
    
    UIColor *yellowColor =  [UIColor colorWithRed:(255/255.0) green:(251/255.0) blue:(246/255.0) alpha:1] ;
    
    
    [view setBackgroundColor:yellowColor];
    
    NSString *countryFlag = [self getCountryFlagByCountryName:[sectionInfo name]];
    
    
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    NSString* path = [documentsDirectory stringByAppendingPathComponent:countryFlag];
    
    
    UIImage* img = [UIImage imageWithContentsOfFile:path];
    
    if (img == nil) {
        img = [UIImage imageNamed:@"default.png"];
    }
    
    
    
    UIImageView* imgView=[[UIImageView alloc]initWithFrame:CGRectMake(16, 8, 40, 40)];
    imgView.image =img;
    
    //imgView.image = [self imageRound:imgView].image;
    
    //imgView.layer.cornerRadius = 10;
   // imgView.clipsToBounds = YES;
    //imgView.layer.borderWidth = .5;
    //imgView.layer.borderColor = [UIColor orangeColor].CGColor;
    
    
    
    [view addSubview:[self imageRound:imgView]];
    
    [view addSubview:imgView];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(70, 16, tableView.frame.size.width, 20)];
    
    label.text = [sectionInfo name];
    label.font = [UIFont fontWithName:@"Arial Rounded MT Bold" size:15];//[UIFont systemFontOfSize:14];
    
    label.textColor = [UIColor darkGrayColor];
    //label.textAlignment = NSTextAlignmentRight;
    //label.font = [UIFont fontWithName:@"Helvetica-Normal" size:14];
    
    
    
    
    [view addSubview:label];
    
  

    
    [view.layer setOpacity:10];
    
    
    
    return view;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 56;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    id sections = [[self fetched] sections];
    
    return  [sections count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    id<NSFetchedResultsSectionInfo> sectionInfo = [[self.fetched sections] objectAtIndex:section];
    
    return [sectionInfo numberOfObjects];
    
}


-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    id<NSFetchedResultsSectionInfo> sectionInfo = [[self.fetched sections]objectAtIndex:section];
    
    return [sectionInfo name];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    
    
    Notification1 *noti = [self.fetched objectAtIndexPath:indexPath];
    
    cell.textLabel.text =  noti.agentName;
    
    Remittance *rem = [self getRemittanceByGUID:noti.remittanceGUID];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    NSString* path = [documentsDirectory stringByAppendingPathComponent:rem.logo];
    
    UIImage* image = [UIImage imageWithContentsOfFile:path];
    
    
    UIImageView *imgv = [[UIImageView alloc]initWithFrame:CGRectMake(0,0,40,40)];
    
    imgv.image = image;
    
    //[[UIImageView alloc]initWithImage:image];
    
    if (imgv.image == nil) {
        imgv.image = [UIImage imageNamed:@"default.png"];
    }
    
    
    
   // [self imageRound:cell.imageView];
    
    cell.textLabel.textColor = [UIColor darkGrayColor];
    
    cell.imageView.image = imgv.image;
    
    
    // Configure the cell...
    

    
    cell.imageView.image = [self imageRound:imgv].image;
    
    cell.imageView.layer.cornerRadius = 4;
    cell.imageView.layer.opacity = .80;
    cell.imageView.clipsToBounds = YES;
    cell.imageView.layer.borderWidth = .1;
    cell.imageView.layer.borderColor = [UIColor grayColor].CGColor;
    
    
    
    return cell;
}




- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
    // The fetch controller is about to start sending change notifications, so prepare the table view for updates.
    [self.tableView beginUpdates];
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    
    Notification1 *noti = [_fetched objectAtIndexPath:indexPath];
    cell.textLabel.text = noti.agentName;
//    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@, %@",
//                                 info.city, info.state];
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath {
    
    UITableView *tableView = self.tableView;
    
    switch(type) {
            
        case NSFetchedResultsChangeInsert:
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeUpdate:
            [self configureCell:[tableView cellForRowAtIndexPath:indexPath] atIndexPath:indexPath];
            break;
            
        case NSFetchedResultsChangeMove:
            [tableView deleteRowsAtIndexPaths:[NSArray
                                               arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [tableView insertRowsAtIndexPaths:[NSArray
                                               arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}


- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id )sectionInfo atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type {
    
    switch(type) {
            
        case NSFetchedResultsChangeInsert:
            [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeMove:
            NSLog(@"A table item was moved");
            break;
        case NSFetchedResultsChangeUpdate:
            NSLog(@"A table item was updated");
            break;
    }
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    // The fetch controller has sent all current change notifications, so tell the table view to process all updates.
    [self.tableView endUpdates];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        //remove the deleted object from your data source.
        //If your data source is an NSMutableArray, do this
      //  [self.fetched  removeObjectAtIndex:indexPath.row];
        
        Notification1 *no = [self.fetched objectAtIndexPath:indexPath];
        
        NSDateFormatter *dformat = [[NSDateFormatter alloc]init];
        [dformat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSString *strDate = [dformat stringFromDate:[NSDate date]];

//        NSDictionary *payloadDict = [NSDictionary dictionaryWithObjectsAndKeys:
//                                     @"", @"notificationGUID"
//                                     , delegate.DevinceToken, @"deviceUDID"
//                                     , no.remittanceGUID,@"remittanceGUID"
//                                     , no.agentName,@"agentName"
//                                     , no.countryCode,@"countryCode"
//                                     , no.countryName,@"countryName"
//                                     , no.currencyKey,@"currencyKey"
//                                     , strDate,@"lastUpdated"
//                                     , strDate,@"dateCreated"
//                                     , @"false",@"isInsertDelete",
//                                     nil];
        
        
        NSDictionary *payloadDict = @{  @"notificationGUID":@"yttyghyy"
                                        , @"deviceUDID" : delegate.DevinceToken
                                        , @"remittanceGUID" : no.remittanceGUID
                                        , @"agentName" : no.agentName
                                        , @"countryCode" : no.countryCode
                                        , @"countryName" : no.countryName
                                        , @"currencyKey" : no.currencyKey
                                        , @"lastUpdated" : strDate
                                        , @"dateCreated" : strDate
                                        , @"isInsertDelete": @"false"
                                        };
        
        
        NSString *strURL =[NSString stringWithFormat:@"%@/insertnotification", [send getToPisoURL]];
        [send syncNotificationToServer:[NSURL URLWithString:strURL] notificationData:payloadDict CompletionBlock:^(bool succeeded, NSError *error) {
            
            if (succeeded) {
                [delegate.managedObjectContext deleteObject:[self.fetched objectAtIndexPath:indexPath]];
                
                NSError *error = nil;
                if (![delegate.managedObjectContext save:&error]) {
                    // handle error
                }
                
                [tableView reloadData]; // tell table to refresh now
                
                if ([[self.fetched fetchedObjects]count] == 0) {
                    
                    
                    self.btnEdit.title =  @"Edit";
                    
                    
                    
                }
            }
            else
            {
                //NSLog(@"not succeeded");
                
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Connection Error" message:@"Unable to connect to server" delegate:nil cancelButtonTitle:@"Close" otherButtonTitles:nil];//, nil
                
                [alert show];
                
                
                
            }
            
        }];
        
        

        
    }
}

-(NSFetchedResultsController *)fetched
{
    if (_fetched) {
        return _fetched;
    }
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Notification" inManagedObjectContext:delegate.managedObjectContext];
    [fetchRequest setEntity:entity];
    // Specify criteria for filtering which objects to fetch
    //NSPredicate *predicate = [NSPredicate predicateWithFormat:@"<#format string#>", <#arguments#>];
    //[fetchRequest setPredicate:predicate];
    // Specify how the fetched objects should be sorted
    NSSortDescriptor *sortDescriptor1 = [[NSSortDescriptor alloc] initWithKey:@"countryName"
                                                                   ascending:YES];
    NSSortDescriptor *sortDescriptor2 = [[NSSortDescriptor alloc] initWithKey:@"agentName"
                                                                    ascending:YES];
    

    
    [fetchRequest setSortDescriptors:[NSArray arrayWithObjects:sortDescriptor1,sortDescriptor2, nil]];
    
    NSError *error = nil;
    NSArray *fetchedObjects = [delegate.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    
    if (fetchedObjects == nil) {
        NSLog(@"Error %@", error);
    }
    
    _fetched = [[NSFetchedResultsController alloc]initWithFetchRequest:fetchRequest managedObjectContext:delegate.managedObjectContext sectionNameKeyPath:@"countryName" cacheName:nil];
    
    _fetched.delegate = self;
    
    return _fetched;
    
}

- (IBAction)acEdit:(id)sender {
    
    
    if ([self.btnEdit.title isEqualToString:@"Edit"]) {
        
        [self setEditing:YES animated:YES];
    }
    else
    {
        [self setEditing:NO animated:YES];
    }
    
    //[self hideShowButton];
}





- (void)setEditing:(BOOL)flag animated:(BOOL)animated
{
    [super setEditing:flag animated:animated];
    
    if (flag == YES){
        self.btnEdit.title = @"Done";
        // Change views to edit mode.
    }
    else {
        self.btnEdit.title = @"Edit";
        
        // Save the changes if needed and change the views to noneditable.
    }
    
}

-(void)Pam
{
    [self acEdit:self];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"agentDetails" sender:self];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqual:@"agentDetails"]) {
        
        NSIndexPath *indexpath = [self.tableView indexPathForSelectedRow];
        
        AgentDetailsTableViewController *agent = (AgentDetailsTableViewController *)segue.destinationViewController;
        
        Notification1 *rem = [self.fetched objectAtIndexPath:indexpath];
        
        
        rem  = [self.fetched objectAtIndexPath:indexpath];
        
        agent.remitanceAgent = [self getRemittanceByGUID:rem.remittanceGUID];
        agent.country = [self getCountryByCountryCode:rem.countryCode];
        
    }
}

-(Country *)getCountryByCountryCode : (NSString *)countrCode
{
    NSManagedObjectContext *context = delegate.managedObjectContext;
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Country" inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    // Specify criteria for filtering which objects to fetch
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"countryCode ==[cd]%@", countrCode];
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
    
    return [fetchedObjects objectAtIndex:0];
    
}

-(NSString *)getCountryFlagByCountryName : (NSString *)CountryName
{
    NSManagedObjectContext *context = delegate.managedObjectContext;
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Country" inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    // Specify criteria for filtering which objects to fetch
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"countryName ==[cd]%@", CountryName];
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
    
    Country *country = [fetchedObjects objectAtIndex:0];
    
    return country.countryFlag;
    
}




-(Remittance *)getRemittanceByGUID: (NSString *)remittanceGUID
{
    NSManagedObjectContext *context = delegate.managedObjectContext;
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Remittance" inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    // Specify criteria for filtering which objects to fetch
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"remmittanceGUID ==[cd]%@", remittanceGUID];
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
    
    return [fetchedObjects objectAtIndex:0];
    
}




#pragma mark iAd Deleage

//-(void)bannerViewDidLoadAd:(ADBannerView *)banner
//{
//    [UIView beginAnimations:nil context:nil];
//    [UIView setAnimationDuration:1];
//    [banner setAlpha:1];
//    [UIView commitAnimations];
//}
//
//-(void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error
//{
//    [UIView beginAnimations:nil context:nil];
//    [UIView setAnimationDuration:1];
//    [banner setAlpha:0];
//    [UIView commitAnimations];
//    
//}

//- (void)scrollViewDidScroll:(UIScrollView *)scrollView
//{
//    UIView *xView = [_commonAddMob ImplementBanerBottom:self];
//    
//    CGRect fixedFrame = xView.frame;
//    fixedFrame.origin.y = 0 + scrollView.contentOffset.y + 64;
//    xView.frame = fixedFrame;
//}
@end
