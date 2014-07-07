//
//  ActivationViewController.h
//  TestJSON
//
//  Created by pachie on 7/7/14.
//  Copyright (c) 2014 Private. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ActivationViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *txtActivationCode;
- (IBAction)activateNow:(id)sender;


@property (nonatomic,strong) NSString *deviceID;


@end
