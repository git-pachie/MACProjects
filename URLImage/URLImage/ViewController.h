//
//  ViewController.h
//  URLImage
//
//  Created by pachie on 21/5/14.
//  Copyright (c) 2014 Private. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITextFieldDelegate>
{
    IBOutlet UIImageView *imageKo;
    IBOutlet UITextField *txtURL;
}
-(IBAction)LoadImage:(id)sender;


@end
