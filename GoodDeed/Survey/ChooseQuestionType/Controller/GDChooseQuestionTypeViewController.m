//
//  GDChooseQuestionTypeViewController.m
//  GoodDeed
//
//  Created by HK on 2018/8/9.
//  Copyright © 2018 GoodDeed. All rights reserved.
//

#import "GDChooseQuestionTypeViewController.h"
#import "GDSurveyTypeModel.h"

#import "GDSurveyTypeCollectionViewCell.h"
#import "GDSurveyTitleCollectionReusableView.h"
#import "GDSurveyTypePopView+Selected.h"

#import <Masonry.h>



static NSString * const kCellReuseIdentifier = @"kCellReuseIdentifier";
static NSString * const kHeaderReuseIdentifier = @"kHeaderReuseIdentifier";



@interface GDChooseQuestionTypeViewController () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (strong, nonatomic) UICollectionView *collectionView;

@property (strong, nonatomic) NSArray *dataSource;


@end

@implementation GDChooseQuestionTypeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor yellowColor];
    [self setupViews];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - <GDSurveyPageProtocol>
// 问卷类型
- (GDSurveyEditType)surveyType
{
    return GDSurveyTypeChooseType;
}

// 下一步
- (void)nextStep:(GDSurveyNextStepEvent)nextStep
{
    if (nextStep) {
        nextStep(self);
    }
}

// 问卷内容
- (id)surveyContent
{
    return nil;
}


#pragma mark - <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    GDSurveyTypeModel *item = self.dataSource[indexPath.row];
    GDSurveyTypeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCellReuseIdentifier forIndexPath:indexPath];
    cell.imageView.image = item.image;
    cell.nameLabel.text = item.name;
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if (kind == UICollectionElementKindSectionHeader) {
        return [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kHeaderReuseIdentifier forIndexPath:indexPath];
    }
    return nil;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    GDSurveyTypeModel *item = self.dataSource[indexPath.row];
    switch (item.type) {
        case GDSurveyTypeChooseOne: {       // 单选
            
            [GDSurveyTypePopView showChooseOnePopViewWithSelected:^(NSInteger index) {
                if (self.chooseQuestion) {
                    self.chooseQuestion(item.type, index);
                }
            } dismiss:^{ }];
        } break;
        case GDSurveyTypeChooseMultiple: {  // 多选
            [GDSurveyTypePopView showChooseMultiplePopViewWithSelected:^(NSInteger index) {
                if (self.chooseQuestion) {
                    self.chooseQuestion(item.type, index);
                }
            } dismiss:^{ }];
        } break;
        case GDSurveyTypeSlidingScale: {    // 滑动
            [GDSurveyTypePopView showSlidingScalePopViewWithSelected:^(NSInteger index) {
                if (self.chooseQuestion) {
                    self.chooseQuestion(item.type, index);
                }
            } dismiss:^{ }];
        } break;
        case GDSurveyTypeBoundedRange: {    // 定量
            [GDSurveyTypePopView showBoundedRangePopViewWithSelected:^(NSInteger index) {
                if (self.chooseQuestion) {
                    self.chooseQuestion(item.type, index);
                }
            } dismiss:^{ }];
        } break;
        case GDSurveyTypeStackRank: {       // 排序
            [GDSurveyTypePopView showStackRankPopViewWithSelected:^(NSInteger index) {
                if (self.chooseQuestion) {
                    self.chooseQuestion(item.type, index);
                }
            } dismiss:^{ }];
        } break;
        case GDSurveyTypeImageVote: {       // 勾选图片
            if (self.chooseQuestion) {
                self.chooseQuestion(item.type, index);
            }
        } break;
        case GDSurveyTypeText: {            //  填写
            [GDSurveyTypePopView showTextPopViewWithSelected:^(NSInteger index) {
                if (self.chooseQuestion) {
                    self.chooseQuestion(item.type, index);
                }
            } dismiss:^{ }];
        } break;
        default:
            break;
    }
}


#pragma mark - Private

- (void)setupViews
{
    [self.view addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    
}

#pragma mark - Setter, Getter

- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        CGFloat width = GDScaleValue(140.f);
        CGFloat height = width + 7.5 + 22.5;
        layout.itemSize = CGSizeMake(width, height);
        layout.sectionInset = UIEdgeInsetsMake(0, GDScaleValue(40.f), 0, GDScaleValue(40.f));
        layout.minimumInteritemSpacing =GDScaleValue(15.f);
        layout.minimumLineSpacing =GDScaleValue(18.5);
        layout.headerReferenceSize = CGSizeMake(SCREEN_WIDTH, 134.5);
        _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor clearColor];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.showsVerticalScrollIndicator = NO;
        UINib *cellNib = [UINib nibWithNibName:@"GDSurveyTypeCollectionViewCell" bundle:nil];
        [_collectionView registerNib:cellNib forCellWithReuseIdentifier:kCellReuseIdentifier];
        
        UINib *headerNib = [UINib nibWithNibName:@"GDSurveyTitleCollectionReusableView" bundle:nil];
        [_collectionView registerNib:headerNib forSupplementaryViewOfKind:UICollectionElementKindSectionHeader  withReuseIdentifier:kHeaderReuseIdentifier];
    }
    
    return _collectionView;
}


- (NSArray *)dataSource
{
    if (!_dataSource) {
        GDSurveyTypeModel *chooseOne = [[GDSurveyTypeModel alloc] initWithType:GDSurveyTypeChooseOne];
        GDSurveyTypeModel *chooseMultiple = [[GDSurveyTypeModel alloc] initWithType:GDSurveyTypeChooseMultiple];
        GDSurveyTypeModel *slidingScale = [[GDSurveyTypeModel alloc] initWithType:GDSurveyTypeSlidingScale];
        GDSurveyTypeModel *boundedRange = [[GDSurveyTypeModel alloc] initWithType:GDSurveyTypeBoundedRange];
        GDSurveyTypeModel *stackRank = [[GDSurveyTypeModel alloc] initWithType:GDSurveyTypeStackRank];
        GDSurveyTypeModel *imageVote = [[GDSurveyTypeModel alloc] initWithType:GDSurveyTypeImageVote];
        GDSurveyTypeModel *text = [[GDSurveyTypeModel alloc] initWithType:GDSurveyTypeText];
        _dataSource = @[chooseOne, chooseMultiple, slidingScale, boundedRange, stackRank, imageVote, text ];
    }
    return _dataSource;
}

@end
