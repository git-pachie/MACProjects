//
//  Venu.m
//  PickupLines
//
//  Created by Archie Angeles on 25/8/14.
//  Copyright (c) 2014 PachieOrg. All rights reserved.
//

#import "Venu.h"

@implementation Venu

- (id)init
{
    self = [super init];
    
    if (self) {
        self.image = [UIImage imageNamed:@"profile.png"];
    }
    
    return self;
}

- (NSString *)subtitleText
{
    return [NSString stringWithFormat:@"%i checkins, %i here now", self.checkInCount, self.numberOfPeopleHereNow];
}

@end
