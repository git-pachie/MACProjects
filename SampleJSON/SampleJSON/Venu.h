//
//  Venu.h
//  PickupLines
//
//  Created by Archie Angeles on 25/8/14.
//  Copyright (c) 2014 PachieOrg. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Venu : NSObject
@property (strong, nonatomic) NSString *name;
@property (assign, nonatomic) NSInteger numberOfPeopleHereNow;
@property (strong, nonatomic) NSString *address;
@property (strong, nonatomic) NSString *city;
@property (strong, nonatomic) NSString *state;
@property (assign, nonatomic) NSInteger zipCode;
@property (assign, nonatomic) CGFloat latitude;
@property (assign, nonatomic) CGFloat longitude;
@property (strong, nonatomic) NSURL *menuURL;
@property (strong, nonatomic) NSURL *reservationURL;
@property (assign, nonatomic) NSInteger checkInCount;
@property (assign, nonatomic) NSInteger usersCount;
@property (strong, nonatomic) NSString *foursquareId;
@property (strong, nonatomic) UIImage *image;

- (NSString *)subtitleText;

@end
