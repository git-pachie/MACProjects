//
//  CustomStaticTableViewController.h
//  SampleJSON
//
//  Created by pachie on 15/7/14.
//  Copyright (c) 2014 PachieOrg. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomStaticTableViewController : UITableViewController

@property (nonatomic, strong) NSString *accountType;
@property (nonatomic, strong) NSString *emailAddress;

@property (weak, nonatomic) IBOutlet UILabel *lblAccountName;
@property (weak, nonatomic) IBOutlet UILabel *lblEmail;

@property (weak, nonatomic) IBOutlet UIImageView *profilepic;

@end
