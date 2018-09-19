//
//  GDEditTableViewController.m
//  GoodDeed
//
//  Created by HK on 2018/8/21.
//  Copyright © 2018 GoodDeed. All rights reserved.
//

#import "GDEditTableViewController.h"
#import "LZImageCropping+GDCrop.h"

#import "GDEditImageHeaderView.h"
#import "GDEditQuestionTableViewCell.h"
#import "GDEditBottomSettingView.h"

#import "GDChooseOneAnswerTableViewCell.h"
#import "GDChooseOneAddOptionTableViewCell.h"
#import "GDChooseMultipleAnswerTableViewCell.h"
#import "GDChooseMultipleAddOptionTableViewCell.h"
#import "GDSlidingScaleTableViewCell.h"
#import "GDBoundRangeAnswerTableViewCell.h"
#import "GDTextAnswerTableViewCell.h"

#import "GDStackRankIndexTableViewCell.h"
#import "GDStackRankEditTableViewCell.h"
#import "GDStackRankAddOptionTableViewCell.h"


@interface GDEditTableViewController () <UITableViewDelegate, UITableViewDataSource, UINavigationControllerDelegate, UIImagePickerControllerDelegate, LZImageCroppingDelegate>

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) GDEditPageModel *pageModel;
@property (strong, nonatomic) GDEditImageHeaderView *header;
@end

@implementation GDEditTableViewController

- (instancetype)initWithPageModel:(GDEditPageModel *)pageModel
{
    self = [super init];
    if (self) {
        _pageModel = pageModel;
    }
    
    return self;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupTableViews];
    [self setupViews];
}

#pragma mark - <UITableViewDelegate, UITableViewDataSource>

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.pageModel numberOfItems];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    GDEditBaseViewModel *item = [self.pageModel itemAtIndex:indexPath.section];
    cell = [tableView dequeueReusableCellWithIdentifier:item.kCellReuseId];
    
    if ([cell conformsToProtocol:@protocol(GDEditTextTypeCellProtocol)]) {
        UITableViewCell <GDEditTextTypeCellProtocol> *textCell = (UITableViewCell <GDEditTextTypeCellProtocol> *)cell;
        textCell.viewModel = item;
        textCell.updateHeight = ^(UITableViewCell *cell) {
            NSIndexPath *indexPath = [tableView indexPathForCell:cell];
            NSIndexPath *tempIndexPath = [NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section + 1];
            [tableView reloadRowsAtIndexPaths:@[tempIndexPath] withRowAnimation:UITableViewRowAnimationNone];
        };
        
         __weak typeof(self) weak_self = self;
        textCell.deleteEvent = ^(UITableViewCell <GDEditTextTypeCellProtocol> *cell, GDEditBaseViewModel *deleteModel) {
            [weak_self.pageModel removeOption:item];
            [tableView reloadData];
        };
    }

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    GDEditBaseViewModel *item = [self.pageModel itemAtIndex:indexPath.section];
    if ([item isKindOfClass:[GDEditToolViewModel class]]) {
        if (item.type == GDSurveyTypeChooseOne
            || item.type == GDSurveyTypeChooseMultiple) {
            [self.pageModel addOption];
            [self.tableView reloadData];
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
     GDEditBaseViewModel *item = [self.pageModel itemAtIndex:indexPath.section];
    return [item cellHeight];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    GDEditBaseViewModel *item = [self.pageModel itemAtIndex:section];
    return item.sectionFooterHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01;
}


#pragma mark -
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    UIImage *orientationImage = [info valueForKey:UIImagePickerControllerOriginalImage];
    LZImageCropping *cropping = [LZImageCropping surveyQuestionImageCropImage:orientationImage delegate:self];
    [picker dismissViewControllerAnimated:NO completion:nil];
    [self presentViewController:cropping animated:NO completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    
}

#pragma mark -
-(void)lzImageCropping:(LZImageCropping *)cropping didCropImage:(UIImage *)image
{
    self.header.image = image;
    [self.pageModel updateIncludeImage:image];
}

-(void)lzImageCroppingDidCancle:(LZImageCropping *)cropping
{
    
}


#pragma mark - Private
- (void)setupViews
{
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    if (self.pageModel.imageModel) {
        
        __weak typeof(self) weak_self = self;
        self.header = [GDEditImageHeaderView editImageHeaderViewWithImage:nil clickEvent:^{
            NSLog(@"添加图片");
            
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"选择你的调查问卷背景图片" preferredStyle:UIAlertControllerStyleActionSheet];
            
            UIAlertAction *cameraAction = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                UIImagePickerController *picker = [[UIImagePickerController alloc] init];
                picker.delegate = weak_self;
                picker.sourceType = UIImagePickerControllerSourceTypeCamera;
                [weak_self presentViewController:picker animated:YES completion:^{ }];
            }];
            
            UIAlertAction *photoAction = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                UIImagePickerController *picker = [[UIImagePickerController alloc] init];
                picker.delegate = weak_self;
                picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                [weak_self presentViewController:picker animated:YES completion:^{ }];
                
            }];
            
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) { }];
            
            [alert addAction:cameraAction];
            [alert addAction:photoAction];
            [alert addAction:cancelAction];
            [weak_self presentViewController:alert animated:YES completion:nil];
            
        }];
        self.header.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH * 703.f / 750.f);
        self.tableView.tableHeaderView = self.header;
    }
    
    UIView *footerContainer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 90)];
    self.tableView.tableFooterView = footerContainer;
    GDEditBottomSettingView *footer = [GDEditBottomSettingView editBottomSettingViewWithClickEvent:^{
        
    }];
    [footerContainer addSubview:footer];
    [footer mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(footerContainer);
    }];
    
    [self.tableView reloadData];
}

