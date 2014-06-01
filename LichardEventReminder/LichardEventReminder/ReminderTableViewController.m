//
//  ReminderTableViewController.m
//  LichardEventReminder
//
//  Created by pachie on 29/5/14.
//  Copyright (c) 2014 Private. All rights reserved.
//

#import "ReminderTableViewController.h"
#import "Reminder.h"

@interface ReminderTableViewController ()

@end

@implementation ReminderTableViewController

@synthesize fetchedResultsController = _fetchedResultsController;

-(void)AddReminderDidCancel:(Reminder *)reminderDelete
{
    
    NSManagedObjectContext *context = self.mangedObjectContext;
    
    [context deleteObject:reminderDelete];
    
    [self dismissModalViewControllerAnimated:YES];
    
}

-(void) AddReminderDidSave
{
    NSError *error = nil;
    NSManagedObjectContext *context = self.mangedObjectContext;
    if(![context    save:&error])
    {
        NSLog(@"Error! %@", error);
    }
    
    [self dismissModalViewControllerAnimated:YES];
}


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
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    NSError *error = nil;
    if (![[self fetchedResultsController] performFetch:&error]) {
        
        NSLog(@"Error! %@", error);
        
        abort();
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
    
    return [[self.fetchedResultsController sections] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    id<NSFetchedResultsSectionInfo> secInfo = [[self.fetchedResultsController sections] objectAtIndex:section];
    return [secInfo numberOfObjects];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier =@"ReminderCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
   Reminder  *mt = [self.fetchedResultsController objectAtIndexPath:indexPath];
    cell.textLabel.text = mt.reminderBody;
    cell.detailTextLabel.text = mt.createdToNo;
    
    // Configure the cell...
    
    return cell;
}


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


 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
     if ([[segue identifier] isEqualToString:@"segCreateNewReminder"]) {
         CreateNewReminderViewController *cnvc = (CreateNewReminderViewController *) [segue destinationViewController];
         cnvc.ReminderDelegate = self;
         
         Reminder *newReminder = (Reminder *)[NSEntityDescription insertNewObjectForEntityForName:@"Reminder" inManagedObjectContext:[self mangedObjectContext]];
         
         cnvc.currentReminder = newReminder;
         
     }

 }
 

#pragma marks -
#pragma mark Fetched Results Controller Section
-(NSFetchedResultsController *) fetchedResultsController
{
    if(_fetchedResultsController != nil)
    {
        return _fetchedResultsController;
    }
    
    
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Reminder" inManagedObjectContext:[self mangedObjectContext]];
    
    [fetchRequest setEntity:entity];
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"reminderDate" ascending:YES];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
    
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    _fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.mangedObjectContext sectionNameKeyPath:@"reminderDateGroup" cacheName:nil];
    
    _fetchedResultsController.delegate =self;
    
    return _fetchedResultsController;
    
    
    
}
-(void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView endUpdates];
}
-(void)controllerWillChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView beginUpdates];
}


-(void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath
{
    UITableView *tableView = self.tableView;
    switch (type) {
        case NSFetchedResultsChangeInsert:
           [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeUpdate:
        {
            Reminder *rm = [self.fetchedResultsController objectAtIndexPath:indexPath];
            UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            cell.textLabel.text = rm.reminderBody;
        }
            
            break;
            
        case NSFetchedResultsChangeMove:
        {
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            
            break;
            
        }
    }
}
//
-(void)controller:(NSFetchedResultsController *)controller didChangeSection:(id<NSFetchedResultsSectionInfo>)sectionInfo atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type
{
    switch (type) {
        case NSFetchedResultsChangeInsert:
            [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
        default:
            break;
    }
}

-(NSString *) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    //[self.fetchedResultsController sections] objectAtIndex:sectio
    
    //NSDate *dateRepresentingThisDay = [self. objectAtIndex:section];
    
    //return [self.sectionDateFormatter stringFromDate:dateRepresentingThisDay];
    
    //return [[[self.fetchedResultsController sections] objectAtIndex:section]name];
    
    //return [[[self.fetchedResultsController sections] objectAtIndex:section]name];
    
    if ([[self.fetchedResultsController sections] count] > 0) {
        id <NSFetchedResultsSectionInfo> sectionInfo = [[self.fetchedResultsController sections] objectAtIndex:section];
        
//        NSDateFormatter *df = [[NSDateFormatter alloc]init];
//        [df setDateFormat:@"MMM dd, yyyy"];
//        
//        NSDate *now = [[NSDate alloc] init];
//        
//        
//        
//        NSString *s = [sectionInfo name];
//        
//        NSDate *d = [df dateFromString:s];
        
        NSDateFormatter *inFormat = [[NSDateFormatter alloc] init] ;
        [inFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss Z"];
        NSDate *parsed = [inFormat dateFromString:[sectionInfo name]];
        
        //NSLog(@"sectionInfo : %@", [sectionInfo name]);
        //NSLog(@"date : %@", parsed);
        
        inFormat.dateFormat =@"MMMM - yyyy";
        
        NSString * monthString = [[inFormat stringFromDate:parsed] capitalizedString];

        
        NSLog(@"month: %@", monthString);
        
        //return [NSDateFormatter datefromString [sectionInfo name];
        
        //NSLog(@"sectioninfo : %@", sectionInfo);
        
       // NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
        //[inputFormatter setDateFormat:@"yyyy-MM-dd"];
        
        //NSDate *formatterDate = [inputFormatter dateFromString:[sectionInfo name]];
        
        //NSDate *eventDate = [sectionInfo name];
        //NSString *convertedString = [inputFormatter stringFromDate:formatterDate];
        
        //return convertedString;
        
        
        return [sectionInfo name];
        //return monthString;//[sectionInfo name];
    } else
        return nil;

}



@end


