//
//  AgentDetailsTableViewController.m
//  ToPeso
//
//  Created by pachie on 13/9/14.
//  Copyright (c) 2014 Private. All rights reserved.
//

#import "AgentDetailsTableViewController.h"
#import <Social/Social.h>
#import "CoreDataToPeso.h"
#import "com_pachie_topesoAppDelegate.h"
#import "EntNotification.h"
#import "SendAndRequest.h"

@interface AgentDetailsTableViewController ()

{
    com_pachie_topesoAppDelegate * delegate;
    CoreDataToPeso *core;
    EntNotification *notifcation;
    SendAndRequest *send;
    bool preNotificationValue;
}

@end

@implementation AgentDetailsTableViewController

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
    
    delegate = (com_pachie_topesoAppDelegate *)[[UIApplication sharedApplication]delegate];
    
    core = [[CoreDataToPeso alloc]init];
    send  = [[SendAndRequest alloc]init];
    
    self.lblAgentName.text = self.remitanceAgent.remittanceName;
    self.lblAgentAddress.text = self.remitanceAgent.address;
    self.lblAgentContact.text =[NSString stringWithFormat:@"Contact: %@",self.remitanceAgent.contact];
    
    
    NSNumberFormatter *numFormat = [[NSNumberFormatter alloc]init];
    [numFormat setNumberStyle:NSNumberFormatterDecimalStyle];
    self.lblCurrentRate.text = [numFormat stringFromNumber:self.remitanceAgent.rate];
    
    
    NSDateFormatter *dateFormate = [[NSDateFormatter alloc]init];
    [dateFormate setDateFormat:@"dd MMMM yyyy hh:mm a"];
    NSTimeZone *gmt = [NSTimeZone timeZoneWithAbbreviation:@"GMT"];
    
    [dateFormate setTimeZone:gmt];
    
    
    
    
    self.lblAsOfDate.text =[NSString stringWithFormat:@"As of date %@",[dateFormate stringFromDate:self.remitanceAgent.asofDate]];
    
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                         NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString* path = [documentsDirectory stringByAppendingPathComponent:
                       self.remitanceAgent.logo];
    UIImage* image = [UIImage imageWithContentsOfFile:path];
    
    
    
    if (image == nil) {
        image = [UIImage imageNamed:@"default.png"];
    }
    
    self.imgAgentPhoto.image = image;// [UIImage imageNamed:@"default.png"];
    self.imgAgentPhoto.layer.cornerRadius = 10;
    self.imgAgentPhoto.clipsToBounds = YES;
    self.imgAgentPhoto.layer.borderWidth = 0.4;
    self.imgAgentPhoto.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    
    
    [self.btnFB setFrame:CGRectMake(0, 0, 50, 50)];
    [self.btnTweeter setFrame:CGRectMake(0, 0, 50, 50)];
    [self.btnEmail setFrame:CGRectMake(0,0,50,50)];
    [self.btnSMS setFrame:CGRectMake(0,0,50,50)];
   
    notifcation = [[EntNotification alloc]init];
    
    notifcation.countryCode =  self.remitanceAgent.countryCode;
    notifcation.remittanceGUID = self.remitanceAgent.remmittanceGUID;
    notifcation.currencyKey = self.remitanceAgent.currencyKey;
    notifcation.lastUpdated= [NSDate date];
    notifcation.countryName = self.country.countryName;
    notifcation.agentName = self.remitanceAgent.remittanceName;

    self.swNotification.on = [core isNotificationExist:notifcation];
    
    preNotificationValue = self.swNotification.on;
    
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

    return 4;
}


//-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    UITableViewCell *cell =(UITableViewCell *) [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
//    
//    
//    return  cell;
//}

