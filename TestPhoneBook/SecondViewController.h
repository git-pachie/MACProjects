//
//  SecondViewController.h
//  TestPhoneBook
//
//  Created by pachie on 11/8/14.
//  Copyright (c) 2014 Private. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PhoneBookTableViewController.h"

@interface SecondViewController : UIViewController <ModalViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UILabel *labelName;
- (IBAction)btnSelectContact:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *labelSelectedContact;

@end
