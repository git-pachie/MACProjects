//
//  DeviceDetailViewController.h
//  CoreDataSample
//
//  Created by pachie on 27/5/14.
//  Copyright (c) 2014 Private. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DeviceDetailViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *versionTextField;
@property (weak, nonatomic) IBOutlet UITextField *companyTextField;


- (IBAction)save:(id)sender;

- (IBAction)cancel:(id)sender;


@end
