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

- (IBAction)submit:(id)sender {
    
    //[self dismissViewControllerAnimated:YES completion:nil];
    //[self.xCallBackDelegate callbackmethod:@"89786"];
    
    //[self.xCallBackDelegate callbackmethod:@"2"];
    //[self dismissViewControllerAnimated:YES completion:nil];
    
    //[self performSegueWithIdentifier:@"activate2" sender:nil];

    
    [comReq registerAccount:self.deviceToken PhoneNumber:self.txtNumber.text withBlock:^(NSString *returnValue) {
        if ([returnValue isEqual:@"1"]) {
            
            //[self performSelector:@selector(callMe) withObject:nil afterDelay:10 ];
            //[self performSegueWithIdentifier:@"activate2" sender:nil];
            [self dismissViewControllerAnimated:YES completion:^{
                [self.xCallBackDelegate callbackmethod:self.txtNumber.text];
            }];
        }
        else
        {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Error registration" message:@"Error registering your account" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];//, nil
            [alert show];
        }
    }];
    

}

//-(void)callMe
//{
//    [self performSegueWithIdentifier:@"activate2" sender:nil];
//}

//-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
//{
//    dispatch_async(dispatch_get_main_queue(), ^{
//    if ([segue.identifier isEqualToString:@"activate2"]) {
//        
//            VerifyRegistrationViewController *dvc = [segue destinationViewController];
//            dvc.deviceToken = self.deviceToken;
//            dvc.phoneNumber = self.PhoneNumber;
//            dvc.xVerficationDelegate = self;
//       
//        
//    }
//        
//    });
//}

- (IBAction)cancel:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
