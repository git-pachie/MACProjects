//
//  MessageDetailViewController.h
//  SampleJSON
//
//  Created by Archie Angeles on 13/7/14.
//  Copyright (c) 2014 PachieOrg. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PhoneBookTableViewController.h"
#import "Dev2ActivationViewController.h"
#import "VerifyRegistrationViewController.h"

@protocol SendMessageDelegate <NSObject>

-(void)sendMessageToSelectedPerson: (EntityPerson *) selectedPerson MessageGUID:(NSString *) messageGUID;

@end

@interface MessageDetailViewController : UIViewController <ModalViewControllerDelegate, RegistrationDelegate, VerificaitionDelegate>

@property (nonatomic, strong) NSString *MessageGUID;
@property (nonatomic, strong) NSString *HiritMessage;
@property (nonatomic, strong) NSString *CreatedBy;
@property (nonatomic, strong) NSString *Answer;
@property  (nonatomic, strong)NSString *phoneNumber;

@property (nonatomic, strong) id<SendMessageDelegate> sendMessageDelegate;

@property (weak, nonatomic) IBOutlet UILabel *lblhiritMessage;

@property (weak, nonatomic) IBOutlet UIButton *btnsendtosomeone;


- (IBAction)Send:(UIBarButtonItem *)sender;
-(void)dochecking: (NSString *)returnValue;
@end
