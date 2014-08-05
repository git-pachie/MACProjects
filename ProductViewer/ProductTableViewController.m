//
//  ProductTableViewController.m
//  ProductViewer
//
//  Created by pachie on 3/8/14.
//  Copyright (c) 2014 Private. All rights reserved.
//

#import "ProductTableViewController.h"
#import "AppDelegate.h"
#import "Products.h"
#import "AddProductViewController.h"

@interface ProductTableViewController ()
{
    dispatch_queue_t myQueue;
}

@end

@implementation ProductTableViewController



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
    
    if (!myQueue) {
        myQueue = dispatch_queue_create("com.abc.com", NULL);
    }
    
    dispatch_async(myQueue, ^{
         [self shouldChangeNumber];
    });
    
   
    
   
}

-(void)shouldChangeNumber
{
    dispatch_async(dispatch_get_main_queue(), ^{
        NSError *error;
        
        if (![[self fetch] performFetch:&error]) {
            NSLog(@"An error occured : %@", [error localizedDescription]);
        }
        
        [self.tableView reloadData];

    });
    
    }

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"addProduct"]) {
        
        AddProductViewController *add = (AddProductViewController *) segue.destinationViewController;
        
        
        add.delegate1 = self ;// = self;
        
    }
}

- (IBAction)editTable:(id)sender {

    if ([self.editButton.title isEqualToString:@"Edit"]) {
        [self.editButton setTitle:@"Done"];
        
        [self.tableView setEditing:YES animated:YES];

    }
    else
    {
        [self.editButton setTitle:@"Edit"];
        
        [self.tableView setEditing:NO animated:YES];

    }
    
    
}

-(NSFetchedResultsController *)fetch
{
    if (_fetch) {
        return _fetch;
    }
    
    AppDelegate *delegate = [[UIApplication sharedApplication]delegate];
    
    NSManagedObjectContext *context = [delegate managedObjectContext];
    
    NSFetchRequest *fe = [NSFetchRequest fetchRequestWithEntityName:@"Products"];
    
    NSSortDescriptor *primarySort = [NSSortDescriptor sortDescriptorWithKey:@"productCategory" ascending:YES];
    
    NSSortDescriptor *secondSort = [NSSortDescriptor sortDescriptorWithKey:@"productName" ascending:YES];
    

    NSArray *sortArray = [NSArray arrayWithObjects:primarySort,secondSort, nil];
    
    [fe setSortDescriptors:sortArray];
    
    
    NSFetchedResultsController *frc = [[NSFetchedResultsController alloc] initWithFetchRequest:fe managedObjectContext:context sectionNameKeyPath:@"productCategory" cacheName:nil];
    
    [self setFetch:frc];
    [[self fetch]setDelegate:self];
    
    
    
    return _fetch;
    
   // NSEntityDescription *entityDesc =    [NSEntityDescription entityForName:@"Products"   inManagedObjectContext:context];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    NSArray *sections = [[self fetch]sections];
    
    return [sections count];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *sections = [[self fetch] sections];
    
    id<NSFetchedResultsSectionInfo> currentSection = [sections objectAtIndex:section];
    
    return [currentSection numberOfObjects];
}

/**/
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    Products *product = [[self fetch]objectAtIndexPath:indexPath];
    
    cell.textLabel.text = product.productName;
    cell.detailTextLabel.text = product.productSellPrice;
    
    // Configure the cell...
    
    return cell;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSArray *sections = [[self fetch] sections];
    
    id<NSFetchedResultsSectionInfo> currentSection = [sections objectAtIndex:section];
    return  [currentSection name];
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        NSManagedObject *mno = [self.fetch objectAtIndexPath:indexPath];
        
       // self.fetch r
        
        AppDelegate *del = (AppDelegate *)[[UIApplication sharedApplication]delegate];
        
        [del.managedObjectContext deleteObject:mno];
        
        NSError *error;
        
        if (![del.managedObjectContext save:&error]) {
            NSLog(@"Error deleting %@", error);
        }
        
        
        [self shouldChangeNumber];
    }
}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView setEditing:YES animated:YES];
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
