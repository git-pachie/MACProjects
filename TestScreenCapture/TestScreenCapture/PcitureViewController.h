//
//  PcitureViewController.h
//  TestScreenCapture
//
//  Created by pachie on 16/7/14.
//  Copyright (c) 2014 Private. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface PcitureViewController : UIViewController <UIImagePickerControllerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *image1;
- (IBAction)choosePhoto:(id)sender;

- (IBAction)takePicture:(id)sender;

@end
