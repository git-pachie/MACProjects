//
//  Dev2ActivationViewController.m
//  PickupLines
//
//  Created by Archie Angeles on 30/8/14.
//  Copyright (c) 2014 PachieOrg. All rights reserved.
//

#import "Dev2ActivationViewController.h"
#import "CustomStringClass.h"
#import "VerifyRegistrationViewController.h"
#import "CommonSendRequest.h"

@interface Dev2ActivationViewController ()
{
    CommonSendRequest *comReq;
}



@end

@implementation Dev2ActivationViewController

-(void)resendCallback
{
    
}

-(void)cancleDelegate
{
    self.txtNumber.text = @"" ;
    //[self dismissViewControllerAnimated:YES completion:nil];
}

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
    [CustomStringClass ApplyRountedBorderToButton:self.btnsubmit];
    [CustomStringClass ApplyRountedBorderToButton:self.btncancel];
    
    
        
    NSLog(@"Phone number %@",self.PhoneNumber);
    
    
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



- (IBAction)submit2:(id)sender {
    
    if ([self.txtNumber.text isEqualToString:@""] || [self.txtDesiredUserName.text  isEqual: @""] ) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Invalid input" message:@"Phone number and unique alias is required." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];//, nil
        [alert show];
        return;
    }
    
    
           [comReq registerAccount:self.deviceToken PhoneNumber:self.txtNumber.text DesiredAlias:self.txtDesiredUserName.text withBlock:^(NSString *returnValue) {
            if ([returnValue isEqual:@"1"]) {
                
                //[self performSelector:@selector(callMe) withObject:nil afterDelay:10 ];
                //[self performSegueWithIdentifier:@"activate2" sender:nil];
                [self dismissViewControllerAnimated:YES completion:^{
                    [self.xCallBackDelegate callbackmethod:self.txtNumber.text];
                }];
            }
            else if ([returnValue isEqual:@"2"])
            {
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alias already taken" message:@"Alias name not available" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];//, nil
                    [alert show];
                    
                });
            }
            else
            {
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Error registration" message:@"Error registering your account" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];//, nil
                [alert show];
                return;
            }
        }];
    
    
    
    
}

- (IBAction)cancel:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}



- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *title = [alertView buttonTitleAtIndex:buttonIndex];
    
    if([title isEqualToString:@"Ok"])
    {
        NSLog(@"Button 1 was selected.");
    }
    else if([title isEqualToString:@"Button 2"])
    {
        NSLog(@"Button 2 was selected.");
    }
    else if([title isEqualToString:@"Button 3"])
    {
        NSLog(@"Button 3 was selected.");
    }
}

@end
