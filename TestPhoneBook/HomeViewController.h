//
//  HomeViewController.h
//  TestPhoneBook
//
//  Created by pachie on 11/8/14.
//  Copyright (c) 2014 Private. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PhoneBookTableViewController.h"
#import "EntityPerson.h"

@interface HomeViewController : UIViewController <ModalViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UILabel *labelSelectedContact;
@property (nonatomic,strong) EntityPerson *selectedPerson;

- (IBAction)btnShowModal:(id)sender;

@end
