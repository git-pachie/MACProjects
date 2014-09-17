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
#import "CoreDataToPeso.h"
#import "SendAndRequest.h"

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
    
    CoreDataToPeso *core = [[CoreDataToPeso alloc]init];
    //[core insertTempData];
    SendAndRequest *send = [[SendAndRequest alloc]init];
    
    NSString *lastModified = [core getLastUpdatedCountry];
    
    [send getLastesCountry:lastModified withBlock:^(NSArray *array)
    {
       
        
//        for (NSArray *dic in array) {
//            NSLog(@"%@",dic);
//            
//        }
        
        [core syncCoreData:array];
        
        NSError *error;
        if (![[self fectched] performFetch:&error]) {
            // Update to handle the error appropriately.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            exit(-1);  // Fail
        }
        
        [self.tableView reloadData];
        
    }];
    
   
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
    
    
    [fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"isDeleted1 ==[cd]%@",@"NO"]];
    
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
    
    //cell.imageView.image = [UIImage imageNamed:[o valueForKey:@"countryFlag"]];
    
    UIImageView *imgv = [[UIImageView alloc]initWithImage:[UIImage imageNamed:[o valueForKey:@"countryFlag"]]];
    
    [cell.imageView setImage:[self imageRound:imgv].image];
    
    [self imageRound:cell.imageView];
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    
    return cell;
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    if ([segue.identifier isEqualToString:@"showDetails"]) {
        
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        
        RemittanceTableViewController *rem = (RemittanceTableViewController *)segue.destinationViewController;
        
        Country *m = [[self fectched]objectAtIndexPath:indexPath];
        
        rem.country = m;//[m valueForKey:@"countryCode"];
        
        
    }
    
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"showDetails" sender:self];
}

-(UIImageView *)imageRound:(UIImageView *)imview;
{
    
    imview.layer.cornerRadius = 10;
    imview.layer.masksToBounds = YES;
    return imview;
    
    
//    UIGraphicsBeginImageContextWithOptions(imview.bounds.size, NO, [UIScreen mainScreen].scale);
//    
//    // Add a clip before drawing anything, in the shape of an rounded rect
//    
//    [[UIBezierPath bezierPathWithRoundedRect:imview.bounds
//                                cornerRadius:10.0 ] addClip];
//    // Draw your image
//    [imview.image drawInRect:imview.bounds];
//    
//    // Get the image, here setting the UIImageView image
//    imview.image = UIGraphicsGetImageFromCurrentImageContext();
//    
//    //            cell.imageView.layer.borderWidth  =1;
//    //            cell.imageView.layer.borderColor = [UIColor grayColor].CGColor;
//    //
//    // Lets forget about that we were drawing
//    
//    
//    UIGraphicsEndImageContext();
//    
//    return imview;
}

@end
