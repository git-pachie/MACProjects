//
//  MessageDetailViewController.h
//  SampleJSON
//
//  Created by Archie Angeles on 13/7/14.
//  Copyright (c) 2014 PachieOrg. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PhoneBookTableViewController.h"

@interface MessageDetailViewController : UIViewController <ModalViewControllerDelegate>

@property (nonatomic, strong) NSString *MessageGUID;
@property (nonatomic, strong) NSString *HiritMessage;
@property (nonatomic, strong) NSString *CreatedBy;
@property (nonatomic, strong) NSString *Answer;


@property (weak, nonatomic) IBOutlet UILabel *lblhiritMessage;
@property (weak, nonatomic) IBOutlet UILabel *lblhiritAnswer;


- (IBAction)Send:(UIBarButtonItem *)sender;

@end
