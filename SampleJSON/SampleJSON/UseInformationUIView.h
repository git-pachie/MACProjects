//
//  UseInformationUIView.h
//  PickupLines
//
//  Created by pachie on 2/9/14.
//  Copyright (c) 2014 PachieOrg. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UseInformationUIView : UIView
@property (weak, nonatomic) IBOutlet UIImageView *imgProfileImage;
@property (weak, nonatomic) IBOutlet UILabel *lblUserName;
@property (weak, nonatomic) IBOutlet UILabel *lblJoinedDate;
@property (weak, nonatomic) IBOutlet UILabel *lblTotalPickupLines;

+ (id)customView;

@end
