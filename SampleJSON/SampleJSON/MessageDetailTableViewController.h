//
//  MessageDetailTableViewController.h
//  SampleJSON
//
//  Created by pachie on 6/8/14.
//  Copyright (c) 2014 PachieOrg. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MessageDetailTableViewController : UITableViewController


@property (nonatomic, strong) NSString *MessageGUID;
@property (nonatomic, strong) NSString *HiritMessage;
@property (nonatomic, strong) NSString *CreatedBy;
@property (nonatomic, strong) NSString *Answer;



@end
