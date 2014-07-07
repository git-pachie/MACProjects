//
//  MainViewController.h
//  TestJSON
//
//  Created by pachie on 7/7/14.
//  Copyright (c) 2014 Private. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *txtcode;
- (IBAction)btnclick:(id)sender;


@property (nonatomic, strong) NSString *DeviceGUID;

@end
