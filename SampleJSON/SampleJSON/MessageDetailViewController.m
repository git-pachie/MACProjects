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


@interface MessageDetailViewController ()
{
    dispatch_queue_t myQueue;
    NSString *theReply;
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
    
    if (!myQueue) {
        myQueue = dispatch_queue_create("com.samplejson", NULL);
    }
    
    
    dispatch_async(myQueue, ^{
        
        AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        
        
        if ([selectedPerson.Number isEqualToString:@""] || [selectedPerson.Number isEqualToString:@""])
        {
            UIAlertView* mes=[[UIAlertView alloc] initWithTitle:@"Invalid Input"
                                                        message:@"Phone number required" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
            
            [mes show];
            return;
        }
        
        CommonFunction *common = [[CommonFunction alloc]init];
        
        
        NSString *post = [common GetJsonConnection:[NSString stringWithFormat:@"SendPickupLine/%1@/%2@/%3@",delegate.DeviceGUID,selectedPerson.Number,self.MessageGUID]];
        
        NSData *data = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
        
        NSString *postLenght = [NSString stringWithFormat:@"%lu", (unsigned long)[data length]];
        
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
        [request setURL:[NSURL URLWithString:post]];
        [request setHTTPMethod:@"POST"];
        [request setValue:postLenght forHTTPHeaderField:@"Content-Length"];
        [request setValue:@"application/x-www-form-urlencoded;charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
        [request setHTTPBody:data];
        
        NSURLResponse *response;
        NSData *POSTReply = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil];
        theReply = [[NSString alloc] initWithBytes:[POSTReply bytes] length:[POSTReply length] encoding: NSASCIIStringEncoding];
        NSLog(@"Reply: %@", theReply);
        
        
        [self SendDelegate:selectedPerson];
        
    });
    
    
    
    
}

-(void)SendDelegate:(EntityPerson*)selectedPerson
{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
 
        sleep(2);
        
        theReply = [theReply stringByReplacingOccurrencesOfString:@"\"" withString:@""];
        
        
        if ( [theReply isEqualToString:@"1"]) {
            
            
            [self.navigationController popToRootViewControllerAnimated:YES];
            
        }
        else{
            
            
            UIAlertView* mes=[[UIAlertView alloc] initWithTitle:@"Error"
                                                        message:@"Error sending pickuplines" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
            
            [mes show];
        }
    });
    
    
    

}


-(void)alertView:(UIAlertView *)alertView willDismissWithButtonIndex:    (NSInteger)buttonIndex
{
    if(buttonIndex==0)
    {
        //Code that will run after you press ok button
        [self.navigationController popViewControllerAnimated:YES ];
    }
}

@end
