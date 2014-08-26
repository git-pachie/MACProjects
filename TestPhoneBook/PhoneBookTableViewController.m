//
//  PhoneBookTableViewController.m
//  TestPhoneBook
//
//  Created by pachie on 11/8/14.
//  Copyright (c) 2014 Private. All rights reserved.
//

#import "PhoneBookTableViewController.h"
#import "PhoneContactClass.h"
#import "EntityPerson.h"
#import "Venu.h"
#import "CommonFunction.h"

@interface PhoneBookTableViewController ()
{
    NSMutableArray *mArary;
    NSArray *mArarySearch;
    dispatch_queue_t myQ2;
    Venu *venu;
}

@end

@implementation PhoneBookTableViewController

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
    
    venu = [[Venu alloc]init];
    
    
    
    if (!myQ2) {
        myQ2 = dispatch_queue_create("loadimage",NULL);
    }
    
    mArarySearch = [[NSArray alloc]init];
    
    if (ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusDenied
        || ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusRestricted) {
        NSLog(@"Denied");
        
      
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"No Permission" message:@"Unable to access your contacts." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        
        [alert show];
        
    }
    else if (ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusAuthorized)
    {
        NSLog(@"Granted");
        [self OK];
    }
    else
    {
       
    ABAddressBookRequestAccessWithCompletion(ABAddressBookCreateWithOptions(NULL, nil), ^(bool granted, CFErrorRef error) {
        if (!granted) {
            NSLog(@"Denied");
        }
        else
        {
            NSLog(@"Just granted");
            
            [self OK];
        }
    });
    
    }
    
//    [self.tableView setContentInset:UIEdgeInsetsMake(64, 0, 0, 0)];
//    self.tabBarController.navigationItem.title =@"Select Contact";
//    self.tabBarController.navigationItem.title =@"fafda";
    
    

}

-(void)OK
{
    dispatch_queue_t myQ;
    
    if (!myQ) {
        myQ = dispatch_queue_create("testq",NULL);
    }
    
    
    dispatch_async(myQ, ^{
        [self loaddata];
    });
}


-(void)loaddata
{
    dispatch_async(dispatch_get_main_queue(), ^{
        
        mArary = [PhoneContactClass GetPhoneContact];
        [self.tableView reloadData];
        
        
//        for (EntityPerson *p in mArary) {
//            NSLog(@"Name :%@",p.Name);
//            NSLog(@"Number :%@",p.Number);
//        }
        
        //[self.tableView reloadData];
    });
    
    //[self.tableView reloadData];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    //dispatch_async(dispatch_get_main_queue(), ^{
        return 1;
   // });
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    //return [mArary count];
    
    
    if (tableView == self.searchDisplayController.searchResultsTableView)
    {
        return [mArarySearch count];
        
    } else {
        
        return [mArary count];
    }

}

/**/
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
//    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }

    
    EntityPerson *person = [[EntityPerson alloc]init];
    
    if (tableView == self.searchDisplayController.searchResultsTableView)
    {
        person = [mArarySearch objectAtIndex:indexPath.row];
    }
    else{
        person = [mArary objectAtIndex:indexPath.row];
    }
    
    
    
    cell.textLabel.text = person.Name;
    
    cell.detailTextLabel.text = person.Number;
    
    //NSDictionary *item = (NSDictionary *)[self.content objectAtIndex:indexPath.row];
    //NSString *imagepath = [[NSBundle mainBundle] pathForResource:[item objectForKey:@"profile.png"] ofType:@"png"];
    //UIImage *theImage = [UIImage imageWithContentsOfFile:imagepath];
    
    
    
    //cell.imageView.image = [UIImage imageNamed:@"profile.png"];
    
//    [cell.imageView setimage  setImageWithURL:[NSURL URLWithString:@"http://www.domain.com/path/to/image.jpg"]
//                   placeholderImage:[UIImage imageNamed:@"placeholder.png"]
//                          completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {... completion code here ...}];
//
    
    
//
    //venu = ((Venu * )mArary [indexPath.row]);
    
   
       // cell.imageView.image = venue.image;
   
