//
//  TableViewController.m
//  TestCallBAck
//
//  Created by pachie on 29/8/14.
//  Copyright (c) 2014 Private. All rights reserved.
//

#import "TableViewController.h"

@interface TableViewController ()
{
    NSMutableArray *ar ;

}

@end

@implementation TableViewController


- (void)executeRequestUrlString:(void (^)(NSDictionary *jsonData))block {
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    NSString *post = @"http://www.riverwayauto.com:1980/myjson/service1.svc/GetHiritMessage2";
    
    [request setURL:[NSURL URLWithString:post]];
    
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue currentQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                               //NSLog(@"dataAsString %@", [NSString stringWithUTF8String:[data bytes]]);
                               NSError *error1;
                               NSMutableDictionary * innerJson = [NSJSONSerialization
                                                                  JSONObjectWithData:data options:kNilOptions error:&error1
                                                                  ];
                               block(innerJson); // Call back the block passed into your method
                           }];
    
}

- (void)ConvertJsonToArrary:(NSDictionary *)dictionaryKo withBlock:(void (^)(NSMutableArray *jsonData1))block {
    
    NSMutableArray *myarray = [[NSMutableArray alloc]init];
    
    for (NSDictionary *dataDict in dictionaryKo) {
        NSString *messageGUID = [dataDict objectForKey:@"MessageGUID"];
        NSString *hiritMessage = [dataDict objectForKey:@"HiritMessage"];
        NSString *createdByUserName = [dataDict objectForKey:@"CreatedByUserName"];
        NSString *createdByDeviceID = [dataDict objectForKey:@"CreatedByDeviceID"];
        NSString *createdDate = [dataDict objectForKey:@"CreatedDate"];
        NSString *answer1 = [dataDict objectForKey:@"Answer1"];
        NSString *dateCreatedSTR = [dataDict objectForKey:@"DateCreatedSTR"];
        
        
        NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                      messageGUID, @"MessageGUID",
                      hiritMessage, @"HiritMessage",
                      createdByUserName,@"CreatedByUserName",
                      createdByDeviceID,@"CreatedByDeviceID",
                      //[self mfDateFromDotNetJSONString:createdDate], @"DateCreated",
                      [self mfDateFromDotNetJSONString:createdDate],@"DateCreated",
                      answer1, @"Answer1",
                      dateCreatedSTR,@"DateCreatedSTR",
                      nil];
        [myarray addObject:dictionary];

    }
    
    block(myarray);
    
}

-(NSDate *)mfDateFromDotNetJSONString:(NSString *)string {
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
    
    ar = [[NSMutableArray alloc]init];
    
    [self executeRequestUrlString:^(NSDictionary *jsonData) {
        //NSLog(@"%@",jsonData);
        
        [self ConvertJsonToArrary:jsonData withBlock:^(NSMutableArray *jsonData1)
        {
            [ar addObjectsFromArray:jsonData1];// = jsonData1;
        }];
        
        [self performSelector:@selector(Printo) withObject:ar afterDelay:0];
        
//        for (NSDictionary *dic in jsonData) {
//            NSLog(@"dic : %@", [dic objectForKey:@"Answer1"] );
//        }
    }];
    
    
    
    //NSLog(@"Call here second %@" ,ar);
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(void)Printo
{
    NSLog(@"%@",ar);
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

    return [ar count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    // Configure the cell...
    
    cell.textLabel.text = [[ar objectAtIndex:indexPath.row]objectForKey:@"Answer1"];
    
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
