//
//  DeviceActivationViewController.h
//  SampleJSON
//
//  Created by Archie Angeles on 7/7/14.
//  Copyright (c) 2014 PachieOrg. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DeviceActivationViewController : UIViewController

@property (nonatomic, strong) NSString *deviceGUID;
@property (nonatomic, strong) NSString *activationCode;
@property (nonatomic, strong) NSString *phonNumber;
@property (nonatomic, strong) NSString *emailAddress;
@property (weak, nonatomic) IBOutlet UITextField *txtActivationCode;
- (IBAction)activateDevice:(id)sender;

//- (IBAction)resendActivation:(id)sender;
- (IBAction)resendcode:(id)sender;

@end
