//
//  MessageDetailViewController.m
//  SampleJSON
//
//  Created by Archie Angeles on 13/7/14.
//  Copyright (c) 2014 PachieOrg. All rights reserved.
//

#import "MessageDetailViewController.h"
#import "SendPickupViewController.h"
#import "CommonFunction.h"
#import "AppDelegate.h"
#import "CustomLoader.h"


@interface MessageDetailViewController ()
{
    dispatch_queue_t myQueue;
    NSString *theReply;
    CustomLoader *customLoader;
}



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
    customLoader = [[CustomLoader alloc]init];
    [customLoader InitializeLoaderView:self];

    
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
    
//    UIAlertView* mes=[[UIAlertView alloc] initWithTitle:@"Pickup Lines"
//                                                message:@"Sorry function not yet ready" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
//    
//    [mes show];
//
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Storyboard" bundle:nil];
    
    PhoneBookTableViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"ModalContact"];
    
    vc.Xdelexgate = self;
    
    //[self.navigationController popToViewController:vc animated:YES];
    [self.navigationController pushViewController:vc animated:YES];

}

#pragma - Phonebook
-(void)GetSelectedPerson:(EntityPerson *)selectedPerson
{
    //self.labelSelectedContact.text = selectedPerson.Name;
    
    
    [self SendDelegate:selectedPerson];
    
    //[self.navigationController popToRootViewControllerAnimated:YES];
    

}

-(void)SendDelegate:(EntityPerson*)selectedPerson
{
    
    [self.sendMessageDelegate sendMessageToSelectedPerson:selectedPerson MessageGUID:self.MessageGUID];
    
    
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}


-(void)alertView:(UIAlertView *)alertView willDismissWithButtonIndex:    (NSInteger)buttonIndex
{
    if(buttonIndex==0)
    {
        //Code that will run after you press ok button
        //[self.navigationController popViewControllerAnimated:YES ];
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}

@end
