//
//  AboutViewController.m
//  ToPeso
//
//  Created by Archie Angeles on 6/10/14.
//  Copyright (c) 2014 Private. All rights reserved.
//

#import "AboutViewController.h"
#import "CommonFunction.h"
#import "com_pachie_topesoAppDelegate.h"

@interface AboutViewController ()



@end

@implementation AboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    // Do any additional setup after loading the view.
    
    [self.btnContactUs.layer setBorderWidth:0.5];
    [self.btnFacebook.layer setBorderWidth:0.5];
    [self.btnTwitter.layer setBorderWidth:0.5];
    [self.btnLatest.layer setBorderWidth:0.5];
    
    
    
    [self.btnContactUs.layer setCornerRadius:self.btnContactUs.frame.size.height / 2];
    [self.btnFacebook.layer setCornerRadius:self.btnFacebook.frame.size.height / 2];
    [self.btnTwitter.layer setCornerRadius:self.btnTwitter.frame.size.height / 2];
    [self.btnLatest.layer setCornerRadius:self.btnLatest.frame.size.height / 2];
    
    
    
    UIColor *greenco =  [UIColor colorWithRed:(112/255.0) green:(194/255.0) blue:(0/255.0) alpha:.50] ;
    UIColor *greencoDark =  [UIColor colorWithRed:(112/255.0) green:(194/255.0) blue:(0/255.0) alpha:.1] ;
    
    
    [self.btnContactUs setBackgroundColor:greenco];
    [self.btnFacebook setBackgroundColor:greenco];
    [self.btnTwitter setBackgroundColor:greenco];
    [self.btnLatest setBackgroundColor:greenco];
    
    
    [self.btnContactUs.layer setBorderColor:greencoDark.CGColor];
    [self.btnFacebook.layer setBorderColor:greencoDark.CGColor];
    [self.btnTwitter.layer setBorderColor:greencoDark.CGColor];
    [self.btnLatest.layer setBorderColor:greencoDark.CGColor];
    
    
    
    com_pachie_topesoAppDelegate *del = (com_pachie_topesoAppDelegate *)[[UIApplication sharedApplication]delegate];
    
    self.labelAppVersion.text = [NSString stringWithFormat:@"Version %@",del.appVersion] ;//del.appVersion;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)actionContactUs:(id)sender {
    
    // Email Subject
    NSString *emailTitle = @"Enquiry to ToPiso iOS mobile apps";
    // Email Content
   // NSString *messageBody =[NSString stringWithFormat:@"<h4>%@</h4>",[self generateSMSBody]] ; // Change the message body to HTML
    // To address
    NSArray *toRecipents = [NSArray arrayWithObject:[CommonFunction getToPisoEmailAddress]];
    
    MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
    mc.mailComposeDelegate = self;
    
    [mc setSubject:emailTitle];
    [mc setMessageBody:@"" isHTML:YES];
    [mc setToRecipients:toRecipents];
    
    // Present mail view controller on screen
    [self presentViewController:mc animated:YES completion:NULL];

    
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


- (IBAction)actionFacebook:(id)sender {
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[CommonFunction getToPisoFacebookURL]]];
    
}
- (IBAction)actionTwitter:(id)sender {
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[CommonFunction getToPisoTwitterURL]]];
}

- (IBAction)actionLatest:(id)sender
{
    
}

@end
