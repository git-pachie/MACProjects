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

@interface PhoneBookTableViewController ()
{
    NSMutableArray *mArary;
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
    
    
    if (ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusDenied
        || ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusRestricted) {
        NSLog(@"Denied");
        
      
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"No Permission" message:@"Unable to access your contacts." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        
        [alert show];
        
    }
    else if (ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusAuthorized)
    {
        NSLog(@"Granted");
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
        }
    });
    
    }
    
//    [self.tableView setContentInset:UIEdgeInsetsMake(64, 0, 0, 0)];
//    self.tabBarController.navigationItem.title =@"Select Contact";
//    self.tabBarController.navigationItem.title =@"fafda";
    
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

    return [mArary count];
}

/**/
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    // Configure the cell...
    
    EntityPerson *person = [[EntityPerson alloc]init];
    
    person = [mArary objectAtIndex:indexPath.row];
    
    cell.textLabel.text = person.Name;
    cell.detailTextLabel.text = person.Number;
    
    
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.selectedPerson = [mArary objectAtIndex:indexPath.row];
    
    EntityPerson *p = self.selectedPerson;
    
    
    
    NSString *number = [p.Number stringByReplacingOccurrencesOfString:@"(" withString:@""];
    
    number = [number stringByReplacingOccurrencesOfString:@")" withString:@""];
    
    number = [number stringByReplacingOccurrencesOfString:@"-" withString:@""];
    
    number = [number stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    
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

@end
