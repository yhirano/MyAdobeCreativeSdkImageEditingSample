//
//  ViewController.m
//  MyAdobeCriativeSdkImageEditingSample
//
//  Created by Yuichi Hirano on 6/15/15.
//
//

#import "ViewController.h"
#import <AdobeCreativeSDKFoundation/AdobeCreativeSDKFoundation.h>
#import <AdobeCreativeSDKImage/AdobeCreativeSDKImage.h>
#import <AdobeCreativeSDKImage/AdobeImageEditorCustomization.h>

@interface ViewController () <UIImagePickerControllerDelegate, AdobeUXImageEditorViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (weak, nonatomic) IBOutlet UIButton *selectButton;

@end

@implementation ViewController
{
    UIImage *image_;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSString* const CreativeSDKClientId = @"<YOUR CLIENT ID>";
    NSString* const CreativeSDKClientSecret = @"<YOUR CLIENT SECRET>";
    [[AdobeUXAuthManager sharedManager] setAuthenticationParametersWithClientID:CreativeSDKClientId clientSecret:CreativeSDKClientSecret enableSignUp:NO];
    [AdobeImageEditorCustomization setToolOrder:@[kAFStickers, kAFFrames, kAFEnhance, kAFCrop]];
}

- (void)launchPhotoEditorWithImage:(UIImage*)image
{
    // Create photo editor
    AdobeUXImageEditorViewController *photoEditor = [[AdobeUXImageEditorViewController alloc] initWithImage:image];
    [photoEditor setDelegate:self];
    
    // Present the editor
    [self presentViewController:photoEditor animated:YES completion:nil];
    
}

- (void)photoEditor:(AdobeUXImageEditorViewController *)editor finishedWithImage:(UIImage *)image
{
    [self dismissViewControllerAnimated:YES completion:nil];
    _imageView.image = image;
    image_ = image;
}

- (void)photoEditorCanceled:(AdobeUXImageEditorViewController *)editor
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)tapSelectButton:(id)sender {
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    if ([UIImagePickerController isSourceTypeAvailable:sourceType]) {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.sourceType = sourceType;
        picker.delegate = self;
        [self presentViewController:picker animated:YES completion:nil];
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    image_ = [info objectForKey:UIImagePickerControllerOriginalImage];
    _imageView.image = image_;
    [self dismissViewControllerAnimated:YES completion:^{
        [self launchPhotoEditorWithImage:image_];
    }];
}
@end
