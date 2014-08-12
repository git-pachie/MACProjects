//
//  MyTableViewController.m
//  TestCell3
//
//  Created by pachie on 12/8/14.
//  Copyright (c) 2014 Private. All rights reserved.
//

#import "MyTableViewController.h"
#import "MyXTableViewCell.h"

@interface MyTableViewController ()
{
    NSMutableArray *mArray;
}

@end

@implementation MyTableViewController

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
    mArray = [[NSMutableArray alloc]init];
    
    NSDictionary *dic = [[NSDictionary alloc]initWithObjectsAndKeys:
                         @"Hindi kaba napapagod Hindi kaba napapagod Hindi kaba kaba napapagod Hindi kaba napapagod Hindi kaba napapagod Hindi kaba napapagod 123",@"Message",
                         @"Jun 30, 2014 11:55 AM",@"SentDate",
                         @"Kasi ayaw ko syo",@"Answer",
                         @"Boy Basag",@"CreatedBy",
                         nil];
    
    [mArray addObject:dic];
    
    dic = [[NSDictionary alloc]initWithObjectsAndKeys:
           @"Duling Kaba",@"Message",
           @"Jun 30, 2014 11:55 AM",@"SentDate",
           @"Kasi baho mo eh",@"Answer",
           @"Boy Konyat",@"CreatedBy",
           nil];
    
    [mArray addObject:dic];
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


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyXTableViewCell *cell = (MyXTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
 
    // Configure the cell...
    
    
    NSDictionary *dic = [[NSDictionary alloc]init];
    dic = [mArray objectAtIndex:indexPath.row];
    
    NSString *x = [dic objectForKey:@"Message"];

    cell.labelMessage.text = [dic objectForKey:@"Message"] ;
    [cell.labelMessage setNumberOfLines:0];
    [cell.labelMessage setLineBreakMode:NSLineBreakByWordWrapping];
    [cell.labelMessage setBackgroundColor:[UIColor greenColor]];
    
    CGSize maxlabel = CGSizeMake(283, FLT_MAX);
    
    CGSize expected =[ x sizeWithFont:[UIFont systemFontOfSize:18 ] constrainedToSize:maxlabel lineBreakMode:NSLineBreakByWordWrapping];
    
    
    
    
    CGSize size = [[dic objectForKey:@"Message"] sizeWithFont:[UIFont systemFontOfSize:18]
                                            constrainedToSize:CGSizeMake(283,cell.labelMessage.frame.size.height)];
    CGRect rec = CGRectMake(10, 10, size.width, size.height);
    CGRect rec2 = CGRectMake(10, 10, size.width, size.height);
    
    [cell.labelMessage setFrame:rec];
    [cell setFrame:rec2];

    
    NSLog(@"Height= %f",cell.labelMessage.frame.size.height);
    
    return cell;
}


    
    
//-(float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    NSDictionary *dic = [[NSDictionary alloc]init];
//    dic = [mArray objectAtIndex:indexPath.row];
//    
//    
//        UILabel *label = [[UILabel alloc]init];
//        label.text = [dic objectForKey:@"Message"];
//        [label setNumberOfLines:0];
//        [label setLineBreakMode:NSLineBreakByWordWrapping];
//    
//    
//    //NSString *text = [dic objectForKey:@"Message"];
//    
//    CGSize size = [[dic objectForKey:@"Message"] sizeWithFont:[UIFont systemFontOfSize:18]
//                                            constrainedToSize:CGSizeMake(340,label.frame.size.height+20)];
//
////    
////    
//    NSLog(@"Height %f",size.height + 20);
////    
////    CGSize size = [label]
//    
//    return size.height;
//}

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
