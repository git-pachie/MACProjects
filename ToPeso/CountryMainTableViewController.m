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
#import "countryTableViewCell.h"

@interface CountryMainTableViewController ()
{
    com_pachie_topesoAppDelegate *del;
    UIRefreshControl *refreshControl;
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

-(void)refreshTable
{
    
    del = (com_pachie_topesoAppDelegate *)[[UIApplication sharedApplication]delegate];
    
    CoreDataToPeso *core = [[CoreDataToPeso alloc]init];
    //[core insertTempData];
    SendAndRequest *send = [[SendAndRequest alloc]init];
    
    NSString *lastModified = [core getLastUpdatedCountry];
    
    
    
    
    
    [send getLastesCountry:lastModified withBlock:^(NSArray *array, NSError *connectionError)
     {
         
         
         if (connectionError!=nil) {
             UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Connection Error" message:@"Unable to connect to fetched latest updates" delegate:self cancelButtonTitle:@"Close" otherButtonTitles:nil];//, nil
             
             [alert show];
             
         }
         else
         {
             //image
             
             
             if ([lastModified isEqualToString:@"-1"]) {
                 
                 
                 NSDictionary *dic = @{@"deviceUDID":del.DevinceToken};
                 NSString *strURL =[NSString stringWithFormat:@"%@/DeleteAllNotification", [send getToPisoURL]];
                 
                 [send deleteAllNotificationToServer:[NSURL URLWithString:strURL] notificationData:dic CompletionBlock:^(bool succeeded, NSError *error) {
                     NSLog(@"all notification deleted");
                 }];
             }

             
             
             
             
             for (NSDictionary *dic in array) {
                 NSString *strImg = [dic objectForKey:@"countryFlag"];
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
             
             
             
             
             [core syncCoreData:array];
             
             
         }
         
         NSError *error;
         if (![[self fectched] performFetch:&error]) {
             // Update to handle the error appropriately.
             NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
             exit(-1);  // Fail
         }
         
         [refreshControl endRefreshing];
         [self.tableView reloadData];
         
         
         
     }];
    
    
    
    
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"countryCell" bundle:nil] forCellReuseIdentifier:@"Cell"];
    
    refreshControl = [[UIRefreshControl alloc]init];
    
    [self.tableView addSubview:refreshControl];
    
    [refreshControl addTarget:self action:@selector(refreshTable) forControlEvents:UIControlEventValueChanged];
    
    
    
    [self refreshTable];
    
    NSLog(@"id: %@", del.DevinceToken);
   
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
    countryTableViewCell *cell = (countryTableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    if (cell == nil)
    {
        //cell = [[PickupLineTableViewCell alloc] initWithStyle:uita reuseIdentifier:CellIdentifier];
        
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"countryCell" owner:self options:nil];
        cell = (countryTableViewCell *) [nib objectAtIndex:0];
        
    }

    
    NSManagedObject *o = [self.fectched objectAtIndexPath:indexPath];
    
    cell.lblCountryName.text = [o valueForKey:@"countryName"];
    
    //cell.imageView.image = [UIImage imageNamed:[o valueForKey:@"countryFlag"]];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                         NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString* path = [documentsDirectory stringByAppendingPathComponent:
                      [o valueForKey:@"countryFlag"]];
    UIImage* image = [UIImage imageWithContentsOfFile:path];
    
    
    UIImageView *imgv =  [[UIImageView alloc]initWithImage:image];
    
    if (imgv.image == nil) {
        imgv.image = [UIImage imageNamed:@"default.png"];
    }
    
//    [cell.imgProfile setImage:[self imageRound:imgv].image];
//    
//    [self imageRound:cell.imgProfile];
    
    cell.imgProfile.image = imgv.image;
    [self imageRound:cell.imgProfile];
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
        
        
        if (del.isFromNotification == true) {
            
            
            rem.countryCode = del.notficationCountryCode;
            
            
        }
        
    }
    
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"showDetails" sender:self];
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
                                cornerRadius:10.0 ] addClip];
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

-(void)LoadFromNotification :(NSString *)remittanceGUID
{
    
    [self performSegueWithIdentifier:@"showDetails" sender:self];
    
}



#pragma mark iAd Deleage
//
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

@end
