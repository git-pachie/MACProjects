//
//  OneViewController.h
//  SampleLocalNotification
//
//  Created by pachie on 28/7/14.
//  Copyright (c) 2014 Private. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OneViewController : UIViewController

@property (nonatomic,strong) NSString *messageID;
@property (weak, nonatomic) IBOutlet UILabel *lblMessageID;

@end