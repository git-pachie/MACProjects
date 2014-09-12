//
//  CountryTableViewController.m
//  ToPeso
//
//  Created by pachie on 27/8/14.
//  Copyright (c) 2014 Private. All rights reserved.
//

#import "CountryTableViewController.h"
#import "CustomTableViewCell.h"

@interface CountryTableViewController ()
{
    NSMutableArray *mArray;
}


@end

@implementation CountryTableViewController

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
    
//    NSDictionary *dic = [[NSDictionary alloc]initWithObjectsAndKeys:
//                         @"Hindi kaba napapagod",@"Message",
//                         @"Jun 30, 2014 11:55 AM",@"SentDate",
//                         @"Kasi ayaw ko syo",@"Answer",
//                         @"Boy Basag",@"CreatedBy",
//                         nil];
//    
//    [mArray addObject:dic];
//    
//    dic = [[NSDictionary alloc]initWithObjectsAndKeys:
//           @"Duling Kaba",@"Message",
//           @"Jun 30, 2014 11:55 AM",@"SentDate",
//           @"Kasi baho mo eh",@"Answer",
//           @"Boy Konyat",@"CreatedBy",
//           nil];
//    
//    [mArray addObject:dic];
//    
    
    
    
//    mArray = [[NSMutableArray alloc]init];
//
    NSDictionary *dic = [[NSDictionary alloc]initWithObjectsAndKeys:
                         @"SGD",@"CountryCode",
                         @"Singapore",@"CountryName",
                         @"iRemit Singapore",@"RemittanceName",
                         @"123.56",@"Rate",
                         @"July 26, 2014 03:00 PM",@"AsOfDate",
                         @"85713568",@"Contact",
                         @"2nd flr, Lucky Plaza Singapore 750359",@"Address",
                         @"archieangeles@gmail.com",@"EmailAddress",
                         @"logo1.png",@"logo",nil];
    
    [mArray addObject:dic];
    
    dic = [[NSDictionary alloc]initWithObjectsAndKeys:
           @"SGD",@"CountryCode",
           @"Singapore",@"CountryName",
           @"PNB Singapore",@"RemittanceName",
           @"153.56",@"Rate",
           @"July 26, 2014 03:00 PM",@"AsOfDate",
           @"85713568",@"Contact",
           @"2nd flr, Lucky Plaza Singapore 750359",@"Address",
           @"archieangeles@gmail.com",@"EmailAddress",
           @"logo1.png",@"logo",nil];

    [mArray addObject:dic];

    
    dic = [[NSDictionary alloc]initWithObjectsAndKeys:
           @"SGD",@"CountryCode",
           @"Singapore",@"CountryName",
           @"Metro Remittance Singapore",@"RemittanceName",
           @"153.56",@"Rate",
           @"July 26, 2014 03:00 PM",@"AsOfDate",
           @"85713568",@"Contact",
           @"2nd flr, Lucky Plaza Singapore 750359",@"Address",
           @"archieangeles@gmail.com",@"EmailAddress",
           @"logo1.png",@"logo",nil];

    [mArray addObject:dic];
    
    dic = [[NSDictionary alloc]initWithObjectsAndKeys:
           @"DUB",@"CountryCode",
           @"Dhubai",@"CountryName",
           @"Metro Remittance Dhubai",@"RemittanceName",
           @"153.56",@"Rate",
           @"July 26, 2014 03:00 PM",@"AsOfDate",
           @"85713568",@"Contact",
           @"2nd flr, Lucky Plaza Singapore 750359",@"Address",
           @"archieangeles@gmail.com",@"EmailAddress",
           @"logo1.png",@"logo",nil];
    [mArray addObject:dic];
    
    dic = [[NSDictionary alloc]initWithObjectsAndKeys:
           @"MYR",@"CountryCode",
           @"Malaysia",@"CountryName",
           @"Metro Remittance Malaysia",@"RemittanceName",
           @"153.56",@"Rate",
           @"July 26, 2014 03:00 PM",@"AsOfDate",
           @"85713568",@"Contact",
           @"2nd flr, Lucky Plaza Singapore 750359",@"Address",
           @"archieangeles@gmail.com",@"EmailAddress",
           @"logo1.png",@"logo",nil];
    
    [mArray addObject:dic];


