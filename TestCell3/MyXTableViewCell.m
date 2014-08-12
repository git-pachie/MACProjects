//
//  MyXTableViewCell.m
//  TestCell3
//
//  Created by pachie on 12/8/14.
//  Copyright (c) 2014 Private. All rights reserved.
//

#import "MyXTableViewCell.h"

@implementation MyXTableViewCell

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
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