//    if (!cell.imageView.image) {
//        cell.imageView.image = venu.image;
//    }
    
    cell.imageView.image = [UIImage imageNamed:@"profile.png"];
    
    
    // download the image asynchronously
    
    NSString *userImage = [CommonFunction ProfieImageURLByPhone:person.Number];
    
    NSLog(@"userimage %@",userImage);
    
    [self downloadImageWithURL:[NSURL URLWithString:userImage] completionBlock:^(BOOL succeeded, UIImage *image) {
        if (succeeded) {
            // change the image in the cell
            //ImageToProcess.clipsToBounds = YES;
            //cell.imageView.layer.borderWidth = 1;
            //cell.imageView.layer.borderColor = [UIColor whiteColor].CGColor;
            
            //cell.imageView.image.size =  cell.imageView.frame.size - 4;
            //venu.image = image;
            
            //UIImage *yourImage = [UIImage imageWithData:image];
            //UIImageView *imageViewToPutInCell = [[UIImageView alloc] initWithImage:image];
            //imageViewToPutInCell.frame = CGRectMake(0, 0, 5, 5);
            
            //cell.imageView.image = image;
            
            //[cell.imageView  setImage:imageViewToPutInCell.image];
            //cell.imageView.frame = imageViewToPutInCell.frame;
            //cell.imageView.layer.cornerRadius = 10;//cell.imageView.frame.size.width/2;// self.profileImageView.frame.size.width / 2
            //cell.imageView.clipsToBounds = YES;
            
            
            // Get your image somehow
            //UIImage *image = [UIImage imageNamed:@"image.jpg"];
            
                        // cache the image for use later (when scrolling up)
            //venue.image = image;
            //NSLog(@"image ok");
            
            cell.imageView.image = image;
            
            
            
            // Begin a new image that will be the new image with the rounded corners
            // (here with the size of an UIImageView)
            UIGraphicsBeginImageContextWithOptions(cell.imageView.bounds.size, NO, [UIScreen mainScreen].scale);
            
            // Add a clip before drawing anything, in the shape of an rounded rect
            
            [[UIBezierPath bezierPathWithRoundedRect:cell.imageView.bounds
                                        cornerRadius:cell.imageView.frame.size.width/2 ] addClip];
            // Draw your image
            [cell.imageView.image drawInRect:cell.imageView.bounds];
            
            // Get the image, here setting the UIImageView image
            cell.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
            
//            cell.imageView.layer.borderWidth  =1;
//            cell.imageView.layer.borderColor = [UIColor grayColor].CGColor;
//            
            // Lets forget about that we were drawing
            
            
            UIGraphicsEndImageContext();
            
            
        }
        
        
        
    }];
    
    
    //cell.imageView.image = [UIImage imageNamed:@"profile.png"];
    
    
    
    
    
    return cell;
}



- (void)downloadImageWithURL:(NSURL *)url completionBlock:(void (^)(BOOL succeeded, UIImage *image))completionBlock
{
    
   
        
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
        [NSURLConnection sendAsynchronousRequest:request
                                           queue:[NSOperationQueue mainQueue]
                               completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                                   if ( !error )
                                   {
                                       UIImage *image = [[UIImage alloc] initWithData:data];
                                       completionBlock(YES,image);
                                   } else{
                                       completionBlock(NO,nil);
                                   }
                               }];
   
    
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.searchDisplayController.searchResultsTableView)
    {
        self.selectedPerson = [mArarySearch objectAtIndex:indexPath.row];
    }
    else
    {
        self.selectedPerson = [mArary objectAtIndex:indexPath.row];
    }
    
    
    EntityPerson *p = self.selectedPerson;
    
    
    
    NSString *number = [p.Number stringByReplacingOccurrencesOfString:@"(" withString:@""];
    
    number = [number stringByReplacingOccurrencesOfString:@")" withString:@""];
    
    number = [number stringByReplacingOccurrencesOfString:@"-" withString:@""];
    
    number = [number stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    number = [number stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    
    number = [number substringFromIndex:[number length]-8];

    
    
    
    p.Number = number;
    
    
    [self.Xdelexgate GetSelectedPerson:p];
    
    
    [self.navigationController popViewControllerAnimated:YES];

    //[self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
    
    
    
    
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

/*
 #pragma mark - Filter
 */
// Search Filter
- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
{
    
    NSString *nameFilter = [NSString stringWithFormat:@"%@*", searchText];
    //NSString *desFilter = [NSString stringWithFormat:@"*%@*", searchText];
    
    NSPredicate *resultPredicate = [NSPredicate
                                    predicateWithFormat:@"(Name LIKE [cd]%@) or FirstName LIKE[cd]%@ or LastName LIKE[cd]%@",
                                    nameFilter,nameFilter,nameFilter];
    
    mArarySearch = [mArary filteredArrayUsingPredicate:resultPredicate];
    
    
}




-(BOOL)searchDisplayController:(UISearchDisplayController *)controller
shouldReloadTableForSearchString:(NSString *)searchString
{
    [self filterContentForSearchText:searchString
                               scope:[[self.searchDisplayController.searchBar scopeButtonTitles]
                                      objectAtIndex:[self.searchDisplayController.searchBar
                                                     selectedScopeButtonIndex]]];
    
    return YES;
}

@end
