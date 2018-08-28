//
//  GDQuestionView.m
//  GoodDeed
//
//  Created by xiaozhan on 2018/8/28.
//  Copyright © 2018年 GoodDeed. All rights reserved.
//

#import "GDQuestionView.h"
#import "GDFirstQuestionListModel.h"

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

- (instancetype)init{
    
    if (self = [super init]) {
        
        [self.collectionView registerNib:[UINib nibWithNibName:@"" bundle:nil] forCellWithReuseIdentifier:@""];
    }
    
    return self;
}

- (UICollectionView *)collectionView{
    
    if (_collectionView == nil) {
        _collectionView = [[UICollectionView alloc] initWithFrame:self.frame];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
    }
    return _collectionView;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

//设置每个分区的item个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 5;
}

//设置返回每个item的属性必须实现）
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //UICollectionViewCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    return nil;
}

//对头视图或者尾视图进行设置
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    NSString *identifier;
    
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        identifier = @"headerView";
    } else {
        identifier = @"footerView";
    }
    UICollectionReusableView *view = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:identifier forIndexPath:indexPath];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, 120, 30)];
    [view addSubview:label];
    
    if (indexPath.section == 0) {
        label.text = @"section1";
    }else {
        label.text = @"section2";
    }
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        view.backgroundColor = [UIColor redColor];
    } else {
        view.backgroundColor = [UIColor purpleColor];
        
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
    
    return CGSizeZero;
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
    
    return CGSizeZero;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    
    return CGSizeZero;
}


@end
