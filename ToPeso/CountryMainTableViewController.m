//
//  CountryMainTableViewController.m
//  ToPeso
//
//  Created by pachie on 12/9/14.
//  Copyright (c) 2014 Private. All rights reserved.
//

#import "CountryMainTableViewController.h"
#import "com_pachie_topesoAppDelegate.h"
#import "RemittanceTableViewController.h"

@interface CountryMainTableViewController ()
{
    com_pachie_topesoAppDelegate *del;
}

@end

@implementation CountryMainTableViewController

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
    
    del = (com_pachie_topesoAppDelegate *)[[UIApplication sharedApplication]delegate];
    
    NSError *error;
    if (![[self fectched] performFetch:&error]) {
        // Update to handle the error appropriately.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        exit(-1);  // Fail
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

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    id sectionInfo = [[[self fectched]sections]objectAtIndex:section];
    
    return  [sectionInfo numberOfObjects];
    
    
}

#pragma -fectched controller
-(NSFetchedResultsController *)fectched
{
    
        if (_fectched != nil) {
            return _fectched;
        }
        
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
        
        NSEntityDescription *entity = [NSEntityDescription entityForName:@"Country" inManagedObjectContext:del.managedObjectContext];
        
        [fetchRequest setEntity:entity];
        
        NSSortDescriptor *sort = [[NSSortDescriptor alloc] initWithKey:@"countryName" ascending:YES];
        
        [fetchRequest setSortDescriptors:[NSArray arrayWithObject:sort]];
        
        [fetchRequest setFetchBatchSize:20];
        
    NSFetchedResultsController *theFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:del.managedObjectContext sectionNameKeyPath:nil cacheName:nil];
        
        self.fectched = theFetchedResultsController;
        
        self.fectched.delegate = self;
        
        return _fectched;
        
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    NSManagedObject *o = [self.fectched objectAtIndexPath:indexPath];
    
    cell.textLabel.text = [o valueForKey:@"countryName"];
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    
    return cell;
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    if ([segue.identifier isEqualToString:@"showDetails"]) {
        
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        
        RemittanceTableViewController *rem = (RemittanceTableViewController *)segue.destinationViewController;
        
        NSManagedObject *m = [[self fectched]objectAtIndexPath:indexPath];
        
        rem.countryCode = [m valueForKey:@"countryCode"];
        
        
    }
    
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"showDetails" sender:self];
}



@end
