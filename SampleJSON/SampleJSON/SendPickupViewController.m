//
//  SendPickupViewController.m
//  SampleJSON
//
//  Created by pachie on 8/8/14.
//  Copyright (c) 2014 PachieOrg. All rights reserved.
//

#import "SendPickupViewController.h"
#import "AppDelegate.h"
#import "CommonFunction.h"

@interface SendPickupViewController ()

@end

@implementation SendPickupViewController

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)sendNow:(id)sender {
    
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    if ([self.sendToPhoneNumber.text isEqualToString:@""] || [self.sendToPhoneNumber.text isEqualToString:@""])
    {
        UIAlertView* mes=[[UIAlertView alloc] initWithTitle:@"Invalid Input"
                                                    message:@"Phone number required" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        
        [mes show];
        return;
    }
    
    CommonFunction *common = [[CommonFunction alloc]init];
    
    
    NSString *post = [common GetJsonConnection:[NSString stringWithFormat:@"SendPickupLine/%1@/%2@/%3@",delegate.DeviceGUID,self.sendToPhoneNumber.text,self.MessageGUID]];
    
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
    NSString *theReply = [[NSString alloc] initWithBytes:[POSTReply bytes] length:[POSTReply length] encoding: NSASCIIStringEncoding];
    NSLog(@"Reply: %@", theReply);
    
    
    theReply = [theReply stringByReplacingOccurrencesOfString:@"\"" withString:@""];
    
    
    if ( [theReply isEqualToString:@"1"]) {
        
        
        [self.navigationController popToRootViewControllerAnimated:YES];
        
    }
    else{
        
        
        UIAlertView* mes=[[UIAlertView alloc] initWithTitle:@"Error"
                                                    message:@"Error sending pickuplines" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        
        [mes show];
    }

    
    
    
}
@end
