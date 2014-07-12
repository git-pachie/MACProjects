//
//  DetailViewController.h
//  JSONTableParser
//
//  Created by Archie Angeles on 10/7/14.
//  Copyright (c) 2014 PachieOrg. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (nonatomic, strong) NSString *MessageGUID;
@property (nonatomic, strong) NSString *HiritMessage;
@property (nonatomic, strong) NSString *CreatedBy;
@property (nonatomic, strong) NSString *Answer;

//@property (nonatomic, strong)
@property (weak, nonatomic) IBOutlet UITextView *txtdetail;
@property (weak, nonatomic) IBOutlet UITextView *txtanswer;


@end