- (IBAction)acFB:(id)sender {
    
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook])
    {
        SLComposeViewController *facebook = [SLComposeViewController
                                               composeViewControllerForServiceType:SLServiceTypeFacebook];
        
        
//        [facebook setInitialText:[NSString stringWithFormat:@"%@ %@ %@ - %@, Install toPiso iOS application to get the latest conversion of foreign currencies to Philippine peso.",self.remitanceAgent.currencyKey,@"123.25",self.remitanceAgent.countryCode,self.remitanceAgent.remittanceName]];
//        
//        [facebook addImage:[UIImage imageNamed:@"ToPiso_120x120.png"]];
//        [facebook addURL:[NSURL URLWithString:@"http://www.toIpiso.com"]];
//        
//        
//        UIImageView *imgv = [[UIImageView alloc]init];
//        imgv.image = [UIImage imageNamed:@"ToPiso_120x120.png"];
//        imgv.layer.cornerRadius = 10;
//        imgv.clipsToBounds = YES;
//        imgv.layer.borderWidth = 1;
//        [imgv.layer setBorderColor:[UIColor lightGrayColor].CGColor];
//        
//        
//        [facebook addImage:imgv.image];
//        [facebook addURL:[NSURL URLWithString:@"http://www.toPiso.com"]];

        [self prepareSocialMessage:facebook];
        
        [self presentViewController:facebook animated:YES completion:nil];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Facebook not configured" message:@"Unable to continue, your facebook account not yet configured. Please configure it in settings menu" delegate:nil cancelButtonTitle:@"Close" otherButtonTitles:nil];//, nil
        [alert show];
    }
   
    
    
}

- (IBAction)acTweeter:(id)sender {
    
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter])
    {
        SLComposeViewController *tweeter = [SLComposeViewController
                                             composeViewControllerForServiceType:SLServiceTypeTwitter];
        
//        NSNumberFormatter *numFormat = [[NSNumberFormatter alloc]init];
//        [numFormat setNumberStyle:NSNumberFormatterDecimalStyle];
//        
//        NSString *strNumber = [numFormat stringFromNumber:self.remitanceAgent.rate];
//        
//        [tweeter setInitialText:[NSString stringWithFormat:@"%@ %@ %@ - %@, Install toPiso iOS application to get the latest conversion of foreign currencies to Philippine peso. \n",self.remitanceAgent.currencyKey,strNumber,self.remitanceAgent.countryCode,self.remitanceAgent.remittanceName]];
//        
//        UIImageView *imgv = [[UIImageView alloc]init];
//        imgv.image = [UIImage imageNamed:@"ToPiso_120x120.png"];
//        imgv.layer.cornerRadius = 10;
//        imgv.clipsToBounds = YES;
//        imgv.layer.borderWidth = 0.4;
//        [imgv.layer setBorderColor:[UIColor lightGrayColor].CGColor];
//        
//        
//        [tweeter addImage:imgv.image];
//        [tweeter addURL:[NSURL URLWithString:@"http://www.toPiso.com"]];
        
        [self prepareSocialMessage:tweeter];
        
        [self presentViewController:tweeter animated:YES completion:nil];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Twitter not configured" message:@"Unable to continue, your twitter account not yet configured. Please configure it in settings menu" delegate:nil cancelButtonTitle:@"Close" otherButtonTitles:nil];//, nil
        [alert show];
    }
    
}

- (IBAction)acEmail:(id)sender {
    // Email Subject
    NSString *emailTitle = @"toPiso iOS application";
    // Email Content
    NSString *messageBody =[NSString stringWithFormat:@"<h4>%@</h4>",[self generateSMSBody]] ; // Change the message body to HTML
    // To address
    //NSArray *toRecipents = [NSArray arrayWithObject:@"support@appcoda.com"];
    
    MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
    mc.mailComposeDelegate = self;
    [mc setSubject:emailTitle];
    [mc setMessageBody:messageBody isHTML:YES];
    //[mc setToRecipients:toRecipents];
    
    // Present mail view controller on screen
    [self presentViewController:mc animated:YES completion:NULL];
}

