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

@interface RemittanceTableViewController ()

{
    com_pachie_topesoAppDelegate *del;
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
    
    [self.tableView registerNib:[UINib nibWithNibName:@"View" bundle:nil] forCellReuseIdentifier:@"Cell"];
    
    del = (com_pachie_topesoAppDelegate *)[[UIApplication sharedApplication]delegate];
    
    NSError *error;
    if (![[self fetched] performFetch:&error]) {
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
    
    return [sectionInfo name];
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
    
    NSNumberFormatter *numberformatter = [[NSNumberFormatter alloc]init];
    
    [numberformatter setNumberStyle:NSNumberFormatterDecimalStyle];
    
    NSString *str = [numberformatter stringFromNumber:rem.rate];
    
    cell.lblRate.text =[NSString stringWithFormat:@"%@ as of June 24, 2014 08:00 AM",str];
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
                            
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 54;
}

#pragma mark -fetched controller

-(NSFetchedResultsController *)fetched
{
//    if (_fetched) {
//        return  _fetched;
//    }
//    
//    NSFetchRequest *request = [[NSFetchRequest alloc]init];
//    
//    NSEntityDescription *des = [NSEntityDescripti	on entityForName:@"Remittance" inManagedObjectContext:del.managedObjectContext];
//    
//    [request setEntity:des];
//    
//    NSSortDescriptor *sort1 = [[NSSortDescriptor alloc]initWithKey:@"remittanceName" ascending:YES];
//    
//    [request setSortDescriptors:[NSArray arrayWithObject:sort1]];
//    
//    [request setFetchBatchSize:20];
//    
//    
//    NSFetchedResultsController *f = [[NSFetchedResultsController alloc] initWithFetchRequest:request managedObjectContext:del.managedObjectContext sectionNameKeyPath:nil cacheName:nil];
//    
//    
//    self.fetched = f;
//    
//    [self.fetched setDelegate:self];
//    
//    return _fetched;
    
    
    if (_fetched) {
        return _fetched;
    }
    
    
    NSFetchRequest *request = [[NSFetchRequest alloc]init];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Remittance" inManagedObjectContext:del.managedObjectContext];
    
    [request setEntity:entity];
    
    NSSortDescriptor *sort1 = [[NSSortDescriptor alloc]initWithKey:@"currencyKey" ascending:YES];
   
    NSSortDescriptor *sort2 = [[NSSortDescriptor alloc]initWithKey:@"remittanceName" ascending:YES];
    
    
    [request setSortDescriptors:[NSArray arrayWithObjects:sort1,sort2, nil]];
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"countryCode = %@",self.countryCode];
    
    
    [request setPredicate:pred];
    
    NSFetchedResultsController *f = [[NSFetchedResultsController alloc] initWithFetchRequest:request managedObjectContext:del.managedObjectContext sectionNameKeyPath:@"currencyKey" cacheName:nil];
    
    self.fetched = f;
    
    [self.fetched setDelegate: self];
    
    return self.fetched;
    
    
}

@end
