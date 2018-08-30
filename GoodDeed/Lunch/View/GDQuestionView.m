//
//  GDQuestionView.m
//  GoodDeed
//
//  Created by xiaozhan on 2018/8/28.
//  Copyright © 2018年 GoodDeed. All rights reserved.
//

#import "GDQuestionView.h"
#import "GDLunchManager.h"
#import "GDQuestionDescCell.h"
//七个问题cell
#import "GDSingleSelCell.h"
#import "GDMoreSelCell.h"
#import "GDSlideCell.h"
#import "GDSortCell.h"
#import "GDQuantifyCell.h"
#import "GDImageSelCell.h"
#import "GDWriteCell.h"

@interface GDQuestionView()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation GDQuestionView

- (instancetype)initWithFrame:(CGRect)frame listModel:(GDFirstQuestionListModel *)model{
    
    if (self = [super initWithFrame:frame]) {
        
        self.model = model;
        [self addSubview:self.collectionView];
        [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(30);
            make.left.right.bottom.equalTo(self);
        }];
        [self.collectionView registerNib:[UINib nibWithNibName:@"GDQuestionDescCell" bundle:nil] forCellWithReuseIdentifier:@"GDQuestionDescCell"];
        [self.collectionView registerNib:[UINib nibWithNibName:@"GDSingleSelCell" bundle:nil] forCellWithReuseIdentifier:@"GDSingleSelCell"];
        [self.collectionView registerNib:[UINib nibWithNibName:@"GDMoreSelCell" bundle:nil] forCellWithReuseIdentifier:@"GDMoreSelCell"];
        [self.collectionView registerNib:[UINib nibWithNibName:@"GDImageSelCell" bundle:nil] forCellWithReuseIdentifier:@"GDImageSelCell"];
        [self.collectionView registerNib:[UINib nibWithNibName:@"GDWriteCell" bundle:nil] forCellWithReuseIdentifier:@"GDWriteCell"];
        [self.collectionView registerClass:[GDQuantifyCell class] forCellWithReuseIdentifier:@"GDQuantifyCell"];
        [self.collectionView registerClass:[GDSortCell class] forCellWithReuseIdentifier:@"GDSortCell"];
        [self.collectionView registerClass:[GDSlideCell class] forCellWithReuseIdentifier:@"GDSlideCell"];
        [self.collectionView registerClass:[GDQuestionBaseCell class] forCellWithReuseIdentifier:@"GDQuestionBaseCell"];

        [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headerView"];
        [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footerView"];


    }
    
    return self;
}

- (UICollectionView *)collectionView{
    
    if (_collectionView == nil) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        //layout.estimatedItemSize = CGSizeMake(SCREEN_WIDTH, 80);
        _collectionView = [[UICollectionView alloc] initWithFrame:self.frame collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
    }
    return _collectionView;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 2;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return (section==0)?1:self.model.firstOptionList.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    GDQuestionBaseCell *cell = [GDLunchManager getQuestionReuseCellWith:self.model.type collectionView:collectionView indexPath:indexPath];
    self.model.index = indexPath.row;
    cell.model = self.model;
    return cell;
}

//对头视图或者尾视图进行设置
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
   
    UICollectionReusableView *view = nil;
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        view = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"headerView" forIndexPath:indexPath];
        [view.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        UIImageView *imgView = [[UIImageView alloc] init];
        [imgView gd_setImageWithUrlStr:self.model.imgUrl];
        [view addSubview:imgView];
        [imgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(view);
        }];
    }else{
        view = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"footerView" forIndexPath:indexPath];

    }
    return view;
}

////是否允许移动Item
//- (BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(9_0){
//    return YES;
//}
//
////移动Item时触发的方法
//- (void)collectionView:(UICollectionView *)collectionView moveItemAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath*)destinationIndexPath NS_AVAILABLE_IOS(9_0); {
//
//}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{

    return CGSizeMake(SCREEN_WIDTH, 80);
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsZero;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
    
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    
    return 0;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    CGSize size = CGSizeZero;
    if (self.model.imgUrl&&[self.model.imgUrl isKindOfClass:[NSString class]]&&self.model.imgUrl.length>0) {
        size = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT*0.52);
    }
    return size;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    
    return CGSizeZero;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        return;
    }

}


@end
