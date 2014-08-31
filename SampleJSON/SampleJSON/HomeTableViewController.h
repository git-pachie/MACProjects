//
//  HomeTableViewController.h
//  SampleJSON
//
//  Created by Archie Angeles on 7/7/14.
//  Copyright (c) 2014 PachieOrg. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MessageDetailViewController.h"



@interface HomeTableViewController : UITableViewController <SendMessageDelegate>

@property (nonatomic, strong) NSString *DeviceGUID;
@property (nonatomic, strong) NSString *PhoneNumber;
@property (nonatomic, strong) NSString *Email;
@property (nonatomic, strong) NSString *IsDeviceActivated;


- (IBAction)Join:(id)sender;





//-(void)LoadTable;
//-(void)getJsonData;

@end
