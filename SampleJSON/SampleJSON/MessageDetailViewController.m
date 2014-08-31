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
#import "CustomStringClass.h"
#import "CommonSendRequest.h"
#import "Dev2ActivationViewController.h"
//#import "VerifyRegistrationViewController.h"

@interface MessageDetailViewController ()
{
    dispatch_queue_t myQueue;
    NSString *theReply;
    CustomLoader *customLoader;
    CommonSendRequest *comreq;
    AppDelegate *delegate;


}



@end



@implementation MessageDetailViewController

-(void)resendCallback
{
    [self performSegueWithIdentifier:@"register2" sender:nil];
}

-(void)cancleDelegate
{
   // [self performSegueWithIdentifier:@"register2" sender:nil];
}

-(void)callbackmethod:(NSString *)returnvalue
{
    //[self dochecking:@"2"];
    //[self dismissViewControllerAnimated:YES completion:nil];
    //[self performSelectorInBackground:@selector(dochecking:) withObject:returnvalue];
    //[self performSegueWithIdentifier:@"activate2" sender:nil];
    self.phoneNumber = returnvalue;
    [self performSegueWithIdentifier:@"activate2" sender:nil];
   
}





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
    delegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    comreq = [[CommonSendRequest alloc]init];
    customLoader = [[CustomLoader alloc]init];
    [customLoader InitializeLoaderView:self];
    
    
    [CustomStringClass ApplyRountedBorderToButton:self.btnsendtosomeone];
    
    
   // [self.lblhiritMessage setText:HiritMessage];
    
    [self setStyleForPickupLines:self.lblhiritMessage :self.HiritMessage :self.Answer ];
    //
   // [self.lblhiritMessage setLineBreakMode:NSLineBreakByWordWrapping];

    
    //self.lblhiritAnswer.text = self.Answer;
    
    //textView.textContainer.lineBreakMode = NSLineBreakByCharWrapping
    
    
}


-(void)dochecking: (NSString *)returnValue
{
    //UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Storyboard" bundle:nil];
    
        if ([returnValue isEqual:@"1"]) {
            //NSLog(@"Ok registered");
            dispatch_async(dispatch_get_main_queue(), ^{
                [self performSegueWithIdentifier:@"showphonebook" sender:nil];
            });

        }
        else if([returnValue isEqual:@"0"])
        {

            dispatch_async(dispatch_get_main_queue(), ^{
            [self performSegueWithIdentifier:@"register2" sender:nil];
            });

        }
        else
        {
           dispatch_async(dispatch_get_main_queue(), ^{
               self.phoneNumber = returnValue;
            [self performSegueWithIdentifier:@"activate2" sender:nil];
            });

        }


    
    
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
    if ([segue.identifier isEqualToString:@"showphonebook"]) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
        
        PhoneBookTableViewController *dv = segue.destinationViewController;

            dv.Xdelexgate = self ;
            
        });
       
    }
    else if ([segue.identifier isEqual:@"register2"]) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            Dev2ActivationViewController *dvc = [segue destinationViewController];
            dvc.deviceToken = delegate.DevinceToken;
            dvc.xCallBackDelegate = self;
        });
        
    }
    else if([segue.identifier isEqual:@"activate2"])
    {
        //dispatch_async(dispatch_get_main_queue(), ^{
        VerifyRegistrationViewController *dvc = [segue destinationViewController];
            dvc.deviceToken = delegate.DevinceToken;
            dvc.phoneNumber = self.phoneNumber;
        dvc.xVerficationDelegate = self;
            
        //});
        
    }
}


- (IBAction)Send:(UIBarButtonItem *)sender {
    
    
    [comreq checkDeviceActivation:delegate.DevinceToken withBlock:^(NSString *returnValue)
     {
         
         [self performSelector:@selector(dochecking:) withObject:returnValue];
         
     }];
    
    

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

-(void)setStyleForPickupLines :(UILabel *)label :(NSString *)headerText :(NSString *)detailText
{
    [label setNumberOfLines:0];
    [label setLineBreakMode:NSLineBreakByWordWrapping];
    //[cell.labelMessage setBackgroundColor:[UIColor greenColor]];
    
    CGFloat width = 283;
    UIFont *font = [UIFont fontWithName:@"TrebuchetMS" size:18];
    
    NSMutableParagraphStyle *pStyle =  [[NSMutableParagraphStyle alloc]init];
    [pStyle setLineSpacing:4];
    
    
    NSMutableAttributedString
    *attributedText =  [[NSMutableAttributedString alloc] initWithString:detailText                                                              attributes:@
                        {
                        NSFontAttributeName: font
                        }];
    CGRect rect = [attributedText boundingRectWithSize:(CGSize){width, CGFLOAT_MAX}
                                               options:NSStringDrawingUsesLineFragmentOrigin
                                               context:nil];
    
    [attributedText addAttribute:NSParagraphStyleAttributeName value:pStyle range:NSMakeRange(0, attributedText.length)];
    
    
    
    UIFont *myboldFont = [UIFont fontWithName:@"TrebuchetMS-Bold" size:21];
    
    NSMutableAttributedString
    *attributedText2 =  [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%1@\n\n", headerText]
                                                               attributes:@
                         {
                         NSFontAttributeName: myboldFont
                         }];
    //CGRect rect = [attributedText boundingRectWithSize:(CGSize){width, CGFLOAT_MAX}
    //options:NSStringDrawingUsesLineFragmentOrigin
    //context:nil];
    
    [attributedText2 appendAttributedString:attributedText];
    
    label.attributedText = attributedText2 ;
    
    
    [label setFrame:rect];
    
    [label sizeToFit];

}

@end
