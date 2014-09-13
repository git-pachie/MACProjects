//
//  AgentDetailsTableViewController.h
//  ToPeso
//
//  Created by pachie on 13/9/14.
//  Copyright (c) 2014 Private. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Remittance.h"
#import <MessageUI/MessageUI.h>
@interface AgentDetailsTableViewController : UITableViewController <MFMessageComposeViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *imgAgentPhoto;
@property (weak, nonatomic) IBOutlet UILabel *lblAgentName;
@property (weak, nonatomic) IBOutlet UILabel *lblAgentAddress;
@property (weak, nonatomic) IBOutlet UILabel *lblAgentContact;
@property (weak, nonatomic) IBOutlet UILabel *lblCurrentRate;
@property (weak, nonatomic) IBOutlet UILabel *lblAsOfDate;

@property (weak, nonatomic) IBOutlet UIButton *btnFB;
@property (weak, nonatomic) IBOutlet UIButton *btnTweeter;
- (IBAction)acFlicker:(id)sender;


@property (nonatomic,strong)Remittance *remitanceAgent;

- (IBAction)acFB:(id)sender;
- (IBAction)acTweeter:(id)sender;



@end
