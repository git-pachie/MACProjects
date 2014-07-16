//
//  DeviceActivationViewController.m
//  SampleJSON
//
//  Created by Archie Angeles on 7/7/14.
//  Copyright (c) 2014 PachieOrg. All rights reserved.
//

#import "DeviceActivationViewController.h"
//#import "HomeTableViewController.h"
#import "TestViewController.h"
#import "AppDelegate.h"



@interface DeviceActivationViewController ()
//-(id)jsonPostRequest:(NSData *)jsonRequestData;
@end

@implementation DeviceActivationViewController

@synthesize txtActivationCode;

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
    
    [txtActivationCode setText:_activationCode];
    
    
   
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

- (IBAction)activateDevice:(id)sender {
    
    
    NSString *post = [NSString stringWithFormat:@"http://www.riverwayauto.com:1980/myjson/Service1.svc/ActivateDevice/%1@/%2@",_deviceGUID,txtActivationCode.text];
    
    NSData *data = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLenght = [NSString stringWithFormat:@"%luu",(unsigned long) (unsigned long)[data length]];
    
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
    
    if ([theReply isEqualToString:@"true"]) {
        NSLog(@"Yes");
        //[self performSegueWithIdentifier:@"SegActivateDevice" sender:sender];
        AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        delegate.DeviceGUID = _deviceGUID;
        delegate.isDeviceRegistered = @"YES";
        
        UIAlertView* mes=[[UIAlertView alloc] initWithTitle:@"Pickup Lines"
                                                    message:@"Congratulation you activated this device to use Pickup Lines Application" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        
        [mes show];
        
//       UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Storyboard" bundle:nil];
//        
//        TestViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"register"];
//        [vc setModalPresentationStyle:UIModalPresentationFullScreen];
//        
//        vc.SuccessRegistration = @"YES";
        
        
        

        
    }
    else{
        NSLog(@"No");
        
        UIAlertView* mes=[[UIAlertView alloc] initWithTitle:@"Pickup Lines"
                                                    message:@"Sorry your code is wrong" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        
        [mes show];
    }
    

    
    
    
    
}

-(void)alertView:(UIAlertView *)alertView willDismissWithButtonIndex:    (NSInteger)buttonIndex
{
    if(buttonIndex==0)
    {
        //Code that will run after you press ok button
        [self dismissViewControllerAnimated:NO completion:nil];
    }
}

- (IBAction)resendcode:(id)sender {
    
           UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Storyboard" bundle:nil];
    
            TestViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"register"];
            [vc setModalPresentationStyle:UIModalPresentationFullScreen];
    
            vc.SuccessRegistration = @"YES";
    vc.DeviceGUID = _deviceGUID;
    
    [self presentViewController:vc animated:YES completion:nil];
    
    
            //[self dismissViewControllerAnimated:NO completion:nil];
}
@end
