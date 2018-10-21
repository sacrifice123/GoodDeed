//
//  GDGroupCell.m
//  GoodDeed
//
//  Created by xiaozhan on 2018/9/18.
//  Copyright © 2018年 GoodDeed. All rights reserved.
//

#import "GDGroupCell.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import "GDGroupListCell.h"
#import "GDHomeViewController.h"

@interface GDGroupCell()<UITextFieldDelegate,UIImagePickerControllerDelegate>

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *view1LeftConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *view1WidthConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *view2LeftConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *view3LeftConstraint;
@property (weak, nonatomic) IBOutlet UIButton *imageButton;
@property (nonatomic, strong) UIImagePickerController *imagePickerController;

@property (weak, nonatomic) IBOutlet UILabel *view1TitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *view2TitleLabel;
@property (weak, nonatomic) IBOutlet UITextField *view2Textfield;
@property (weak, nonatomic) IBOutlet UIButton *view2NextButton;
@property (weak, nonatomic) IBOutlet UILabel *view3TitleLabel;
@property (weak, nonatomic) IBOutlet UIButton *view3NextButton;
@property (weak, nonatomic) IBOutlet UILabel *view3EditLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *view3TitleLabelBottomConstraint;
@property (weak, nonatomic) IBOutlet UIButton *inviteButton;
@property (weak, nonatomic) IBOutlet UITextField *view3Textfield;



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
    
    self.view2Textfield.delegate = self;
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = 5;

    self.view1TitleLabel.text = @"与好友组队，扩大你的公益影响力。\n团队贡献每满￥1000，团队冠军\n额外奖励￥100。";
    self.imageButton.titleLabel.numberOfLines = 0;
    self.imageButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.view1WidthConstraint.constant = SCREEN_WIDTH-30;
    [self.contentView layoutIfNeeded];
    self.inviteButton.layer.borderWidth = 0.5;
    self.inviteButton.layer.borderColor = [UIColor colorWithHexString:@"#D7D7D7"].CGColor;
}

//创建与邀请
- (IBAction)createOrInvite:(UIButton *)sender {
    
    [self.view2NextButton setTitle:(sender.tag==0)?@"继续":@"下一步" forState:0];
    self.view2NextButton.tag = sender.tag;//
    self.view2TitleLabel.text = (sender.tag==0)?@"第1步：给你的团队取一个\n难忘的名字。\n":@"请输入你的邀请码";
    self.view2Textfield.text = nil;
    self.view2Textfield.placeholder = (sender.tag==0)?@"输入团队名称":@"ABCDE";

    self.view3TitleLabelBottomConstraint.constant = (sender.tag==0)?66:92;
    self.view3TitleLabel.text = (sender.tag==0)?@"第2步：完成你的个人资料，让\n你的队友认识他们的队长。":@"成功！欢迎来到此处为用户团队\n的名称团队的名称";
    self.view3EditLabel.hidden = !sender.tag;
    [self.view3NextButton setTitle:(sender.tag==0)?@"继续":@"下一步" forState:0];

    [UIView animateWithDuration:0.3 animations:^{
        
        self.view1LeftConstraint.constant = -(SCREEN_WIDTH-30);
        [self.contentView layoutIfNeeded];
    }];
}

- (IBAction)next:(UIButton *)sender {
    
    if (sender.tag<=1) {
        if (!self.view2Textfield.text||self.view2Textfield.text.length==0) {
            [self.view2Textfield becomeFirstResponder];
            return;
        }else{
            if (sender.tag==0&&self.view2Textfield.text&&self.view2Textfield.text.length<2) {
                [self showAlert:1];
                return;
            }

        }
        [UIView animateWithDuration:0.3 animations:^{
            
            self.view1LeftConstraint.constant = -(SCREEN_WIDTH-30)*2;
            [self.contentView layoutIfNeeded];
        }];

    }else if (sender.tag == 2){//创建
        
        if (!self.view3Textfield.text) {
            [self showAlert:2];
            return;
        }
//        [UIView animateWithDuration:0.3 animations:^{
//
//            self.view1LeftConstraint.constant = -(SCREEN_WIDTH-30)*3;
//            [self.contentView layoutIfNeeded];
//
//        }];

        [GDHomeManager createGroupWithHeadUrl:@"" uidName:self.view3Textfield.text name:self.view2Textfield.text completionBlock:^(GDGroupListModel *model) {

            if (model) {
                [UIView animateWithDuration:0.3 animations:^{

                    self.view1LeftConstraint.constant = -(SCREEN_WIDTH-30)*3;
                    [self.contentView layoutIfNeeded];

                }];

            }


        }];
    }

}

//取消
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

//完成
- (IBAction)finish:(id)sender {
    
    GDHomeViewController *homeVc = (GDHomeViewController *)[GDHelper getSuperVc:self];
    GDUserModel *model = [GDLunchManager sharedManager].userModel;
    model.isCreatedGroup = YES;
    [homeVc reloadDataWithIndex:2];
}

//邀请你的朋友
- (IBAction)invite_mail:(id)sender {
    
}
- (IBAction)invite_wechat:(id)sender {
    
}
- (IBAction)invite_weibo:(id)sender {
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [self.view2Textfield resignFirstResponder];
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


-(void)showAlert:(NSInteger)index {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"名字过短" message:@"请输入2到16个字符" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"重新输入" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (index==1) {
            [self.view2Textfield becomeFirstResponder];

        }else if (index==2){
            [self.view3Textfield becomeFirstResponder];

        }
    }];
    [alert addAction:action1];
    UIViewController *vc = [GDHelper getSuperVc:self];
    [vc presentViewController:alert animated:YES completion:nil];
}

@end
