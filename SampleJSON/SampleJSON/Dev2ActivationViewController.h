//
//  Dev2ActivationViewController.h
//  PickupLines
//
//  Created by Archie Angeles on 30/8/14.
//  Copyright (c) 2014 PachieOrg. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VerifyRegistrationViewController.h"

@protocol RegistrationDelegate <NSObject>

    -(void)callbackmethod : (NSString *)returnvalue;
   



@end

@interface Dev2ActivationViewController : UIViewController <VerificaitionDelegate>
@property (weak, nonatomic) IBOutlet UITextField *txtNumber;
@property (weak, nonatomic) IBOutlet UIButton *btnsubmit;
@property (weak, nonatomic) IBOutlet UIButton *btncancel;
@property (weak, nonatomic) IBOutlet UITextField *txtDesiredUserName;


- (IBAction)submit2:(id)sender;

- (IBAction)cancel:(id)sender;


@property (nonatomic, strong) NSString * isVerication;
@property (nonatomic, strong)NSString *PhoneNumber;
@property (nonatomic, strong)NSString *deviceToken;


@property (nonatomic ,strong)id<RegistrationDelegate> xCallBackDelegate;

@end
