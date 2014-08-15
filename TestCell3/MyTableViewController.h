//
//  MyTableViewController.h
//  TestCell3
//
//  Created by pachie on 12/8/14.
//  Copyright (c) 2014 Private. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyXTableViewCell.h"

@interface MyTableViewController : UITableViewController <NSXMLParserDelegate>

@property (strong) MyXTableViewCell *cellPrototype;

//- (NSString *)urlEncode;

@end
