//
//  AgentDetailsTableViewController.m
//  ToPeso
//
//  Created by pachie on 13/9/14.
//  Copyright (c) 2014 Private. All rights reserved.
//

#import "AgentDetailsTableViewController.h"
#import <Social/Social.h>


@interface AgentDetailsTableViewController ()

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
    
    self.lblAgentName.text = self.remitanceAgent.remittanceName;
    self.lblAgentAddress.text = self.remitanceAgent.address;
    self.lblAgentContact.text =[NSString stringWithFormat:@"Contact: %@",self.remitanceAgent.contact];
    
    
    NSNumberFormatter *numFormat = [[NSNumberFormatter alloc]init];
    [numFormat setNumberStyle:NSNumberFormatterDecimalStyle];
    self.lblCurrentRate.text = [numFormat stringFromNumber:self.remitanceAgent.rate];
    
    
    NSDateFormatter *dateFormate = [[NSDateFormatter alloc]init];
    [dateFormate setDateFormat:@"dd MMMM yyyy hh:mm a"];
    self.lblAsOfDate.text =[NSString stringWithFormat:@"As of date %@",[dateFormate stringFromDate:self.remitanceAgent.asofDate]];
    
    self.imgAgentPhoto.image = [UIImage imageNamed:@"default.png"];
    self.imgAgentPhoto.layer.cornerRadius = 10;
    self.imgAgentPhoto.clipsToBounds = YES;
    self.imgAgentPhoto.layer.borderWidth = 0.4;
    self.imgAgentPhoto.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    
    
    [self.btnFB setFrame:CGRectMake(0, 0, 50, 50)];
    [self.btnTweeter setFrame:CGRectMake(0, 0, 50, 50)];
    
    
    
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

    return 3;
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
        
        
        [facebook setInitialText:[NSString stringWithFormat:@"%@ %@ %@ - %@, Install toPiso iOS application to get the latest conversion of foreign currencies to Philippine peso.",self.remitanceAgent.currencyKey,@"123.25",self.remitanceAgent.countryCode,self.remitanceAgent.remittanceName]];
        
        [facebook addImage:[UIImage imageNamed:@"ToPiso_120x120.png"]];
        [facebook addURL:[NSURL URLWithString:@"http://www.toIpiso.com"]];
        
        
        UIImageView *imgv = [[UIImageView alloc]init];
        imgv.image = [UIImage imageNamed:@"ToPiso_120x120.png"];
        imgv.layer.cornerRadius = 10;
        imgv.clipsToBounds = YES;
        imgv.layer.borderWidth = 1;
        [imgv.layer setBorderColor:[UIColor lightGrayColor].CGColor];
        
        
        [facebook addImage:imgv.image];
        [facebook addURL:[NSURL URLWithString:@"http://www.toPiso.com"]];
        
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
        [tweeter setInitialText:[NSString stringWithFormat:@"%@ %@ %@ - %@, Install toPiso iOS application to get the latest conversion of foreign currencies to Philippine peso. \n",self.remitanceAgent.currencyKey,@"123.25",self.remitanceAgent.countryCode,self.remitanceAgent.remittanceName]];
        
        UIImageView *imgv = [[UIImageView alloc]init];
        imgv.image = [UIImage imageNamed:@"ToPiso_120x120.png"];
        imgv.layer.cornerRadius = 10;
        imgv.clipsToBounds = YES;
        imgv.layer.borderWidth = 0.4;
        [imgv.layer setBorderColor:[UIColor lightGrayColor].CGColor];
        
        
        [tweeter addImage:imgv.image];
        [tweeter addURL:[NSURL URLWithString:@"http://www.toPiso.com"]];
        
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Twitter not configured" message:@"Unable to continue, your twitter account not yet configured. Please configure it in settings menu" delegate:nil cancelButtonTitle:@"Close" otherButtonTitles:nil];//, nil
        [alert show];
    }
    
}
- (IBAction)acFlicker:(id)sender {
    
    MFMessageComposeViewController *controller = [[MFMessageComposeViewController alloc] init];
	if([MFMessageComposeViewController canSendText])
	{
		controller.body = @"SGD-PHP rate is 25.60 for Kabayan Remittance in Singapore as of July 25, 2014";
		controller.recipients = [NSArray arrayWithObjects:@"85713568", nil];
		controller.messageComposeDelegate = self;
		//[self presentModalViewController:controller animated:YES];
        
        
        
        
        [self presentViewController:controller animated:YES completion:nil];
	}
}

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
	switch (result) {
		case MessageComposeResultCancelled:
        {
            
			NSLog(@"Cancelled");
			break;
            case MessageComposeResultFailed:
		
            NSLog(@"Message failed");
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"toPiso" message:@"Unknown Error"
                                                               delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
                [alert show];
                
            });
            
            break;
            
            
        }
        case MessageComposeResultSent:
        {
            NSLog(@"Message sent");
            break;
		}
		default:
        {
			break;
        }
	}
    
	[self dismissViewControllerAnimated:YES completion:nil];
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
@end
