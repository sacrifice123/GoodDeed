//
//  GDBoundRangeAnswerTableViewCell.m
//  GoodDeed
//
//  Created by HK on 2018/9/5.
//  Copyright © 2018 GoodDeed. All rights reserved.
//

#import "GDBoundRangeAnswerTableViewCell.h"
#import "GDBoundRangeCollectionViewCell.h"
#import "GDEditBoundRangeViewModel.h"

static NSString *const kCellReuseId = @"kCellReuseId";

@interface GDBoundRangeAnswerTableViewCell () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (strong, readonly) GDEditBoundRangeViewModel *boundRangeViewModel;
@property (strong, nonatomic) UIView *sliderView;
@property (strong, nonatomic) UIImageView *indicatorImageView;
@property (strong, nonatomic) UICollectionView *collectionView;
@property (strong, nonatomic) UIButton *addOptionButton;

@end

@implementation GDBoundRangeAnswerTableViewCell
@synthesize viewModel = _viewModel;
@synthesize updateHeight = _updateHeight;
@synthesize deleteEvent = _deleteEvent;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupViews];
    }
    return self;
}


#pragma mark - <GDEditTextTypeCellProtocol>
- (void)setViewModel:(GDEditBaseViewModel *)viewModel
{
    if ([viewModel isKindOfClass:[GDEditBoundRangeViewModel class]]) {
        _viewModel = viewModel;

//        GDEditBoundRangeViewModel *answer = (GDEditBoundRangeViewModel *)viewModel;
//        if (self.updateHeight) self.updateHeight(self);
//        __weak typeof(answer) weak_answer = answer;
//        self.textView.didChanged = ^(NSString *text) {
//            weak_answer.text = text;
//        };
//
//        self.deleteButton.hidden = !answer.deleteEnabel;
    }
}


- (GDEditBoundRangeViewModel *)boundRangeViewModel
{
    return (GDEditBoundRangeViewModel *)self.viewModel;
}


#pragma mark - <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.boundRangeViewModel numberOfItems];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    GDBoundRangeItem *item  = [self.boundRangeViewModel itemAtIndex:indexPath.row];
    GDBoundRangeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCellReuseId forIndexPath:indexPath];
    cell.viewModel = item;
    __weak typeof(self) weak_self = self;
    cell.deleteEvent = ^(GDBoundRangeCollectionViewCell *cell, GDBoundRangeItem *viewModel) {
        [weak_self.boundRangeViewModel removeOption:viewModel];
        [weak_self.collectionView reloadData];
    };
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.boundRangeViewModel cellSizeBySize:collectionView.bounds.size];
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return [self.boundRangeViewModel cellSpaceBySize:collectionView.bounds.size];
}

//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
//{
//}

#pragma mark - Private

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    CAShapeLayer *border = [CAShapeLayer layer];
    //虚线的颜色
    border.strokeColor = [UIColor colorWithHex:0xCCCCCC].CGColor;
    //填充的颜色
    border.fillColor = [UIColor clearColor].CGColor;
    
    //设置路径
    border.path = [UIBezierPath bezierPathWithRect:self.addOptionButton.bounds].CGPath;
    
    border.frame = self.addOptionButton.bounds;
    //虚线的宽度
    border.lineWidth = 1.f;
    
    //设置线条的样式
    //    border.lineCap = @"square";
    //虚线的间隔
    border.lineDashPattern = @[@7, @5];
    [self.addOptionButton.layer addSublayer:border];
}

- (void)setupViews
{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    [self.contentView addSubview:self.sliderView];
    [self.contentView addSubview:self.indicatorImageView];
    [self.contentView addSubview:self.collectionView];
    [self.contentView addSubview:self.addOptionButton];
    
    [self.sliderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.indicatorImageView);
        make.left.equalTo(self.contentView).with.offset(42.5);
        make.right.equalTo(self.contentView).with.offset(-42.5);
        make.height.equalTo(@11);
    }];
    self.sliderView.layer.cornerRadius = 11 / 2.f;
    
    [self.indicatorImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView);
        make.top.equalTo(self.contentView);
        make.height.equalTo(@78);
        make.width.equalTo(@62);
    }];
    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).with.offset(15.f);
        make.right.equalTo(self.contentView).with.offset(-15.f);
        make.top.equalTo(self.indicatorImageView.mas_bottom).with.offset(5);
    }];
    
    [self.addOptionButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.collectionView.mas_bottom).with.offset(5);
        make.width.equalTo(@180);
        make.height.equalTo(@70);
        make.centerX.equalTo(self.contentView);
        make.bottom.equalTo(self.contentView);
    }];
    
}

- (void)deleteAction
{
    if (self.deleteEvent) self.deleteEvent(self, self.viewModel);
}

- (void)addOption
{
    [self.boundRangeViewModel addOption];
    [self.collectionView reloadData];
}

#pragma mark - Setter, Getter
- (UIView *)sliderView
{
    if (!_sliderView) {
        _sliderView = [[UIView alloc] init];
        _sliderView.backgroundColor = [UIColor colorWithHex:0xDDDDDD];
    }
    
    return _sliderView;
}

- (UIImageView *)indicatorImageView
{
    if (!_indicatorImageView) {
        _indicatorImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"survey_arrow_indicator"]];
    }
    
    return _indicatorImageView;
}

- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:flowLayout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        [_collectionView registerClass:[GDBoundRangeCollectionViewCell class] forCellWithReuseIdentifier:kCellReuseId];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
    }
    
    return _collectionView;
}

- (UIButton *)addOptionButton
{
    if (!_addOptionButton) {
        _addOptionButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_addOptionButton setTitle:@"添加新选项" forState:UIControlStateNormal];
        [_addOptionButton addTarget:self action:@selector(addOption) forControlEvents:UIControlEventTouchUpInside];
        [_addOptionButton setTitleColor:[UIColor colorWithHex:0x999999] forState:UIControlStateNormal];
        _addOptionButton.titleLabel.font = [UIFont systemFontOfSize:20.f];
    }
    
    return _addOptionButton;
}


@end
