//
//  GDEditCoverViewController.m
//  GoodDeed
//
//  Created by HK on 2018/8/9.
//  Copyright © 2018 GoodDeed. All rights reserved.
//

#import "GDEditCoverViewController.h"
#import "LZImageCropping+GDCrop.h"
#import "GDTextView.h"
#import <IQKeyboardManager.h>

@interface GDEditCoverViewController () <UINavigationControllerDelegate, UIImagePickerControllerDelegate, LZImageCroppingDelegate>

@property (strong, nonatomic) GDTextView *textView;
@property (strong, nonatomic) UIImageView *coverImageView;
@property (strong, nonatomic) UILabel *choosePhotoTipLabel;
@property (strong, nonatomic) UIImageView *choosePhotoTipImageView;


// 填充内容
@property (copy, nonatomic) NSString *coverTitle;
@property (strong, nonatomic) UIImage *coverImage;

@end

@implementation GDEditCoverViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setupViews];
    }
    
    return self;
}


+ (GDEditCoverViewController *)editCoverViewController
{
    return [[GDEditCoverViewController alloc] init];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.


}

#pragma mark - <GDSurveyPageProtocol>
// 问卷类型
- (GDSurveyEditType)surveyType
{
    return GDSurveyTypeCoverInfo;
}

// 下一步
- (void)nextStep:(GDSurveyNextStepEvent)nextStep
{
    if (self.coverTitle.length > 0) {
        if (nextStep) {
            nextStep(self);
        }
    } else {
        if (![self.textView isFirstResponder]) {
            [self.textView becomeFirstResponder];
        }
    }
}

// 问卷内容
- (id)surveyContent
{
    return @"封面数据";
}


- (void)chooseImage
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"选择你的调查问卷背景图片" preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *cameraAction = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
//        picker.cameraCaptureMode = UIImagePickerControllerCameraCaptureModePhoto;
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:picker animated:YES completion:^{ }];
    }];
    
    UIAlertAction *photoAction = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:picker animated:YES completion:^{ }];
        
    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) { }];

    [alert addAction:cameraAction];
    [alert addAction:photoAction];
    [alert addAction:cancelAction];
    [self presentViewController:alert animated:YES completion:nil];
}


#pragma mark -
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    UIImage *orientationImage = [info valueForKey:UIImagePickerControllerOriginalImage];
    LZImageCropping *cropping = [LZImageCropping surveyCoverCropImage:orientationImage delegate:self];
    [picker dismissViewControllerAnimated:NO completion:nil];
    [self presentViewController:cropping animated:NO completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    
}

#pragma mark -
-(void)lzImageCropping:(LZImageCropping *)cropping didCropImage:(UIImage *)image
{
    self.coverImageView.image = image;
}

-(void)lzImageCroppingDidCancle:(LZImageCropping *)cropping
{
}

#pragma mark - Private
- (void)setupViews
{
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.coverImageView];
    [self.view addSubview:self.textView];
    [self.view addSubview:self.choosePhotoTipImageView];
    [self.view addSubview:self.choosePhotoTipLabel];
    
    [self.coverImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).with.offset(GDScaleValue(30.f));
        make.right.equalTo(self.view.mas_right).with.offset(GDScaleValue(-30.f));
        make.top.equalTo(self.view).with.offset(GDScaleValue(100.f));
        make.bottom.equalTo(self.choosePhotoTipImageView.mas_top).with.offset(GDScaleValue(-7.5));
    }];
    
    [self.choosePhotoTipImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.centerY.equalTo(self.view);
        make.width.equalTo(@GDScaleValue(194/2.f));
        make.height.equalTo(@GDScaleValue(154/2.f));
    }];
    
    [self.choosePhotoTipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.choosePhotoTipImageView.mas_bottom).with.offset(GDScaleValue(7.5));
    }];
}

#pragma mark - Setter, Getter

- (NSString *)coverTitle
{
    return self.textView.gdText;
}

- (GDTextView *)textView
{
    if (!_textView) {
        _textView = [[GDTextView alloc] init];
        _textView.placeholer = @"点击此处\n添加一个封面标题";
        _textView.textAlignment = NSTextAlignmentCenter;
        _textView.font = [UIFont systemFontOfSize:25.f];
        _textView.textColor = [UIColor colorWithHex:0xCCCCCC];
        _textView.backgroundColor = [UIColor clearColor];
        _textView.scrollEnabled = YES;
    }
    
    return _textView;
}

- (UIImageView *)coverImageView
{
    if (!_coverImageView) {
        _coverImageView = [[UIImageView alloc] init];
    }
    return _coverImageView;
}

- (UILabel *)choosePhotoTipLabel
{
    if (!_choosePhotoTipLabel) {
        _choosePhotoTipLabel = [[UILabel alloc] init];
        _choosePhotoTipLabel.font = [UIFont systemFontOfSize:15.f];
        _choosePhotoTipLabel.textColor = [UIColor colorWithHex:0xCCCCCC];
        _choosePhotoTipLabel.text = @"添加背景图片";
    }
    
    return _choosePhotoTipLabel;
}

- (UIImageView *)choosePhotoTipImageView
{
    if (!_choosePhotoTipImageView) {
        _choosePhotoTipImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"survey_photo"]];
        _choosePhotoTipImageView.userInteractionEnabled = YES;
        [_choosePhotoTipImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(chooseImage)]];
    }
    return _choosePhotoTipImageView;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.textView resignFirstResponder];
}


@end
