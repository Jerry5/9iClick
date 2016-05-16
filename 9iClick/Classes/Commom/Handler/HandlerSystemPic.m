//
//  HandlerSystemPic.m
//  HealthUp
//
//  Created by Jerry on 16/1/20.
//  Copyright © 2016年 武志远. All rights reserved.
//

#import "HandlerSystemPic.h"

@interface HandlerSystemPic ()<UIActionSheetDelegate,UIImagePickerControllerDelegate>
{
    UIViewController * _parentController;
}

@end

@implementation HandlerSystemPic

+ (void)load
{
    [HandlerAct registerHandlerAction:[[HandlerSystemPic alloc] init] andKey:@"systemPic"];
}

- (void)performActionWichController:(UIViewController *)controller complete:(void(^)(id completeResult))complete;
{
    _complete = complete;
    _parentController = controller;
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:(id)self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从相册选择",@"取消",nil];
    
    [actionSheet showInView:_parentController.view];
}

#pragma mark - ActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0:
        {
            UIImagePickerController *picker = [[UIImagePickerController alloc] init];
            picker.sourceType = UIImagePickerControllerSourceTypeCamera;
            picker.editing = NO;
            picker.allowsEditing = NO;
            picker.delegate = (id)self;
            [_parentController presentViewController:picker animated:YES completion:nil];
            break;
        }
        case 1:
        {
            UIImagePickerController *picker = [[UIImagePickerController alloc] init];
            picker.delegate = (id)self;
            picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            picker.editing = NO;
            picker.allowsEditing = YES;
            [_parentController presentViewController:picker animated:YES completion:nil];
            break;
        }
        default:
            break;
    }
}

#pragma mark - UIImagePickerControllerDelegate
- (void) imagePickerController: (UIImagePickerController*) picker didFinishPickingMediaWithInfo: (NSDictionary*) info
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    UIImage *edit = [info objectForKey:@"UIImagePickerControllerEditedImage"];
    UIImage *originalImage = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    NSData * originalImageData = UIImageJPEGRepresentation(originalImage,0.5);
    CLog(@" EditedImage %@ ",NSStringFromCGSize(edit.size));
    CLog(@" OriginalImage %@ ",NSStringFromCGSize(originalImage.size));
    UIImage *aImage = edit;
    NSData * imageData = UIImageJPEGRepresentation(aImage,0.5);
    
    NSDictionary *data = @{@"originalImage":originalImageData,@"EditedImage":@""};
    _complete(data);
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}


@end