- (IBAction)swNotification:(id)sender {
    
    NSDateFormatter *dformat = [[NSDateFormatter alloc]init];
    [dformat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *strDate = [dformat stringFromDate:[NSDate date]];
    
    
    
       bool onOff;
    
    
    
    if (self.swNotification.on) {
        
        onOff = YES;
  
    }
    else
    {
        onOff = NO;
        //[core insertUpdateNotification:notifcation EnableDisable:NO];
    }
    
    
    NSString *strOnOff;
    
    if (onOff== true) {
        strOnOff = @"true";
    }
    else
    {
        strOnOff = @"false";
    }
    
    NSDictionary *payloadDict = [NSDictionary dictionaryWithObjectsAndKeys:
                                 @"", @"notificationGUID"
                                 , delegate.DevinceToken, @"deviceUDID"
                                 , self.remitanceAgent.remmittanceGUID,@"remittanceGUID"
                                 , self.remitanceAgent.remittanceName,@"agentName"
                                 , self.remitanceAgent.countryCode,@"countryCode"
                                 , self.country.countryName,@"countryName"
                                 , self.remitanceAgent.currencyKey,@"currencyKey"
                                 , strDate,@"lastUpdated"
                                 , strDate,@"dateCreated"
                                 , strOnOff,@"isInsertDelete",
                                 nil];

    
    NSString *strURL =[NSString stringWithFormat:@"%@/insertnotification", [send getToPisoURL]];
    [send syncNotificationToServer:[NSURL URLWithString:strURL] notificationData:payloadDict CompletionBlock:^(bool succeeded, NSError *error) {
     
        if (succeeded) {
            [core insertUpdateNotification:notifcation EnableDisable:onOff];
        }
        else
        {
            //NSLog(@"not succeeded");
            
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Connection Error" message:@"Unable to connect to server" delegate:nil cancelButtonTitle:@"Close" otherButtonTitles:nil];//, nil
            
            [alert show];
            
            self.swNotification.on = preNotificationValue;
            
        }
        
    }];
    
}

- (void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    switch (result)
    {
        case MFMailComposeResultCancelled:
            NSLog(@"Mail cancelled");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Mail saved");
            break;
        case MFMailComposeResultSent:
            NSLog(@"Mail sent");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail sent failure: %@", [error localizedDescription]);
            break;
        default:
            break;
    }
    
    // Close the Mail Interface
    [self dismissViewControllerAnimated:YES completion:NULL];
}


- (IBAction)acFlicker:(id)sender {
    
    MFMessageComposeViewController *controller = [[MFMessageComposeViewController alloc] init];
	if([MFMessageComposeViewController canSendText])
	{
		controller.body = [self generateSMSBody];
		//controller.recipients = [NSArray arrayWithObjects:@"85713568", nil];
		controller.messageComposeDelegate = self;
		//[self presentModalViewController:controller animated:YES];
        
        
        [self presentViewController:controller animated:YES completion:nil];
	}
}

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
    switch (result) {
        case MessageComposeResultSent:
            NSLog(@"SENT");
            //[self dismissViewControllerAnimated:YES completion:nil];
            break;
        case MessageComposeResultFailed:
            NSLog(@"FAILED");
            //[self dismissViewControllerAnimated:YES completion:nil];
            break;
        case MessageComposeResultCancelled:
            NSLog(@"CANCELLED");
            
            break;
    }
    
    [self dismissViewControllerAnimated:YES completion:NULL];
    
    
}

-(void)alertView:(UIAlertView *)alertView willDismissWithButtonIndex:    (NSInteger)buttonIndex
{
    if(buttonIndex==0)
    {
        //Code that will run after you press ok button
        //[self.navigationController popViewControllerAnimated:YES ];
        //[self.navigationController popToRootViewControllerAnimated:YES];
    }
}

-(void)prepareSocialMessage:(SLComposeViewController*)controller
{
    
    NSNumberFormatter *numFormat = [[NSNumberFormatter alloc]init];
    [numFormat setNumberStyle:NSNumberFormatterDecimalStyle];
    
    NSString *strNumber = [numFormat stringFromNumber:self.remitanceAgent.rate];
    
    
    [controller setInitialText:[NSString stringWithFormat:@"%@ %@ - %@, Install toPiso iOS application to get the latest conversion of foreign currencies to Philippine peso.",self.remitanceAgent.currencyKey,strNumber,self.remitanceAgent.remittanceName]];
    
    [controller addImage:[UIImage imageNamed:@"ToPiso_120x120.png"]];
    [controller addURL:[NSURL URLWithString:@"http://www.toIpiso.com"]];
    
    
    UIImageView *imgv = [[UIImageView alloc]init];
    imgv.image = [UIImage imageNamed:@"ToPiso_120x120.png"];
    imgv.layer.cornerRadius = 10;
    imgv.clipsToBounds = YES;
    imgv.layer.borderWidth = 1;
    [imgv.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    
    
    [controller addImage:imgv.image];
    [controller addURL:[NSURL URLWithString:@"http://www.toPiso.com"]];
}
-(NSString *)generateSMSBody
{
    NSNumberFormatter *numFormat = [[NSNumberFormatter alloc]init];
    [numFormat setNumberStyle:NSNumberFormatterDecimalStyle];
    
    NSString *strNumber = [numFormat stringFromNumber:self.remitanceAgent.rate];
    
    
    return [NSString stringWithFormat:@"%@ %@ - %@, Install toPiso iOS application to get the latest conversion of foreign currencies to Philippine peso.",self.remitanceAgent.currencyKey,strNumber,self.remitanceAgent.remittanceName];

}
@end
