//
//  AboutViewController.h
//  ToPeso
//
//  Created by Archie Angeles on 6/10/14.
//  Copyright (c) 2014 Private. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>

@interface AboutViewController : UIViewController <MFMailComposeViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UIButton *btnContactUs;
- (IBAction)actionContactUs:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnFacebook;
- (IBAction)actionFacebook:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnTwitter;
- (IBAction)actionTwitter:(id)sender;

@end
