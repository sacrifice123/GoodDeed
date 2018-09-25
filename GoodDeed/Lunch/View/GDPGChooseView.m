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
#import "UIView+LXShadowPath.h"
#import "GDOrgAnimationView.h"

@interface GDPGChooseView()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *datas;
@property (nonatomic, strong) UIView *selectView;
@property (nonatomic, strong) GDOrganModel *selectOrganModel;

@end
@implementation GDPGChooseView

static NSString * const reuseIdentifier = @"GDPGChooseCell";
static NSString * const headerReuseIdentifier = @"GDPGHeaderView";

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
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

- (GDOrganModel *)selectOrganModel{
    
    if (_selectOrganModel == nil) {
        _selectOrganModel = [[GDOrganModel alloc] init];
    }
    return _selectOrganModel;
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
    
    GDOrganModel *model = self.datas[indexPath.row];
    if (self.selectOrganModel) {
        if (model != self.selectOrganModel) {
            self.selectOrganModel.isSelected = NO;
        }
        model.isSelected = !model.isSelected;
    }else{
        model.isSelected = YES;
    }
   
    self.selectOrganModel = model;
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
//    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
//    [dic setObject:self.selectOrganModel.organId forKey:@"organId"];
//    [dic setObject:self.selectOrganModel.name forKey:@"name"];
//    [dic setObject:self.selectOrganModel.imgUrl  forKey:@"imgUrl"];
//    [[NSUserDefaults standardUserDefaults] setObject:dic forKey:organModelCache];
    GDUserModel *model = [[GDUserModel alloc] init];
    model.organId = self.selectOrganModel.organId;
    model.name = self.selectOrganModel.name;
    model.imgUrl = self.selectOrganModel.imgUrl;
    model.uid = GDOrgaUid;//自定义uid为主件
    [[GDDataBaseManager sharedManager] insert:model];
    [[NSUserDefaults standardUserDefaults] setObject:@1 forKey:GDAnimationStatus];
    [superVc dismissViewControllerAnimated:YES completion:^{
        
    }];

}


@end
