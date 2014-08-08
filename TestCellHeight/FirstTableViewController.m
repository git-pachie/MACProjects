//
//  FirstTableViewController.m
//  TestCellHeight
//
//  Created by pachie on 7/8/14.
//  Copyright (c) 2014 Private. All rights reserved.
//

#import "FirstTableViewController.h"

@interface FirstTableViewController ()
{
    NSMutableArray *mArray;
}

@end

@implementation FirstTableViewController

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
    
    self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.tableView.bounds.size.width, 0.01f)];
    
    mArray = [[NSMutableArray alloc] init];
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"Archie",@"Name",@"Male",@"Gender", nil];
    [mArray addObject:dic];
    
    dic = [NSDictionary dictionaryWithObjectsAndKeys:@"Angeles",@"Name",@"Male",@"Gender", nil];
    [mArray addObject:dic];
    
    dic = [NSDictionary dictionaryWithObjectsAndKeys:@"Anabelle Angeles, Anabelle Angeles Anabelle Angeles Anabelle Angeles Anabelle Angeles Anabelle Angeles Angeles Anabelle Angeles Anabelle Angeles Anabelle Angeles Angeles Anabelle Angeles  1234 ",@"Name",@"Male",@"Gender", nil];
    [mArray addObject:dic];
    
    dic = [NSDictionary dictionaryWithObjectsAndKeys:@"Anabelle Angeles, Anabelle Angeles Anabelle Angeles Anabelle Angeles Anabelle Angeles Anabelle Angeles Angeles Anabelle Angeles Anabelle Angeles Anabelle Angeles Angeles Anabelle Angeles  alex angeles butchokoy angeles Angeles Anabelle Angeles Anabelle Angeles Angeles Anabelle Angeles Anabelle Angeles Anabelle Angeles Angeles Anabelle Angeles  alex angeles 1234 ",@"Name",@"Male",@"Gender", nil];
    [mArray addObject:dic];
    
    dic = [NSDictionary dictionaryWithObjectsAndKeys:@"AAnabelle Angeles Angeles Anabelle Angeles  alex angeles butchokoy angeles 1234 ",@"Name",@"Male",@"Gender", nil];
    [mArray addObject:dic];
    
    dic = [NSDictionary dictionaryWithObjectsAndKeys:@" Anabelle Angeles  alex angeles butchokoy angeles 1234 ",@"Name",@"Male",@"Gender", nil];
    [mArray addObject:dic];

    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    // Configure the cell...
    
    NSDictionary *dic = [mArray objectAtIndex:indexPath.row];
    
    
    
    
    
    cell.textLabel.text = [dic objectForKey:@"Gender"];
    [cell.textLabel setBackgroundColor:[UIColor greenColor]];
    
    
    CGRect labelFrame = CGRectMake(0, 0, self.tableView.bounds.size.width , 60);
    
//    UILabel *myLabel = [[UILabel alloc] initWithFrame:labelFrame];
//    myLabel = [dic objectForKey:@"Name"];
//    
//    [myLabel setBackgroundColor:[UIColor orangeColor]];
//    
//    //[myLabel setText:labelText];
//    [myLabel setLineBreakMode:NSLineBreakByWordWrapping];
//    [myLabel setNumberOfLines:0];
//    [myLabel sizeToFit];
    
    [cell.detailTextLabel setFrame:labelFrame];

    
    
    
    
    cell.detailTextLabel.text = [dic objectForKey:@"Name"];
    
    
    [cell.detailTextLabel setNumberOfLines:0];
    [cell.detailTextLabel setLineBreakMode:NSLineBreakByWordWrapping];
//    
//
//    [cell.detailTextLabel setBackgroundColor:[UIColor redColor]];
//    [cell sizeToFit];
    
    
    //[cell setBackgroundColor:[UIColor purpleColor]];
    
    //cell.detailTextLabel.numberOfLines = 0;
   // [cell.detailTextLabel setLineBreakMode:NSLineBreakByWordWrapping];

    
//    CGRect labelFrame = CGRectMake(0, 0, 0, 0);
//    UILabel *myLabel = [[UILabel alloc] initWithFrame:labelFrame];
//    [myLabel setBackgroundColor:[UIColor orangeColor]];
//
//    NSString *labelText = [dic objectForKey:@"Name"];
//    [myLabel setText:labelText];
//
//    myLabel.textAlignment = NSTextAlignmentRight;
//    [myLabel setNumberOfLines:0];
//    [myLabel sizeToFit];
//    
//    [self.view addSubview:myLabel];
//    
//    [cell addSubview:myLabel];
    
    

    
    //cell.textLabel.textAlignment = nste;
    //[cell.textLabel sizeToFit];
    
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dic = [mArray objectAtIndex:indexPath.row];
    
    CGRect screenBound = [[UIScreen mainScreen] bounds];
    CGSize screenSize = screenBound.size;
    CGFloat screenWidth = screenSize.width;
    CGFloat screenHeight = screenSize.height;
    
    NSString *labelText = [dic objectForKey:@"Name"];
    

    
    
//    if (labelText.length <= 70) {
//        return 50;
//    }
//    else
//    {
        CGRect labelFrame = CGRectMake(0, 0, screenWidth , 60);
        UILabel *myLabel = [[UILabel alloc] initWithFrame:labelFrame];
        [myLabel setBackgroundColor:[UIColor orangeColor]];
        
        [myLabel setText:labelText];
        [myLabel setLineBreakMode:NSLineBreakByWordWrapping];
        [myLabel setNumberOfLines:0];
    
    //[myLabel setFrame:CGRectMake(0, 0, screenWidth , myLabel.numberOfLines *30)];
        //[myLabel sizeToFit];

        return myLabel.frame.size.height;

//    }
    
    //myLabel.textAlignment = NSTextAlignmentRight;
    
    
    
//
//    
//    NSAttributedString *aString = [[NSAttributedString alloc] initWithString:[dic objectForKey:@"Name"]];
//                                   
//    UITextView *calculationView = [[UITextView alloc] init];
//    
//    [calculationView setAttributedText:aString];
//    
//    NSUInteger length = [[calculationView text] length];
//    
//    
//
//    
//    
//    float size = 20;
//    
//    if (length <=35 && length >0) {
//        size = 25;
//    }
//    else if (length <=70 && length >=36)
//    {
//        size = 50;
//    }
//    else if (length <=95  && length >=71)
//    {
//        size = 75;
//    }
//    
//    else if (length <=130 && length >=91)
//    {
//        size = 100;
//    }
//    
//    else if (length <=165 && length >=131 )
//    {
//        size = 125;
//    }
//    
//    else if (length >=165 && length <=200 )
//    {
//        size = 150;
//    }
//    
//    else if (length >=201 && length <=235 )
//    {
//        size = 175;
//    }
//    
//    
//      return size;
//    
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
