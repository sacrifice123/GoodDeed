//
//  GDGroupCell.m
//  GoodDeed
//
//  Created by xiaozhan on 2018/9/18.
//  Copyright © 2018年 GoodDeed. All rights reserved.
//

#import "GDGroupCell.h"
#import <MobileCoreServices/MobileCoreServices.h>


@interface GDGroupCell()<UITextFieldDelegate,UIImagePickerControllerDelegate>

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *view1LeftConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *view1WidthConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *view2LeftConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *view3LeftConstraint;
@property (weak, nonatomic) IBOutlet UIButton *imageButton;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (nonatomic, strong) UIImagePickerController *imagePickerController;
@property (weak, nonatomic) IBOutlet UILabel *view1TitleLabel;

@property (weak, nonatomic) IBOutlet UITextField *view1Textfield;
@property (weak, nonatomic) IBOutlet UIButton *view1NextButton;
@property (weak, nonatomic) IBOutlet UILabel *view2TitleLabel;
@property (weak, nonatomic) IBOutlet UIButton *view2NextButton;
@property (weak, nonatomic) IBOutlet UILabel *view2EditLabel;

@end

@implementation GDGroupCell

- (UIImagePickerController *)imagePickerController{
    
    if (_imagePickerController == nil) {
        _imagePickerController = [[UIImagePickerController alloc] init];
        // 设置代理
        _imagePickerController.delegate = self;
        // 是否显示裁剪框编辑（默认为NO），等于YES的时候，照片拍摄完成可以进行裁剪
        _imagePickerController.allowsEditing = YES;
        
    }
    
    return _imagePickerController;
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.textField.delegate = self;
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = 5;

    self.imageButton.titleLabel.numberOfLines = 0;
    self.imageButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.view1WidthConstraint.constant = SCREEN_WIDTH-30;
    [self.contentView layoutIfNeeded];
    
}

- (IBAction)createOrInvite:(UIButton *)sender {
    
    if (sender.tag == 0) {//创建团队
        
        self.view2EditLabel.hidden = YES;
        
    }else if (sender.tag == 1){//邀请码邀请
        
        self.view2EditLabel.hidden = NO;
    }
    [UIView animateWithDuration:0.3 animations:^{
        
        self.view1LeftConstraint.constant = -(SCREEN_WIDTH-30);
        [self.contentView layoutIfNeeded];
    }];
}

//邀请
- (IBAction)invite:(id)sender {
    
    
}

- (IBAction)next:(UIButton *)sender {
    if (sender.tag==1) {
        if (!self.textField||self.textField.text.length==0) {
            [self.textField becomeFirstResponder];
            return;
        }else if (self.textField&&self.textField.text.length<2){
            [self showAlert];
            return;

        }
        [UIView animateWithDuration:0.3 animations:^{
            
            self.view1LeftConstraint.constant = -(SCREEN_WIDTH-30)*2;
            [self.contentView layoutIfNeeded];
        }];

    }

}
- (IBAction)cancel:(UIButton *)sender {
    [UIView animateWithDuration:0.3 animations:^{
        
        self.view1LeftConstraint.constant = -(SCREEN_WIDTH-30)*(sender.tag-1);
        [self.contentView layoutIfNeeded];

    }];

}

//编辑头像
- (IBAction)editPhoto:(UIButton *)sender {
    [self chooseImage];
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [self.textField resignFirstResponder];
    return YES;
}

- (void)chooseImage {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    // Create the actions.
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        [self showCamera];
    }];
    
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"从手机相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        [self selectImageFromAlbum];
        
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
    }];
    
    
    // Add the actions.
    [alertController addAction:action1];
    [alertController addAction:action2];
    [alertController addAction:cancelAction];
    UIViewController *vc = [GDHelper getSuperVc:self];
    [vc presentViewController:alertController animated:YES completion:nil];
}

#pragma mark 打开相机
- (void)showCamera{
    
    // 设置照片来源为相机
    self.imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
    // 设置进入相机时使用前置或后置摄像头
    self.imagePickerController.cameraDevice = UIImagePickerControllerCameraDeviceRear;
    UIViewController *vc = [GDHelper getSuperVc:self];
    // 展示选取照片控制器
    [vc presentViewController:self.imagePickerController animated:YES completion:nil];
    
}


#pragma mark 从相册获取图片
- (void)selectImageFromAlbum
{
    self.imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    UIViewController *vc = [GDHelper getSuperVc:self];
    [vc presentViewController:self.imagePickerController animated:YES completion:nil];
}

#pragma mark - UIImagePickerControllerDelegate
// 完成图片的选取后调用的方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    // 选取完图片后跳转回原控制器
    [picker dismissViewControllerAnimated:YES completion:nil];
    // 从info中将图片取出，并加载到imageView当中
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    [self.imageButton setBackgroundImage:image forState:0];
    [self.imageButton setTitle:@"" forState:0];
    
}

// 取消选取调用的方法
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    UIViewController *vc = [GDHelper getSuperVc:self];
    [vc dismissViewControllerAnimated:YES completion:nil];
}


-(void)showAlert {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"名字过短" message:@"请输入2到16个字符" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"重新输入" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self.textField becomeFirstResponder];
    }];
    [alert addAction:action1];
    UIViewController *vc = [GDHelper getSuperVc:self];
    [vc presentViewController:alert animated:YES completion:nil];
}

@end
