//
//  MessageDetailViewController.h
//  SampleJSON
//
//  Created by Archie Angeles on 13/7/14.
//  Copyright (c) 2014 PachieOrg. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MessageDetailViewController : UIViewController

@property (nonatomic, strong) NSString *MessageGUID;
@property (nonatomic, strong) NSString *HiritMessage;
@property (nonatomic, strong) NSString *CreatedBy;
@property (nonatomic, strong) NSString *Answer;
@property (weak, nonatomic) IBOutlet UITextView *txtPickupDetail;
@property (weak, nonatomic) IBOutlet UITextView *txtPickupAnswer;
- (IBAction)Send:(UIBarButtonItem *)sender;

@end