//
//  CustomStaticTableViewController.h
//  SampleJSON
//
//  Created by pachie on 15/7/14.
//  Copyright (c) 2014 PachieOrg. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MobileCoreServices/MobileCoreServices.h>

@interface CustomStaticTableViewController : UITableViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic, strong) NSString *accountType;
@property (nonatomic, strong) NSString *emailAddress;

@property (strong, nonatomic) IBOutlet UIImageView *profilepic;


@property BOOL newMedia;

- (IBAction)takePhoto:(id)sender;
- (IBAction)loadExistingPhoto:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *btntakephoto;
@property (weak, nonatomic) IBOutlet UIButton *btnloadexisting;

@property (weak, nonatomic) IBOutlet UITableViewCell *cellImageHolder;
@property (weak, nonatomic) IBOutlet UITableViewCell *cellButtonHolder;

@end
