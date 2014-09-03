//
//  MessageDetail2TableViewController.h
//  PickupLines
//
//  Created by Archie Angeles on 2/9/14.
//  Copyright (c) 2014 PachieOrg. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "EntityPerson.h"
#import "Dev2ActivationViewController.h"
#import "VerifyRegistrationViewController.h"
#import "PhoneBookTableViewController.h"

@protocol SendMessageDelegate <NSObject>

-(void)sendMessageToSelectedPerson: (EntityPerson *) selectedPerson MessageGUID:(NSString *) messageGUID selectedAnswer:(NSString *)selectedAnswer;

@end

@interface MessageDetail2TableViewController : UITableViewController <ModalViewControllerDelegate, RegistrationDelegate, VerificaitionDelegate>


@property (nonatomic, strong) NSString *MessageGUID;
@property (nonatomic, strong) NSString *HiritMessage;
@property (nonatomic, strong) NSString *CreatedBy;
@property (nonatomic, strong) NSString *Answer;
@property (nonatomic, strong) NSString *phoneNumber;
@property (nonatomic, strong) NSString *createdByPhoneNumber;


@property (weak, nonatomic) IBOutlet UITableViewCell *cellUserProfile;
@property (weak, nonatomic) IBOutlet UILabel *lblhiritMessage;
@property (weak, nonatomic) IBOutlet UILabel *answer1;
@property (weak, nonatomic) IBOutlet UILabel *answer2;
@property (weak, nonatomic) IBOutlet UILabel *answer3;
- (IBAction)topsend:(id)sender;

@property (weak, nonatomic) IBOutlet UITableViewCell *cellanswer1;
@property (weak, nonatomic) IBOutlet UITableViewCell *cellanswer2;
@property (weak, nonatomic) IBOutlet UITableViewCell *cellanswer3;


@property (nonatomic, strong) id<SendMessageDelegate> sendMessageDelegate;



@end
