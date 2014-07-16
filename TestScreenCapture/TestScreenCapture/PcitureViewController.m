//
//  PcitureViewController.m
//  TestScreenCapture
//
//  Created by pachie on 16/7/14.
//  Copyright (c) 2014 Private. All rights reserved.
//

#import "PcitureViewController.h"

@interface PcitureViewController ()

@end

@implementation PcitureViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIApplication* app = [UIApplication sharedApplication];
    app.networkActivityIndicatorVisible = YES;
    
    _image1.image = [self loadImage];
}


- (UIImage*)loadImage
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                         NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString* path = [documentsDirectory stringByAppendingPathComponent:
                      @"test123.png" ];
    UIImage* image = [UIImage imageWithContentsOfFile:path];
    _image1.contentMode = UIViewContentModeCenter;
    return image;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)choosePhoto:(id)sender {
    UIImagePickerController *imagePickerController= [[UIImagePickerController alloc] init];
    [imagePickerController setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    
    // image picker needs a delegate so we can respond to its messages
    [imagePickerController setDelegate:self];
    
    // Place image picker on the screen
    //[self presentModalViewController:imagePickerController animated:YES];
    
    [self presentViewController:imagePickerController animated:YES completion:nil];
    
    
}

- (IBAction)takePicture:(id)sender {
    
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        [imagePickerController setSourceType:UIImagePickerControllerSourceTypeCamera];
    }
    
    // image picker needs a delegate,
    [imagePickerController setDelegate:self];
    
    // Place image picker on the screen
    
    //[self presentModalViewController:imagePickerController animated:YES];
    
    [self presentViewController:imagePickerController animated:YES completion:nil];
    
    
    
}


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [self dismissViewControllerAnimated:YES completion:nil];
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    [_image1 setImage:image];    // "myImageView" name of any UIImageView.
    
    if (image != nil)
    {
        
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                             NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSString* path = [documentsDirectory stringByAppendingPathComponent:
                          @"test123.png" ];
        NSData* data = UIImagePNGRepresentation(image);
        [data writeToFile:path atomically:YES];
    }
}
@end
