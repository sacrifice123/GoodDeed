//
//  GDPGChooseView.m
//  GoodDeed
//
//  Created by xiaozhan on 2018/6/26.
//  Copyright © 2018年 GoodDeed. All rights reserved.
//

#import "GDPGChooseView.h"
#import "GDPGChooseCell.h"
#import "GDPGHeaderView.h"
#import "GDPGSearchViewController.h"
#import "GDLunchManager.h"
#import "UIView+LXShadowPath.h"

@interface GDPGChooseView()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *datas;
@property (nonatomic, strong) UIView *selectView;

@end
@implementation GDPGChooseView

static NSString * const reuseIdentifier = @"GDPGChooseCell";
static NSString * const headerReuseIdentifier = @"GDPGHeaderView";

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        [GDLunchManager sharedManager].selectOrganModel = nil;
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.collectionView];
        [self addSubview:self.selectView];
    }
    
    return self;
}

- (void)reloadWithDatas:(NSArray *)datas{
    if (datas&&[datas isKindOfClass:[NSArray class]]) {
        [self.datas addObjectsFromArray:datas];
        [self.collectionView reloadData];
    }
    
}

- (UIView *)selectView{
    if (_selectView == nil) {
        _selectView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, 124)];
        [_selectView LX_SetShadowPathWith:[UIColor colorWithHexString:@"#777777"] shadowOpacity:0.5 shadowRadius:1.5 shadowSide:LXShadowPathTop shadowPathWidth:1.5];
        _selectView.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.8];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:@"选择后继续" forState:0];
        [button setImage:[UIImage imageNamed:@"choose_arrow"] forState:0];
        [button setImage:[UIImage imageNamed:@"choose_arrow"] forState:UIControlStateHighlighted];
        [button setImageEdgeInsets:UIEdgeInsetsMake(0, 200, 0, 0)];
        [button setTitleEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 0)];
        button.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Light" size:20];
        button.backgroundColor = [UIColor colorWithRed:0.06 green:0.45 blue:0.69 alpha:1];
        [button addTarget:self action:@selector(chooseButtonClicked) forControlEvents:UIControlEventTouchUpInside];
        [_selectView addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self->_selectView).offset(40);
            make.right.equalTo(self->_selectView).offset(-40);
            make.top.equalTo(self->_selectView).offset(27);
            make.bottom.equalTo(self->_selectView).offset(-27);
        }];
    }
    
    return _selectView;
}

- (NSMutableArray *)datas{
    
    if (_datas == nil) {
        _datas = [[NSMutableArray alloc] init];
    }
    
    return _datas;
}

- (UICollectionView *)collectionView{
    if (_collectionView == nil) {
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake((SCREEN_WIDTH-65)*0.5, (SCREEN_WIDTH-65)*0.5);
        layout.minimumInteritemSpacing = 15;
        layout.minimumLineSpacing = 20;
        layout.sectionInset = UIEdgeInsetsMake(0, 25, 20, 25);
        _collectionView = [[UICollectionView alloc] initWithFrame:self.frame collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerNib:[UINib nibWithNibName:@"GDPGChooseCell" bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];
        if (!self.isSearch) {
            [_collectionView registerNib:[UINib nibWithNibName:@"GDPGHeaderView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerReuseIdentifier];

        }

    }
    
    return _collectionView;
}

#pragma mark <UICollectionViewDataSource>
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.datas.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    GDPGChooseCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.model = self.datas[indexPath.row];
    return cell;
}

#pragma mark <UICollectionViewDelegate>
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    //UIViewController *vc = [GDHomeManager getSuperVc:self];
    //[vc dismissViewControllerAnimated:YES completion:nil];
//     [GDLunchManager sharedManager].selectOrganModel = self.datas[indexPath.row];
    GDOrganModel *model = self.datas[indexPath.row];
    if ([GDLunchManager sharedManager].selectOrganModel) {
        if (model != [GDLunchManager sharedManager].selectOrganModel) {
            [GDLunchManager sharedManager].selectOrganModel.isSelected = NO;
        }
        model.isSelected = !model.isSelected;
    }else{
        model.isSelected = YES;
    }
   
    [GDLunchManager sharedManager].selectOrganModel = model;
    [self.collectionView reloadData];
    
    [UIView animateWithDuration:0.5 animations:^{
        self.selectView.frame = CGRectMake(0, SCREEN_HEIGHT-(model.isSelected?124:0), SCREEN_WIDTH, 124);
    }];
    

}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if ([kind isEqualToString: UICollectionElementKindSectionHeader]&&!self.isSearch) {
        GDPGHeaderView *view = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerReuseIdentifier forIndexPath:indexPath];
        view.block = ^{//点击搜索
            [GDHomeManager presentToTargetControllerWith:self targetVc:[GDPGSearchViewController new]];
        };
        return view;
    }
    return nil;
}

- (CGSize)collectionView: (UICollectionView *)collectionView
                  layout: (UICollectionViewLayout*)collectionViewLayout
referenceSizeForHeaderInSection: (NSInteger)section{
    
    return CGSizeMake(SCREEN_WIDTH, self.isSearch?0:125);
}

//选择后继续
- (void)chooseButtonClicked{
    UIViewController *superVc = [GDHelper getSuperVc:self];
    [superVc dismissViewControllerAnimated:YES completion:nil];

}


@end
