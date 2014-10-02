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

@interface NotificationTableViewController ()
{
    com_pachie_topesoAppDelegate *delegate;
    SendAndRequest *send;
    
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
    
    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

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
    
    // Configure the cell...
    
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

-(void)bannerViewDidLoadAd:(ADBannerView *)banner
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1];
    [banner setAlpha:1];
    [UIView commitAnimations];
}

-(void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1];
    [banner setAlpha:0];
    [UIView commitAnimations];
    
}
@end
