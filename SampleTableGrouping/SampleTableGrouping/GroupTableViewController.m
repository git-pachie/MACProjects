//
//  GroupTableViewController.m
//  SampleTableGrouping
//
//  Created by pachie on 18/7/14.
//  Copyright (c) 2014 Private. All rights reserved.
//

#import "GroupTableViewController.h"

@interface GroupTableViewController ()
{
    NSMutableArray *MyArray;
}

@end

@implementation GroupTableViewController

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
    
    MyArray = [[NSMutableArray alloc]init];
    
    NSArray *FirstArray = [[NSArray alloc]initWithObjects:@"One",@"Two", nil];
    NSDictionary *FirstDictionary = [NSDictionary dictionaryWithObject:FirstArray forKey:@"data"];
    
    [MyArray addObject:FirstDictionary];
    
    NSArray *SecondArray = [[NSArray alloc]initWithObjects:@"three",@"four", nil];
    NSDictionary *SecondDictionary = [NSDictionary dictionaryWithObject:SecondArray forKey:@"data2"];
    
    [MyArray addObject:SecondDictionary];
    
    }

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
//#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return MyArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//#warning Incomplete method implementation.
    // Return the number of rows in the section.
    //return 0;
    NSDictionary *dictionary = [MyArray objectAtIndex:section];
    //NSArray *array = [dictionary objectForKey:@"data"];
    NSArray *array = [dictionary allKeys];
    
    return [[dictionary objectForKey:[array objectAtIndex:0]] count];
    //return array.count;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
//    if (section==0) {
//        return @"Section 1";
//    }
//    else if(section ==3)
//    {
//        return @"Section 2";
//    }
//    else
//    {
//        return @"Nothing";
//    }
    
    NSDictionary *dictionary = [MyArray objectAtIndex:section];
    
    NSArray *array = [dictionary allKeys];
    
    NSString *result = [array objectAtIndex:0];
    //....
    return result;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    NSDictionary *dictionary = [MyArray objectAtIndex:indexPath.section];
    //NSArray *array = [dictionary objectForKey:@"data"];
    
    NSArray *array = [dictionary objectForKey:[[dictionary allKeys] objectAtIndex:0]];
    //NSArray *array = [dictionary allKeys];
    
    
    
    NSString *cellValue = [array objectAtIndex:indexPath.row];
    cell.textLabel.text = cellValue;
    
    return cell;
}
/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:; forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

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
