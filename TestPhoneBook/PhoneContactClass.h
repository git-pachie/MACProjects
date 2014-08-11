//
//  PhoneContactClass.h
//  TestPhoneBook
//
//  Created by pachie on 11/8/14.
//  Copyright (c) 2014 Private. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AddressBook/AddressBook.h>

@interface PhoneContactClass : NSObject

@property (nonatomic,strong) NSMutableArray *contactArray;


+(NSMutableArray *)GetPhoneContact;


@end
