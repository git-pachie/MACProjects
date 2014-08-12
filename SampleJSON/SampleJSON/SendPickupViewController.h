//
//  SendPickupViewController.h
//  SampleJSON
//
//  Created by pachie on 8/8/14.
//  Copyright (c) 2014 PachieOrg. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SendPickupViewController : UIViewController

@property (nonatomic, strong) NSString *MessageGUID;
@property (weak, nonatomic) IBOutlet UITextField *sendToPhoneNumber;
- (IBAction)sendNow:(id)sender;


@end
