//
//  MyPickupLineHeaderTableViewController.m
//  SampleJSON
//
//  Created by pachie on 8/8/14.
//  Copyright (c) 2014 PachieOrg. All rights reserved.
//

#import "MyPickupLineHeaderTableViewController.h"
#import "MyPickupLinesTableViewController.h"

@interface MyPickupLineHeaderTableViewController ()
{
    NSMutableArray *mArray;
}

@end

@implementation MyPickupLineHeaderTableViewController

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
    
    
    mArray = [[NSMutableArray alloc]init];
    
    NSDictionary *dic = [[NSDictionary alloc]initWithObjectsAndKeys:@"96641621",@"PhoneNumber", nil];
    
    [mArray addObject:dic];
    
    dic = [[NSDictionary alloc]initWithObjectsAndKeys:@"12345678",@"PhoneNumber", nil];
    
    [mArray addObject:dic];
    
    dic = [[NSDictionary alloc]initWithObjectsAndKeys:@"22222222",@"PhoneNumber", nil];
    
    [mArray addObject:dic];
    
    dic = [[NSDictionary alloc]initWithObjectsAndKeys:@"85713568",@"PhoneNumber", nil];
    
    [mArray addObject:dic];

}

-(void)viewDidAppear:(BOOL)animated
{
    [self.tableView reloadData];
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

    return [mArray count];
}

/**/
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"    forIndexPath:indexPath];
    
    // Configure the cell...
    
     NSDictionary *dic = [mArray objectAtIndex:indexPath.row];
    
    cell.textLabel.text = [dic objectForKey:@"PhoneNumber"];
    
    
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
    //pickupLineDetails
    if ([segue.identifier isEqualToString:@"pickupLineDetails"]) {
        
        NSIndexPath *path = [self.tableView indexPathForSelectedRow];
        
        MyPickupLinesTableViewController *dv = segue.destinationViewController;
        
        NSDictionary *dic = [mArray objectAtIndex:path.row];
        
        dv.PhoneNumber = [dic objectForKey:@"PhoneNumber"];
        dv.receipientName = [dic objectForKey:@"PhoneNumber"];
        
    }
}


@end
