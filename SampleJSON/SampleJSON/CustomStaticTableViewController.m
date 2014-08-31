//
//  CustomStaticTableViewController.m
//  SampleJSON
//
//  Created by pachie on 15/7/14.
//  Copyright (c) 2014 PachieOrg. All rights reserved.
//

#import "CustomStaticTableViewController.h"
#import "AppDelegate.h"

#import "CommonFunction.h"
#import "CommonSendRequest.h"
#import "CustomStringClass.h"

@interface CustomStaticTableViewController ()
{

dispatch_queue_t camerq;
    
}
@end

@implementation CustomStaticTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [CustomStringClass ApplyRountedBorderToButton:self.btnloadexisting];
    [CustomStringClass ApplyRountedBorderToButton:self.btntakephoto];
    
    if (!camerq) {
        camerq = dispatch_queue_create("cameraQUE",NULL);
    }
    
    dispatch_async(camerq, ^{
        
        //self.profilepic.image =
        [self loadImage];
        [self ApplyCircleToImage:self.profilepic];
        
    });
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)takePhoto:(id)sender {
    

    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.delegate = self;
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera; imagePicker.mediaTypes = @[(NSString *) kUTTypeImage]; imagePicker.allowsEditing = NO;
        [self presentViewController:imagePicker  animated:YES completion:nil];
        _newMedia = YES;
    
    }


}

- (IBAction)loadExistingPhoto:(id)sender {

    
    
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeSavedPhotosAlbum])
    {
        UIImagePickerController *imagePicker =
        [[UIImagePickerController alloc] init]; imagePicker.delegate = self; imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
        imagePicker.mediaTypes = @[(NSString *) kUTTypeImage];
        imagePicker.allowsEditing = NO;
        [self presentViewController:imagePicker
                           animated:YES completion:nil];
        _newMedia = NO;
        
        //[CommonSendRequest  SendProfileToServer:image];
    }
    
    
    
    

}


-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSString *mediaType = info[UIImagePickerControllerMediaType]; [self dismissViewControllerAnimated:YES completion:nil];
    if ([mediaType isEqualToString:(NSString *)kUTTypeImage]) {
        UIImage *image = info[UIImagePickerControllerOriginalImage];
        self.profilepic.image = image;
        if (_newMedia)
            
            UIImageWriteToSavedPhotosAlbum(image, self,@selector(image:finishedSavingWithError:contextInfo:), nil);
        
        //self.profilepic.image = [self loadImage];
        
        
        if (image != nil)
        {
            
            
            NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
            NSString *documentsDirectory = [paths objectAtIndex:0];
            NSString* path = [documentsDirectory stringByAppendingPathComponent:
                              [CommonFunction ProfileImageFileName]];
            NSData* data = UIImagePNGRepresentation(image);
            [data writeToFile:path atomically:YES];
        }
        
        [CommonSendRequest  SendProfileToServer:image];
        
        [self ApplyCircleToImage:self.profilepic];
    
    }
    else if ([mediaType isEqualToString:(NSString *)kUTTypeMovie])
    {
        }

    
}

-(void)image:(UIImage *)image finishedSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    if (error) {
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @"Save failed"
                              message: @"Failed to save image"
                              delegate: nil
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        [alert show];
    }
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];

}



-(void)ApplyCircleToImage : (UIView *)image
{
    dispatch_async(dispatch_get_main_queue(), ^{
    
        image.layer.cornerRadius = image.frame.size.width/2;// self.profileImageView.frame.size.width / 2
        image.clipsToBounds = YES;
        
        
        
    });

}

- (void)loadImage
{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                             NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSString* path = [documentsDirectory stringByAppendingPathComponent:
                          [CommonFunction ProfileImageFileName]];
        UIImage* image = [UIImage imageWithContentsOfFile:path];
        //_profilepic.contentMode = UIViewContentModeCenter;
        
        //_profilepic.contentMode = UIViewContentModeScaleAspectFill;
        
        self.profilepic.image = image;
        
        [CommonSendRequest  SendProfileToServer:image];
        
        
        
    });
    
    
    
    
}
@end
