//
//  TestViewController.h
//  SampleJSON
//
//  Created by Archie Angeles on 6/7/14.
//  Copyright (c) 2014 PachieOrg. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TestViewController : UIViewController
- (IBAction)getDataFromJSon:(id)sender;
- (IBAction)sendDataToJSON:(id)sender;

@property (weak, nonatomic) IBOutlet UITextField *txtPhoneNumber;

@property (weak, nonatomic) IBOutlet UITextField *txtEmailAddress;

@property (nonatomic, strong) NSString *DeviceGUID;
@property (nonatomic, strong) NSString *PhoneNumber;
@property (nonatomic, strong) NSString *Email;
@property (nonatomic, strong) NSString *isDeviceActivated;
@property (nonatomic,strong)NSString *SuccessRegistration;


@end
