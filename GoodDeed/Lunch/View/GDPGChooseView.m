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

@interface GDPGChooseView()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *datas;

@end
@implementation GDPGChooseView

static NSString * const reuseIdentifier = @"GDPGChooseCell";
static NSString * const headerReuseIdentifier = @"GDPGHeaderView";

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.collectionView];
    }
    
    return self;
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
        [_collectionView registerNib:[UINib nibWithNibName:@"GDPGHeaderView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerReuseIdentifier];

    }
    
    return _collectionView;
}

#pragma mark <UICollectionViewDataSource>
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    GDPGChooseCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UIViewController *vc = [GDHomeManager getSuperVc:self];
    //[vc dismissViewControllerAnimated:YES completion:nil];
    
    [UIApplication sharedApplication].keyWindow.rootViewController = [GDHomeManager getRootController:YES];

}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if ([kind isEqualToString: UICollectionElementKindSectionHeader]) {
        GDPGHeaderView *view = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerReuseIdentifier forIndexPath:indexPath];
        view.block = ^{
            [GDHomeManager presentToTargetControllerWith:self targetVc:[GDPGSearchViewController new]];
        };
        return view;
    }
    return nil;
}

- (CGSize)collectionView: (UICollectionView *)collectionView
                  layout: (UICollectionViewLayout*)collectionViewLayout
referenceSizeForHeaderInSection: (NSInteger)section{
    
    return CGSizeMake(SCREEN_WIDTH, 125);
}


@end
