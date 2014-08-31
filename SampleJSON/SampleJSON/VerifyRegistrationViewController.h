//
//  VerifyRegistrationViewController.h
//  PickupLines
//
//  Created by Archie Angeles on 30/8/14.
//  Copyright (c) 2014 PachieOrg. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol VerificaitionDelegate <NSObject>


-(void)cancleDelegate;
-(void)resendCallback;


@end

@interface VerifyRegistrationViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *txtVerificationCode;
@property (weak, nonatomic) IBOutlet UIButton *btnVerifyButton;
@property (weak, nonatomic) IBOutlet UIButton *btncancel;
@property (weak, nonatomic) IBOutlet UIButton *btnCancel;

@property (nonatomic, strong)NSString *deviceToken;
@property (nonatomic, strong)NSString *phoneNumber;

- (IBAction)verify:(id)sender;
- (IBAction)cancel:(id)sender;
- (IBAction)cancelAction:(id)sender;



@property (nonatomic, strong)id<VerificaitionDelegate> xVerficationDelegate;



@end
