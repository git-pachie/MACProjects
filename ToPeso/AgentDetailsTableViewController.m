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
        [facebook setInitialText:@"Great fun to learn iOS programming at appcoda.com!"];
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
        [tweeter setInitialText:@"Great fun to learn iOS programming at appcoda.com!"];
        [self presentViewController:tweeter animated:YES completion:nil];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Twitter not configured" message:@"Unable to continue, your twitter account not yet configured. Please configure it in settings menu" delegate:nil cancelButtonTitle:@"Close" otherButtonTitles:nil];//, nil
        [alert show];
    }
    
}
- (IBAction)acFlicker:(id)sender {
    
   
}
@end
