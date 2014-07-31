//
//  HomeTableViewController.m
//  TestReminder
//
//  Created by pachie on 29/7/14.
//  Copyright (c) 2014 Private. All rights reserved.
//

#import "HomeTableViewController.h"
#import "AppDelegate.h"
#import "DetailsViewController.h"
#import "xTableViewCell.h"
#import "CommonCoreData.h"


@interface HomeTableViewController ()
{
    NSArray *dataArray;
}

@end

@implementation HomeTableViewController

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
    //[self.tableView registerNib:[UINibnibWithNibName:@"xTableCell"bundle:nil] forCellReuseIdentifier:@"Cell"];
    //[self.tableView registerNib:[uini:@"CustomCell"bundle:nil] forCellReuseIdentifier:@"Cell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"mycell" bundle:nil] forCellReuseIdentifier:@"Cell"];
    
    [self LoadData];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [self LoadData];
    [self.tableView reloadData];
}

-(void)LoadData
{
//    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
//    NSManagedObjectContext *context =   [appDelegate managedObjectContext];
//    NSEntityDescription *entityDesc =    [NSEntityDescription entityForName:@"Reminders1"   inManagedObjectContext:context];
//    NSFetchRequest *request = [[NSFetchRequest alloc] init];
//    [request setEntity:entityDesc];
//  
//    
////    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(reminderDate >= %@)", [NSDate dateWithTimeIntervalSinceNow:1]];
////    
////    [request setPredicate:predicate];
//    
//    NSError *error;
//    
//    dataArray = [[NSArray alloc]init];
    
    dataArray =[CommonCoreData GetReminderArray:nil ];// [context executeFetchRequest:request
                                      // error:&error];
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
    return [dataArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    xTableViewCell  *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[xTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
//
//    
//    // Configure the cell...
//    
    NSManagedObject *object = [dataArray objectAtIndex:indexPath.row];
    
    cell.testLabel.text = [object valueForKey:@"reminderName"];
    
//    //NSDate *date = [dateFormatter dateFromString: str]; // here you can fetch date from string with define format
//    
    NSDateFormatter *dateFormatter;
    
    dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd/MM/yyyy hh:mm a"];// here set format which you want...
    
    NSString *convertedString = [dateFormatter stringFromDate:[object valueForKey:@"reminderDate"]];
//    
    cell.lblsub.text = convertedString;
//    
//    
//    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"segdetails" sender:indexPath];
}

-(void)CallFromNotification
{
    [self performSegueWithIdentifier:@"segnotification" sender:self];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if([segue.identifier isEqualToString:@"segdetails"])
        
    {
        
        NSIndexPath *path = [self.tableView indexPathForSelectedRow];
        
        //MessageDetailViewController *dv = segue.destinationViewController;
        
        NSManagedObject *mno = nil;
        
        
        mno =  [dataArray objectAtIndex:path.row ] ;
        
        DetailsViewController *dv = segue.destinationViewController;
        dv.messageGUID = [mno valueForKey:@"messageGUID"];
        
        
        
    }
    
    else if([segue.identifier isEqualToString:@"segnotification"]){
        
        
        DetailsViewController *dv = segue.destinationViewController;
        dv.messageGUID = self.notificationID;
        
        
    }

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
