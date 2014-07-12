//
//  HomeTableViewController.m
//  JSONTableParser
//
//  Created by Archie Angeles on 9/7/14.
//  Copyright (c) 2014 PachieOrg. All rights reserved.
//

#import "HomeTableViewController.h"
#import "DetailViewController.h"

@interface HomeTableViewController ()
{

NSMutableArray *myObject;
// A dictionary object
NSDictionary *dictionary;
// Define keys

    
    
    NSString *MessageGUID ;
    NSString *HiritMessage ;
    NSString *CreatedByUserName ;
    NSString *CreatedByDeviceID ;
    NSDate *CreatedDate;
    NSString *Answer1;

}

@end

@implementation HomeTableViewController

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
    
    
    MessageGUID = @"MessageGUID";
    HiritMessage = @"HiritMessage";
    CreatedByUserName = @"CreatedByUserName";
    CreatedByDeviceID = @"CreatedByDeviceID";
    CreatedDate=    [NSDate date];
    Answer1 = @"Answer";
    
    
    myObject = [[NSMutableArray alloc] init];
    
    NSData *jsonSource = [NSData dataWithContentsOfURL:
                          [NSURL URLWithString:@"http://www.amanawaterpark.ph:1980/myjson/service1.svc/GetHiritMessage"]];
    
    id jsonObjects = [NSJSONSerialization JSONObjectWithData:
                      jsonSource options:NSJSONReadingMutableContainers error:nil];
    
    for (NSDictionary *dataDict in jsonObjects) {
        NSString *messageGUID = [dataDict objectForKey:@"MessageGUID"];
        NSString *hiritMessage = [dataDict objectForKey:@"HiritMessage"];
        NSString *createdByUserName = [dataDict objectForKey:@"CreatedByUserName"];
        NSString *createdByDeviceID = [dataDict objectForKey:@"CreatedByDeviceID"];
        NSString *createdDate = [dataDict objectForKey:@"CreatedDate"];
        NSString *answer1 = [dataDict objectForKey:@"Answer1"];
        
        
        
        NSLog(@"MessageGUID: %@",messageGUID);
        NSLog(@"Message: %@",hiritMessage);
        NSLog(@"CreatedByUserName: %@",createdByUserName);
        NSLog(@"CreatedByDeviceID: %@",createdByDeviceID);
        NSLog(@"CreatedDate: %@",createdDate);
        

        
        dictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                      messageGUID, MessageGUID,
                      hiritMessage, HiritMessage,
                      createdByUserName,CreatedByUserName,
                      createdByDeviceID,CreatedByDeviceID,
                      [self mfDateFromDotNetJSONString:createdDate], @"DateCreated",
                      answer1, Answer1,
                      nil];
        [myObject addObject:dictionary];
    }
    
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
    return 1;//myObject.count;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
   // [self performSegueWithIdentifier:@"detail" sender:indexPath];
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return myObject.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    NSDictionary *tmpDict = [myObject objectAtIndex:indexPath.row];
    
    cell.textLabel.text = [tmpDict objectForKey:@"HiritMessage"];
    cell.detailTextLabel.text = [tmpDict objectForKey:@"CreatedDate"];
    
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
*/
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"detail"]) {
        
        
        //NSIndexPath *tmpDict = [self.tableView indexPathForSelectedRow]; // [myObject objectAtIndex:indexPath.row];
        
        //////NSDictionary *tmpDict = [myObject objectAtIndex:index(const char *, <#int#>)]
        
        ////cell.textLabel.text = [tmpDict objectForKey:@"thumbnail"];
        
       // NSIndexPath *ip = [self.tableView indexPathForSelectedRow];
        
        //vc.TemplateDetail = [[self dictionaryWithValuesForKeys:myObject] objectForKey:@"templateid"];
        
        NSIndexPath *path = [self.tableView indexPathForSelectedRow];
        
        DetailViewController *dv = segue.destinationViewController;
         NSLog(@"clPanelSeguePathRow = %ld", (long)path.row);
        NSLog(@"myobject = %@", [[myObject objectAtIndex:path.row] objectForKey:@"templateid"]);
//        NSIndexPath *indexPath = (NSIndexPath *)sender;
//        NSDictionary *tmpDict = [myObject objectAtIndex:indexPath.row];
        
        //klViewController *detailViewController = segue.destinationViewController;
        NSString *messageGUID = [NSString stringWithFormat:@"%@",[[myObject objectAtIndex:path.row] objectForKey:@"MessageGUID"]];
        NSString *hiritMessage = [NSString stringWithFormat:@"%@",[[myObject objectAtIndex:path.row] objectForKey:@"HiritMessage"]];
        NSString *createdBy = [NSString stringWithFormat:@"%@",[[myObject objectAtIndex:path.row] objectForKey:@"CreatedBy"]];
        
        NSString *answer1 = [NSString stringWithFormat:@"%@",[[myObject objectAtIndex:path.row] objectForKey:@"Answer"]];
        
        dv.MessageGUID = messageGUID;
        dv.HiritMessage = hiritMessage;
        dv.CreatedBy = createdBy;
        dv.Answer = answer1;
        
                
        
    }
}

- (NSDate *)mfDateFromDotNetJSONString:(NSString *)string {
    static NSRegularExpression *dateRegEx = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dateRegEx = [[NSRegularExpression alloc] initWithPattern:@"^\\/date\\((-?\\d++)(?:([+-])(\\d{2})(\\d{2}))?\\)\\/$" options:NSRegularExpressionCaseInsensitive error:nil];
    });
    NSTextCheckingResult *regexResult = [dateRegEx firstMatchInString:string options:0 range:NSMakeRange(0, [string length])];
    
    if (regexResult) {
        // milliseconds
        NSTimeInterval seconds = [[string substringWithRange:[regexResult rangeAtIndex:1]] doubleValue] / 1000.0;
        // timezone offset
        if ([regexResult rangeAtIndex:2].location != NSNotFound) {
            NSString *sign = [string substringWithRange:[regexResult rangeAtIndex:2]];
            // hours
            seconds += [[NSString stringWithFormat:@"%@%@", sign, [string substringWithRange:[regexResult rangeAtIndex:3]]] doubleValue] * 60.0 * 60.0;
            // minutes
            seconds += [[NSString stringWithFormat:@"%@%@", sign, [string substringWithRange:[regexResult rangeAtIndex:4]]] doubleValue] * 60.0;
        }
        
        return [NSDate dateWithTimeIntervalSince1970:seconds];
    }
    return nil;
}

@end
