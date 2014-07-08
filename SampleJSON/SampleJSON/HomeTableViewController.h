//
//  HomeTableViewController.h
//  SampleJSON
//
//  Created by Archie Angeles on 7/7/14.
//  Copyright (c) 2014 PachieOrg. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeTableViewController : UITableViewController

@property (nonatomic, strong) NSString *DeviceGUID;
@property (nonatomic, strong) NSString *PhoneNumber;
@property (nonatomic, strong) NSString *Email;
@property (nonatomic, strong) NSString *IsDeviceActivated;

@end
