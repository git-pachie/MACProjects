//
//  MyPickupLinesTableViewController.m
//  SampleJSON
//
//  Created by pachie on 8/8/14.
//  Copyright (c) 2014 PachieOrg. All rights reserved.
//

#import "MyPickupLinesTableViewController.h"
#import "MyTableViewCell.h"
#import "CommonFunction.h"
#import "AppDelegate.h"


@interface MyPickupLinesTableViewController ()

{
    NSMutableArray *mArray;
    CommonFunction *com;
    AppDelegate *del;
}

@end

@implementation MyPickupLinesTableViewController

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
    
    del = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    
    mArray = [[NSMutableArray alloc]init];
    com = [[CommonFunction alloc]init];
   
    [self.tableView registerNib:[UINib nibWithNibName:@"View" bundle:nil] forCellReuseIdentifier:@"Cell"];
    
    //self.PhoneNumber = @"96641621";
    //self.receipientName = @"96641621";
        
    UINavigationController *navCon  = (UINavigationController*) [self.navigationController.viewControllers objectAtIndex:1];
    navCon.navigationItem.title = self.receipientName;
    
    
    [self LoadMessage];
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
    MyTableViewCell *cell = (MyTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    NSDictionary *dic = [mArray objectAtIndex:indexPath.row];
    
    
//    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
//    [formatter setDateFormat:@"MMM dd, yyyy 'at' hh:mm a"];
    
    NSDate *date =  [com mfDateFromDotNetJSONString:[dic objectForKey:@"DateCreated"]];
    
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
    [dateFormatter setLocale:locale];
    [dateFormatter setDateFormat:@"EEE, dd MMM yyyy HH:mm a"];
    
    
    NSString *convertedDate = [dateFormatter stringFromDate:date];
    
    cell.labelSentReceivedDate.text = convertedDate;// [dic objectForKey:@"DateCreated"];
    cell.lablePickupLineHeader.text = [dic objectForKey:@"PickupLineContent"];
    cell.labelPickupLineAnswer.text = [dic objectForKey:@"PickupLineAnswer"];
    
    cell.labelCreatedby.text =[NSString stringWithFormat:@"Created By %@",[dic objectForKey:@"SenderPhoneNumber"]];
    
    if ([del.PhoneNumber isEqualToString:[dic objectForKey:@"ToPhoneNumber"]]) {
        cell.labelSendReceived.text = @"RECEIVED";
        [cell.labelSendReceived setBackgroundColor:[UIColor redColor]];
    }
    else
    {
        cell.labelSendReceived.text = @"SENT";
        UIColor *myColor=[[UIColor alloc]initWithRed:33/255.0 green:99/255.0 blue:66/255.0 alpha:1];
        [cell.labelSendReceived setBackgroundColor:myColor];
        
    }
    
    [cell.labelPickupLineAnswer setLineBreakMode:NSLineBreakByCharWrapping];
    [cell.labelPickupLineAnswer setNumberOfLines:2];
    
    [cell.lablePickupLineHeader setLineBreakMode:NSLineBreakByCharWrapping];
    [cell.lablePickupLineHeader setNumberOfLines:2];
    
    
    
    return cell;
}


#pragma mark - Table view data source

-(void)LoadMessage
{
    CommonFunction *common = [[CommonFunction alloc]init];
    NSString *x =  [common GetJsonConnection:[NSString stringWithFormat:@"GetMyMessageByNumber/%1@/%2@",self.PhoneNumber,del.PhoneNumber]];
    
    NSData *jsonSource = [NSData dataWithContentsOfURL:[NSURL URLWithString:x]];
    
    if ([common CheckNSD:jsonSource] == false) {
        
        UIAlertView* mes=[[UIAlertView alloc] initWithTitle:@"Connection Error"
                                                    message:@"Connection error" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        
        [UIApplication sharedApplication].networkActivityIndicatorVisible = false ;
        
        self.navigationItem.title = @"Network Error";
        
        
        
        [mes show];
        
        return;
    }
    
   
    
    id jsonObjects = [NSJSONSerialization JSONObjectWithData:
                      jsonSource options:NSJSONReadingMutableContainers error:nil];
    
    //countedSet = [NSCountedSet set];
    
    for (NSDictionary *dataDict in jsonObjects) {
        NSString *messageID = [dataDict objectForKey:@"MessageID"];
        NSString *senderPhoneNumber = [dataDict objectForKey:@"SenderPhoneNumber"];
        NSString *toPhoneNumber = [dataDict objectForKey:@"ToPhoneNumber"];
        NSString *pickupLineGUID = [dataDict objectForKey:@"PickupLineGUID"];
        NSString *pickupLineContent = [dataDict objectForKey:@"PickupLineContent"];
        NSString *pickupLineAnswer = [dataDict objectForKey:@"PickupLineAnswer"];
        NSString *isRead = [dataDict objectForKey:@"IsRead"];
        NSString *dateCreated = [dataDict objectForKey:@"DateCreated"];
        
        NSDictionary *dictionary = [[NSDictionary alloc]initWithObjectsAndKeys:             messageID,@"MessageID"
                                    ,senderPhoneNumber,@"SenderPhoneNumber"
                                    ,toPhoneNumber,@"ToPhoneNumber"
                                    ,pickupLineGUID,@"PickupLineGUID"
                                    ,pickupLineContent,@"PickupLineContent"
                                    ,pickupLineAnswer,@"PickupLineAnswer"
                                    ,isRead,@"IsRead"
                                    ,dateCreated,@"DateCreated"
                                    ,nil];
        
        [mArray addObject:dictionary];
        
        //[countedSet addObject:dateCreatedSTR];
        
        
    }
}

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
