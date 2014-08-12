//
//  PhoneBookTableViewController.h
//  TestPhoneBook
//
//  Created by pachie on 11/8/14.
//  Copyright (c) 2014 Private. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AddressBook/AddressBook.h>
#import "EntityPerson.h"

@protocol ModalViewControllerDelegate <NSObject>

-(void)GetSelectedPerson: (EntityPerson *) selectedPerson;

@end


@interface PhoneBookTableViewController : UITableViewController 

@property (nonatomic, assign) id<ModalViewControllerDelegate> Xdelexgate;
@property (nonatomic, strong) EntityPerson *selectedPerson;




@end
