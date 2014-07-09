//
//  DetailViewController.h
//  JSONTableParser
//
//  Created by Archie Angeles on 10/7/14.
//  Copyright (c) 2014 PachieOrg. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (nonatomic, strong) NSString *TemplateDetail;
@property (weak, nonatomic) IBOutlet UILabel *txtDetail;

@end