//
//    dic = [[NSDictionary alloc]initWithObjectsAndKeys:
//                         @"MYR",@"Country",
//                         @"Malaysia","CountryName",nil];
//    
//    [mArray addObject:dic];
//    
//    dic = [[NSDictionary alloc]initWithObjectsAndKeys:
//           @"IDR",@"Country",
//           @"Indonesia","CountryName",nil];
//    
//    [mArray addObject:dic];

    
    
 
    
 
    
    
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
    
  NSSet *uniqueStates = [NSSet setWithArray:[mArray valueForKey:@"CountryName"]];
//    
    return [uniqueStates count];
    
    
    
//    NSArray *states = [mArray valueForKey:@"CountryName"];
//    NSOrderedSet *orderedSet = [NSOrderedSet orderedSetWithArray:states];
//    NSSet *uniqueStates = [orderedSet set];
//    
//    return [uniqueStates count];
//
//    return [uniqueStates count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    //return  [[[mArray objectAtIndex:section]valueForKey:@"CountryName"] count];
    //NSSet *uniqueStates = [NSSet setWithArray:[mArray objectAtIndex:section] valueForKey:@"CountryName"] ;

    //return [[mArray objectAtIndex:section]count];
    
    //NSString *nameFilter = [NSString stringWithFormat:@"%@*", [mArray objectAtIndex:section]];
//    NSPredicate *resultPredicate = [NSPredicate predicateWithFormat:@"(DateCreatedSTR LIKE [cd]%@)", nameFilter];
//    return [[myObject filteredArrayUsingPredicate:resultPredicate] count] ;
//    

   // NSArray *sections = [mArray valueForKey:@"CountryName"];
   // NSOrderedSet *orderedSet = [NSOrderedSet orderedSetWithArray:sections];
    //NSSet *uniqueStates = [orderedSet set];
    
   // NSArray *ar = [orderedSet objectAtIndex:section];
    
    //return [ar count];
    
    //return [[mArray objectAtIndex:section] count];

    NSSet *unique = [NSSet setWithArray:[mArray valueForKey:@"CountryName"]];
    
    NSString *arUnique = [[unique allObjects] objectAtIndex:section];
    
    
    NSArray *ar = [mArray filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"CountryName like [cd] %@",arUnique]];
    
    return [ar count];
    
}

-(NSString *) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSSet *unique = [NSSet setWithArray:[mArray valueForKey:@"CountryName"]];
    
    NSString *arUnique = [[unique allObjects] objectAtIndex:section];
    
    return arUnique;

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 113;
}

/**/
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CustomTableViewCell *cell = (CustomTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];

    
    if (cell == nil)
    {
        //cell = [[PickupLineTableViewCell alloc] initWithStyle:uita reuseIdentifier:CellIdentifier];
        
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"View" owner:self options:nil];
        cell = (CustomTableViewCell *) [nib objectAtIndex:0];
        
    }

    
    NSSet *unique = [NSSet setWithArray:[mArray valueForKey:@"CountryName"]];
    
    NSString *arUnique = [[unique allObjects] objectAtIndex:indexPath.section];
    
    NSArray *ar = [mArray filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"CountryName like [cd] %@",arUnique]];
    
    
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"CountryName" ascending:YES];
    
    NSArray * sortedArray=[ar sortedArrayUsingDescriptors:@[sort]];
    
//    NSArray *sortedArray = [ar sortedArrayUsingComparator:^NSComparisonResult(NSString *p1, NSString *p2){
//        
//        return [p1 compare:p2];
//        
//    }];
    
    //NSArray * sortedArray = [ar sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    
    
    NSDictionary *dic = [sortedArray objectAtIndex:indexPath.row ];
    
    cell.lblRemmitanceName.text = [dic objectForKey:@"RemittanceName"];
    cell.lblRate.text = [dic objectForKey:@"Rate"];
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
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
