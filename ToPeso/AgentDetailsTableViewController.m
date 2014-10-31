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
#import "CommonFunction.h"
#import "CommonAddMob.h"

@interface AgentDetailsTableViewController ()

{
    com_pachie_topesoAppDelegate * delegate;
    CoreDataToPeso *core;
    EntNotification *notifcation;
    SendAndRequest *send;
    bool preNotificationValue;
    commonAddMob *_commonAddMob;
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
    _commonAddMob = [[commonAddMob alloc]init];
    
    core = [[CoreDataToPeso alloc]init];
    send  = [[SendAndRequest alloc]init];
    
    self.lblAgentName.text = self.remitanceAgent.remittanceName;
//    self.lblAgentAddress.text = self.remitanceAgent.address;
//    self.lblAgentContact.text =[NSString stringWithFormat:@"Contact: %@",self.remitanceAgent.contact];
    self.lblCurrencyKey.text = self.remitanceAgent.currencyKey;
    
    
    NSNumberFormatter *numFormat = [[NSNumberFormatter alloc]init];
    [numFormat setNumberStyle:NSNumberFormatterDecimalStyle];
    [numFormat setMaximumFractionDigits:2];
    [numFormat setMinimumFractionDigits:2];
    
    //NSString *strRate =  [NSString stringWithFormat:@"%02d", self.remitanceAgent.rate];
    
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
    
    
    self.btnFB.layer.opacity=.90;
    self.btnTweeter.layer.opacity = .90;
    self.btnSMS.layer.opacity = .90;
    self.btnEmail.layer.opacity = .90;
   
    notifcation = [[EntNotification alloc]init];
    
    notifcation.countryCode =  self.remitanceAgent.countryCode;
    notifcation.remittanceGUID = self.remitanceAgent.remmittanceGUID;
    notifcation.currencyKey = self.remitanceAgent.currencyKey;
    notifcation.lastUpdated= [NSDate date];
    notifcation.countryName = self.country.countryName;
    notifcation.agentName = self.remitanceAgent.remittanceName;

    self.swNotification.on = [core isNotificationExist:notifcation];
    
    preNotificationValue = self.swNotification.on;
    
    
    if (delegate.isFromNotification== true) {
        delegate.isFromNotification = false;
    }
    
    
    [self.view addSubview:[_commonAddMob ImplementBanerBottom:self]];
    [self.tableView setContentInset:UIEdgeInsetsMake(50, 0, 0, 0)];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    UIView *xView = [_commonAddMob ImplementBanerBottom:self];
    
    CGRect fixedFrame = xView.frame;
    fixedFrame.origin.y = 0 + scrollView.contentOffset.y + 64;
    xView.frame = fixedFrame;
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
    
//    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter])
//    {
//        SLComposeViewController *tweetSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
//        [tweetSheet setInitialText:@"Tweeting from my own app! :)"];
//        [self presentViewController:tweetSheet animated:YES completion:nil];
//    }
//    else
//    {
//        UIAlertView *alertView = [[UIAlertView alloc]
//                                  initWithTitle:@"Sorry"
//                                  message:@"You can't send a tweet right now, make sure  your device has an internet connection and you have at least one Twitter account setup"  delegate:self
//                                  cancelButtonTitle:@"OK"
//                                  otherButtonTitles:nil];
//        [alertView show];
//    }
//    
    
    
    
    
    
    
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter])
    {
        SLComposeViewController *tweeter = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
        
        //[tweeter setInitialText:@"Tweeting from my own app! :)"];
        
        //[tweeter addImage:<#(UIImage *)#>]
        
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
    
    
#define SYSTEM_VERSION_LESS_THAN(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
    
    NSUInteger rntypes;
    UIAlertView *alert;
    if (!SYSTEM_VERSION_LESS_THAN(@"8.0")) {
        rntypes = [[[UIApplication sharedApplication] currentUserNotificationSettings] types];
        alert = [[UIAlertView alloc]initWithTitle:@"Push Notification not enabled" message:@"Unable to continue, please enable Push Notification in Settings > ToPiso > Notifications : Allow Notifications " delegate:nil cancelButtonTitle:@"Close" otherButtonTitles:nil];//, nil
    }else{
        
        rntypes = [[UIApplication sharedApplication] enabledRemoteNotificationTypes];
        alert = [[UIAlertView alloc]initWithTitle:@"Push Notification not enabled" message:@"Unable to continue, please enable Push Notification in Settings > Notification Center : Show in Notification Center " delegate:nil cancelButtonTitle:@"Close" otherButtonTitles:nil];//, nil
        
        
    }
    
    
    
    
    if (rntypes == 0)
    {
        // Disabled
        
        
        [alert show];
        
        self.swNotification.on = false;
        return;
    }
   
    
    
    
    if (delegate.DevinceToken == nil) {
        self.swNotification.on = false;
        return;
    }
    
    
    
    
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
    
    NSDictionary *payloadDict = @{  @"notificationGUID":@"yttyghyy"
                                  , @"deviceUDID" : delegate.DevinceToken
                                  , @"remittanceGUID" : self.remitanceAgent.remmittanceGUID
                                  , @"agentName" : self.remitanceAgent.remittanceName
                                  , @"countryCode" : self.remitanceAgent.countryCode
                                  , @"countryName" : self.country.countryName
                                  , @"currencyKey" : self.remitanceAgent.currencyKey
                                  , @"lastUpdated" : strDate
                                  , @"dateCreated" : strDate
                                  , @"isInsertDelete": strOnOff
                                  };

    
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
    
    
    [controller setInitialText:[NSString stringWithFormat:@"%@ %@ rate by %@. Install ToPiso to get the latest remittance rate to Philippine peso ",self.remitanceAgent.currencyKey,strNumber,self.remitanceAgent.remittanceName]];
    
//    [controller addImage:[UIImage imageNamed:@"aga_180_180.png"]];
//    [controller addURL:[NSURL URLWithString:[CommonFunction getToPisoInstallURL]]];
//    
    
   // UIImageView *imgv = [[UIImageView alloc]init];
    //imgv.image = [UIImage imageNamed:@"aga_180_180.png"];
    //imgv.layer.cornerRadius = 10;
   // imgv.clipsToBounds = YES;
    //imgv.layer.borderWidth = 1;
    //[imgv.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    
    [controller addImage:[UIImage imageNamed:@"aga_180_180.png"]];
    
    
   // [controller addImage:imgv.image];
    //[controller addURL:[NSURL URLWithString:[CommonFunction getToPisoInstallURL]]];
}
-(NSString *)generateSMSBody
{
    NSNumberFormatter *numFormat = [[NSNumberFormatter alloc]init];
    [numFormat setNumberStyle:NSNumberFormatterDecimalStyle];
    
    NSString *strNumber = [numFormat stringFromNumber:self.remitanceAgent.rate];
    
    
    return [NSString stringWithFormat:@"%@ %@ - %@, Install toPiso iOS application to get the latest conversion of foreign currencies to Philippine peso. %@",self.remitanceAgent.currencyKey,strNumber,self.remitanceAgent.remittanceName,[CommonFunction getToPisoInstallURL]];

}

#pragma mark iAd Deleage
//
//-(void)bannerViewDidLoadAd:(ADBannerView *)banner
//{
//    [UIView beginAnimations:nil context:nil];
//    [UIView setAnimationDuration:1];
//    [banner setAlpha:1];
//    [UIView commitAnimations];
//}
//
//-(void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error
//{
//    [UIView beginAnimations:nil context:nil];
//    [UIView setAnimationDuration:1];
//    [banner setAlpha:0];
//    [UIView commitAnimations];
//    
//}
@end
