//
//  PhoneContactClass.m
//  TestPhoneBook
//
//  Created by pachie on 11/8/14.
//  Copyright (c) 2014 Private. All rights reserved.
//

#import "PhoneContactClass.h"
#import "EntityPerson.h"
#import "EntityPerson.h"

@implementation PhoneContactClass

+(NSMutableArray *)GetPhoneContact
{
    
    
    NSMutableArray *mArray =[[NSMutableArray alloc]init];
    
    mArray=[[NSMutableArray alloc] init];
    
    CFErrorRef error = NULL;
    ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, &error);
    
    if (addressBook != nil) {
        NSLog(@"Succesful.");
        
        //2
        NSArray *allContacts = (__bridge_transfer NSArray *)ABAddressBookCopyArrayOfAllPeople(addressBook);
        
        //3
        NSUInteger i = 0; for (i = 0; i < [allContacts count]; i++)
        {
            
            // Person *person = [[Person alloc] init];
            ABRecordRef contactPerson = (__bridge ABRecordRef)allContacts[i];
            
            //4
            NSString *firstName = (__bridge_transfer NSString *)ABRecordCopyValue(contactPerson,
                                                                                  kABPersonFirstNameProperty);
            NSString *lastName = (__bridge_transfer NSString *)ABRecordCopyValue(contactPerson, kABPersonLastNameProperty); NSString *fullName = [NSString stringWithFormat:@"%@ %@", firstName, lastName];
            
            EntityPerson *person = [[EntityPerson alloc]init];
            
//            NSString *pFirstName = firstName;
//            NSString *pLasttName = lastName;
//            NSString *FullName = fullName;
            NSString *pEmail;
            NSString *pwEmail;
            
            person.Name = [fullName stringByReplacingOccurrencesOfString:@"(null)" withString:@""  ];
            person.FirstName = [firstName stringByReplacingOccurrencesOfString:@"(null)" withString:@""  ];
            person.LastName = [lastName stringByReplacingOccurrencesOfString:@"(null)" withString:@""  ];
            
            //email
            //5
            ABMultiValueRef emails = ABRecordCopyValue(contactPerson, kABPersonEmailProperty);
            
            //6
            NSUInteger j = 0;
            for (j = 0; j < ABMultiValueGetCount(emails); j++) {
                NSString *email = (__bridge_transfer NSString *)ABMultiValueCopyValueAtIndex(emails, j);
                if (j == 0) {
                    pEmail = email;
                    person.Email = email;
                    //NSLog(@"person.homeEmail = %@ ", person.homeEmail);
                }
                else if (j==1)
                    pwEmail = email;
                person.Email = email;
            }
            
            
            
            NSString *pMobile;
            
            ABMultiValueRef contact = ABRecordCopyValue(contactPerson, kABPersonPhoneProperty);
            
            //6
            //NSUInteger j = 0;
            for (j = 0; j < ABMultiValueGetCount(contact); j++) {
                NSString *con = (__bridge_transfer NSString *)ABMultiValueCopyValueAtIndex(contact, j);
                //                NSString *con2 = (__bridge_transfer NSString *)ABMultiValueCopyLabelAtIndex(contact, j);
                if (j == 0) {
                    pMobile = con;
                    person.Number = con;
                    //NSLog(@"person.homeEmail = %@ ", person.homeEmail);
                }
                
            }
            
//            NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:FullName,@"Name"
//                                 ,pMobile,@"Mobile"
//                                 , nil];
            
            if (!person.Name) {
                continue;
            }
            if (!person.Number) {
                continue;
            }
            
            
            
            [mArray  addObject:person];
            //7
            // [mArary addObject:person];
        }
        
        
        NSArray *sortedArray;
        
        sortedArray = [mArray sortedArrayUsingComparator:^NSComparisonResult(EntityPerson *a,  EntityPerson *b) {
            NSString *first = [(EntityPerson *) a Name];
            NSString *second = [(EntityPerson *) b Name];
            
            
            return [first compare:second];
            
        }];

        mArray = (NSMutableArray *)sortedArray;
        
        //8
        CFRelease(addressBook);
    } else {
        //9
        NSLog(@"Error reading Address Book");
    }
    
    return mArray;

    
}



@end
