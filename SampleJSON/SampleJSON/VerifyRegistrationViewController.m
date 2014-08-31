//
//  VerifyRegistrationViewController.m
//  PickupLines
//
//  Created by Archie Angeles on 30/8/14.
//  Copyright (c) 2014 PachieOrg. All rights reserved.
//

#import "VerifyRegistrationViewController.h"
#import "CommonSendRequest.h"
#import "CustomStringClass.h"

@interface VerifyRegistrationViewController ()
{
    CommonSendRequest *comReq;
}

@end

@implementation VerifyRegistrationViewController

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
    comReq = [[CommonSendRequest alloc]init];
    [CustomStringClass ApplyRountedBorderToButton:self.btncancel];
    [CustomStringClass ApplyRountedBorderToButton:self.btnVerifyButton];
    [CustomStringClass ApplyRountedBorderToButton:self.btnCancel];
    
    

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];

}



- (IBAction)verify:(id)sender {
    
    [comReq verifyAccount:self.deviceToken PhoneNumber:self.phoneNumber ActivationCode:self.txtVerificationCode.text withBlock:^(NSString *returnValue) {
        
        NSLog(@"start callback here");
        
        if ([returnValue isEqual:@"1"]) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
            
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Success" message:@"Congratulation your account is activated." delegate:self cancelButtonTitle:@"Close" otherButtonTitles:nil];//, nil
            
            NSLog(@"before alert show");
            [alert show];
            });
        }
        else
        {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"You entered invalid verification code" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];//, nil
                
                NSLog(@"before alert show error" );
                [alert show];
            });

            
        }
    }];
    
    
    
}




- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *title = [alertView buttonTitleAtIndex:buttonIndex];
    
    if([title isEqualToString:@"Close"])
    {
        [self dismissViewControllerAnimated:YES completion:nil];
        //NSLog(@"Error button clicked");
    }
//    else if([title isEqualToString:@"Button 2"])
//    {
//        NSLog(@"Button 2 was selected.");
//    }
//    else if([title isEqualToString:@"Button 3"])
//    {
//        NSLog(@"Button 3 was selected.");
//    }
}

- (IBAction)cancel:(id)sender {
    //[self.xVerficationDelegate cancleDelegate];
    [self dismissViewControllerAnimated:YES completion:^{
        [self.xVerficationDelegate resendCallback];
    }];
}

- (IBAction)cancelAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