- (void)setupTableViews
{
    self.tableView.backgroundColor = [UIColor whiteColor];
    
    // Question
    UINib *questionCellNib = [UINib nibWithNibName:@"GDEditQuestionTableViewCell" bundle:nil];
    [self.tableView registerNib:questionCellNib forCellReuseIdentifier:kCommonQuestionCell];

    // ChooseOne
    [self.tableView registerClass:[GDChooseOneAnswerTableViewCell class] forCellReuseIdentifier:kChooseOneAnswerCell];
    UINib *chooseOneAddOptionCellNib = [UINib nibWithNibName:@"GDChooseOneAddOptionTableViewCell" bundle:nil];
    [self.tableView registerNib:chooseOneAddOptionCellNib forCellReuseIdentifier:kChooseOneAddOptionCell];
    
    // ChooseMutilpe
    [self.tableView registerClass:[GDChooseMultipleAnswerTableViewCell class] forCellReuseIdentifier:kChooseMultipleAnswerCell];
    UINib *chooseMultipAddOptionCellNib = [UINib nibWithNibName:@"GDChooseMultipleAddOptionTableViewCell" bundle:nil];
    [self.tableView registerNib:chooseMultipAddOptionCellNib forCellReuseIdentifier:kChooseMultipleAddOptionCell];
    
    // StackRank
    
    UINib *rankIndexCellNib = [UINib nibWithNibName:@"GDStackRankIndexTableViewCell" bundle:nil];
    [self.tableView registerNib:rankIndexCellNib forCellReuseIdentifier:kStackRankIndexCell];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kStackRankEmptyCell];
    UINib *rankEditCellNib = [UINib nibWithNibName:@"GDStackRankEditTableViewCell" bundle:nil];
    [self.tableView registerNib:rankEditCellNib forCellReuseIdentifier:kStackRankAnswerCell];
    UINib *rankAddCellNib = [UINib nibWithNibName:@"GDStackRankAddOptionTableViewCell" bundle:nil];
    [self.tableView registerNib:rankAddCellNib forCellReuseIdentifier:kStackRankAddOptionCell];


    // SlidingScale
    [self.tableView registerClass:[GDSlidingScaleTableViewCell class] forCellReuseIdentifier:kSlidingScaleAnswerCell];
    
    // BoundRange
    [self.tableView registerClass:[GDBoundRangeAnswerTableViewCell class] forCellReuseIdentifier:kBoundedRangeAnswerCell];
    
    
    // Text
    UINib *textCellNib = [UINib nibWithNibName:@"GDTextAnswerTableViewCell" bundle:nil];
    [self.tableView registerNib:textCellNib forCellReuseIdentifier:kTextAnswerCell];

}

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.sectionHeaderHeight = 0.01;
        _tableView.sectionFooterHeight = 0.01;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.tableView resignFirstResponder];
}

@end