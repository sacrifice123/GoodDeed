//
//  GDEditCollectionViewController.m
//  GoodDeed
//
//  Created by HK on 2018/8/21.
//  Copyright © 2018 GoodDeed. All rights reserved.
//

#import "GDEditCollectionViewController.h"
#import "LZImageCropping+GDCrop.h"

#import "GDEditQuestionCollectionViewCell.h"
#import "GDImageVoteAnswerCollectionViewCell.h"
#import "GDImageVoteAddOptionCollectionViewCell.h"
#import "GDSurveyPageProtocol.h"
static CGFloat Margin = 24.f;
static CGFloat Space = 24.f;

@interface GDEditCollectionViewController () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UINavigationControllerDelegate, UIImagePickerControllerDelegate, LZImageCroppingDelegate,GDSurveyPageProtocol>

@property (strong, nonatomic) UICollectionView *collectionView;
@property (strong, nonatomic) GDEditPageModel *pageModel;

@property (strong, nonatomic) GDEditImageViewModel *fillImageViewModel;

@end

@implementation GDEditCollectionViewController

- (instancetype)initWithPageModel:(GDEditPageModel *)pageModel
{
    self = [super init];
    if (self) {
        _pageModel = pageModel;
        [self setupViews];
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupCollectionViews];
}


#pragma mark - <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.pageModel numberOfItems];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    GDEditBaseViewModel *item = [self.pageModel itemAtIndex:indexPath.row];
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:item.kCellReuseId forIndexPath:indexPath];
    if ([cell isKindOfClass:[GDEditQuestionCollectionViewCell class]]) {
        GDEditQuestionCollectionViewCell *questionCell = (GDEditQuestionCollectionViewCell *)cell;
        questionCell.viewModel = item;
        questionCell.updateHeight = ^(UICollectionViewCell *cell) {
            NSIndexPath *indexPath = [collectionView indexPathForCell:cell];
            NSIndexPath *tempIndexPath = [NSIndexPath indexPathForRow:(indexPath.row + 1) inSection:indexPath.section];
            [collectionView reloadItemsAtIndexPaths:@[tempIndexPath]];
        };
        

    } else if ([cell isKindOfClass:[GDImageVoteAnswerCollectionViewCell class]]) {
        GDImageVoteAnswerCollectionViewCell *answerCell = (GDImageVoteAnswerCollectionViewCell *)cell;
        answerCell.viewModel = (GDEditImageViewModel *)item;
        __weak typeof(self) weak_self = self;
        answerCell.deleteEvent = ^(UICollectionViewCell *cell, GDEditBaseViewModel *deleteModel) {
            [weak_self.pageModel removeOption:deleteModel];
            [weak_self.collectionView reloadData];
        };
        
    } else if ([cell isKindOfClass:[GDImageVoteAddOptionCollectionViewCell class]]) {
        GDImageVoteAddOptionCollectionViewCell *addCell = (GDImageVoteAddOptionCollectionViewCell *)cell;
        
    }

    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    GDEditBaseViewModel *item = [self.pageModel itemAtIndex:indexPath.row];
    if ([item isKindOfClass:[GDEditQuestionViewModel class]]) {
        
    } else if ([item isKindOfClass:[GDEditImageViewModel class]]) {
        self.fillImageViewModel = (GDEditImageViewModel *)item;
        [self chooseImage];
        
    } else if ([item isKindOfClass:[GDEditToolViewModel class]]) {
        [self.pageModel addOption];
        [collectionView reloadData];
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    GDEditBaseViewModel *item = [self.pageModel itemAtIndex:indexPath.row];
    if ([item isKindOfClass:[GDEditQuestionViewModel class]]) {
        return CGSizeMake(CGRectGetWidth(collectionView.frame), item.cellHeight);
    } else if ([item isKindOfClass:[GDEditImageViewModel class]]) {
        CGFloat sizeWH = (CGRectGetWidth(collectionView.frame) - Space) / 2.f;
        return CGSizeMake(sizeWH, sizeWH);
    } else if ([item isKindOfClass:[GDEditToolViewModel class]]) {
        return CGSizeMake(CGRectGetWidth(collectionView.frame), 71);
    } else {
        return CGSizeZero;
    }
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return Space;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return Space;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(50, 0, 0, 0);
}

#pragma mark - Choose Image
- (void)chooseImage
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"选择你的调查问卷背景图片" preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *cameraAction = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
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
    LZImageCropping *cropping = [LZImageCropping surveyImageVoteCropImage:orientationImage delegate:self];
    [picker dismissViewControllerAnimated:NO completion:nil];
    [self presentViewController:cropping animated:NO completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    
}

#pragma mark -
-(void)lzImageCropping:(LZImageCropping *)cropping didCropImage:(UIImage *)image
{
    self.fillImageViewModel.image = image;
    [self.collectionView reloadData];
}

-(void)lzImageCroppingDidCancle:(LZImageCropping *)cropping
{
}

#pragma mark - Private
- (void)setupViews
{
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).with.insets(UIEdgeInsetsMake(0, Margin, 0, Margin));
    }];
}

- (void)setupCollectionViews
{
    // Question
    [self.collectionView registerClass:[GDEditQuestionCollectionViewCell class] forCellWithReuseIdentifier:kImageVoteQuestionCell];
    
    // Answer
    UINib *answerCellNib  = [UINib nibWithNibName:@"GDImageVoteAnswerCollectionViewCell" bundle:nil];
    [self.collectionView registerNib:answerCellNib forCellWithReuseIdentifier:kImageVoteAnswerCell];
    
    // Add
    UINib *addCellNib = [UINib nibWithNibName:@"GDImageVoteAddOptionCollectionViewCell" bundle:nil];
    [self.collectionView registerNib:addCellNib forCellWithReuseIdentifier:kImageVoteAddOptionCell];
}


#pragma mark - Setter, Getter
- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:flowLayout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
    }
    return _collectionView;
}


@end
