//
//  CustomTableViewCell.m
//  ToPeso
//
//  Created by pachie on 27/8/14.
//  Copyright (c) 2014 Private. All rights reserved.
//

#import "CustomTableViewCell.h"
#import <QuartzCore/QuartzCore.h>


@implementation CustomTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
//    // Initialization code
//    self.imageView.image = [UIImage imageNamed:@"default.png"];
//    self.imageView.layer.cornerRadius = 10;
//    self.imageView.layer.borderWidth= 1;
//    self.imageView.clipsToBounds = YES;
    
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
