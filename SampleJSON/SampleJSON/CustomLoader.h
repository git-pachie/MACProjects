//
//  CustomLoader.h
//  SampleJSON
//
//  Created by pachie on 10/8/14.
//  Copyright (c) 2014 PachieOrg. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CustomLoader : NSObject

@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) UIActivityIndicatorView* spinner;
@property (nonatomic, strong) UIView *xview;

-(void)HideLoading:(UITableViewController * ) table ;
-(void)InitializeLoader: (UITableViewController * ) table;

@end
