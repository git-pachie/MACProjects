//
//  MessageDetailViewController.m
//  SampleJSON
//
//  Created by Archie Angeles on 13/7/14.
//  Copyright (c) 2014 PachieOrg. All rights reserved.
//

#import "MessageDetailViewController.h"
#import "SendPickupViewController.h"

@interface MessageDetailViewController ()

@end

@implementation MessageDetailViewController

@synthesize  MessageGUID, HiritMessage, CreatedBy, Answer;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.lblhiritMessage setText:HiritMessage];
    
    self.lblhiritMessage.numberOfLines = 0;
//    
   // [self.lblhiritMessage setLineBreakMode:NSLineBreakByWordWrapping];

    
    self.lblhiritAnswer.text = self.Answer;
    
    //textView.textContainer.lineBreakMode = NSLineBreakByCharWrapping
    
   
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation
*/
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"sendPickupLine"]) {
        
        SendPickupViewController *dv = segue.destinationViewController;

        dv.MessageGUID = self.MessageGUID;
       
    }
}


- (IBAction)Send:(UIBarButtonItem *)sender {
    
    UIAlertView* mes=[[UIAlertView alloc] initWithTitle:@"Pickup Lines"
                                                message:@"Sorry function not yet ready" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
    
    [mes show];

}
@end
