//
//  AgentDetailsTableViewController.h
//  ToPeso
//
//  Created by pachie on 13/9/14.
//  Copyright (c) 2014 Private. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Remittance.h"
#import "Country.h"
#import <MessageUI/MessageUI.h>
#import <iAd/iAd.h>
@interface AgentDetailsTableViewController : UITableViewController <MFMessageComposeViewControllerDelegate, MFMailComposeViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *imgAgentPhoto;
@property (weak, nonatomic) IBOutlet UILabel *lblAgentName;
//@property (weak, nonatomic) IBOutlet UILabel *lblAgentAddress;
//@property (weak, nonatomic) IBOutlet UILabel *lblAgentContact;
@property (weak, nonatomic) IBOutlet UILabel *lblCurrentRate;
@property (weak, nonatomic) IBOutlet UILabel *lblAsOfDate;
@property (weak, nonatomic) IBOutlet UIButton *btnEmail;
@property (weak, nonatomic) IBOutlet UIButton *btnSMS;

@property (weak, nonatomic) IBOutlet UISwitch *swNotification;
@property (weak, nonatomic) IBOutlet UIButton *btnFB;
@property (weak, nonatomic) IBOutlet UIButton *btnTweeter;
- (IBAction)acFlicker:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *lblCurrencyKey;


@property (nonatomic,strong)Remittance *remitanceAgent;
@property (nonatomic,strong)Country *country;
@property (weak, nonatomic) IBOutlet UIImageView *imageCaputre;

- (IBAction)acFB:(id)sender;
- (IBAction)acTweeter:(id)sender;
- (IBAction)acEmail:(id)sender;

- (IBAction)swNotification:(id)sender;



@end
