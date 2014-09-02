//
//  UseInformationUIView.m
//  PickupLines
//
//  Created by pachie on 2/9/14.
//  Copyright (c) 2014 PachieOrg. All rights reserved.
//

#import "UseInformationUIView.h"

@implementation UseInformationUIView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

+ (id)customView
{
    UseInformationUIView *customView = [[[NSBundle mainBundle] loadNibNamed:@"UserInfo" owner:nil options:nil] lastObject];
    
    // make sure customView is not nil or the wrong class!
    if ([customView isKindOfClass:[UseInformationUIView class]])
        return customView;
    else
        return nil;
}

@end
