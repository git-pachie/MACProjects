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
                         @"Hindi kaba napapagod Hindi kaba napapagod Hindi kaba kaba napapagod Hindi kaba napapagod Hindi kaba napapagod Hindi kaba napapagod Vestibulum ligula quam, gravida ut convallis semper, bibendum in turpis. Break on objc_exception_throw to catch this in the debugger.The methods in the UIConstraintBasedLayoutDebugging \n\ncategory on UIView listed in <UIKit/UIView.h> may also be helpful.2014-08-13 18:49:34.816 TestCell3[9856:60b] Unable to simultaneously satisfy constraints123",@"Message",
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
    
    dic = [[NSDictionary alloc]initWithObjectsAndKeys:
           @"Duling Kaba kasi ayaw ko syo eh, anu ba gusto mo mangyari?",@"Message",
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
    
    
    
    //register cell identifier from custom cell NIB
    static NSString *CellIdentifier = @"Cell";
    MyXTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    NSDictionary *dic = [[NSDictionary alloc]init];
    dic = [mArray objectAtIndex:indexPath.row];
    
    //NSString *x = [dic objectForKey:@"Message"];
    
    cell.labelMessage.text = [dic objectForKey:@"Message"] ;
    [cell.labelMessage setNumberOfLines:0];
    [cell.labelMessage setLineBreakMode:NSLineBreakByWordWrapping];
    //[cell.labelMessage setBackgroundColor:[UIColor greenColor]];

    CGFloat width = 280;
    UIFont *font = [UIFont systemFontOfSize:13];
    NSAttributedString *attributedText =
    [[NSAttributedString alloc]
     initWithString:[dic objectForKey:@"Message"]
     attributes:@
     {
     NSFontAttributeName: font
     }];
    CGRect rect = [attributedText boundingRectWithSize:(CGSize){width, CGFLOAT_MAX}
                                               options:NSStringDrawingUsesLineFragmentOrigin
                                               context:nil];
    
    cell.labelMessage.attributedText = attributedText ;
    
    [cell.labelMessage setFrame:rect];
    
    [cell setFrame:rect];
    
    return cell;
       
    

}

- (NSString *)quotationTextForRow:(int)row {
    
    NSDictionary *dic = [[NSDictionary alloc]init];
    
    dic = [mArray objectAtIndex:row];
    
    return [dic objectForKey:@"Message"];
}



- (CGSize)sizeOfLabel:(UILabel *)label withText:(NSString *)text {
   // return [text sizeWithFont:label.font constrainedToSize:label.frame.size lineBreakMode:label.lineBreakMode];

    //NSString *text =  text;
    CGFloat width = 280;
    UIFont *font = [UIFont systemFontOfSize:13];
    NSAttributedString *attributedText =
    [[NSAttributedString alloc]
     initWithString:text
     attributes:@
     {
     NSFontAttributeName: font
     }];
    CGRect rect = [attributedText boundingRectWithSize:(CGSize){width, CGFLOAT_MAX}
                                               options:NSStringDrawingUsesLineFragmentOrigin
                                               context:nil];
    CGSize size = rect.size;
    
    return size;
}



-(float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //set width depending on device orientation
    self.cellPrototype.frame = CGRectMake(self.cellPrototype.frame.origin.x, self.cellPrototype.frame.origin.y, tableView.frame.size.width, self.cellPrototype.frame.size.height);
    
    CGFloat quotationLabelHeight = [self sizeOfLabel:self.cellPrototype.labelMessage withText:[self quotationTextForRow:indexPath.row]].height;
//    CGFloat attributionLabelHeight = [self sizeOfLabel:self.cellPrototype.labelMessage withText:[self attributionTextForRow:indexPath.row]].height;
    CGFloat padding = self.cellPrototype.labelMessage.frame.origin.y;
    
    CGFloat combinedHeight = padding + quotationLabelHeight + padding/2 + padding;
    CGFloat minHeight = padding + self.cellPrototype.labelMessage.frame.size.height + padding;
    
    return quotationLabelHeight+50;//MAX(combinedHeight, minHeight);


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
