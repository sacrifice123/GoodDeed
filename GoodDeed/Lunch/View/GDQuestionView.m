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
            make.top.equalTo(self);
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
        _collectionView.showsVerticalScrollIndicator = NO;
    }
    return _collectionView;
}

#pragma mark UICollectionViewDelegate,UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 2;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return (section==0||
            self.model.type==GDSlideType||
            self.model.type==GDQuantitativeType||
            self.model.type==GDSortType||
            self.model.type==GDWriteType)?1:self.model.firstOptionList.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    GDQuestionBaseCell *cell = [GDLunchManager collectionView:collectionView surveyType:self.model.type cellForItemAtIndexPath:indexPath];
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
        [view.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        UIButton *button = [[UIButton alloc] init];
        button.backgroundColor = [UIColor colorWithHexString:@"#EFEFEF"];
        [button setTitle:@"提交" forState:0];
        [button addTarget:self action:@selector(multipleOptionSubmitButtonClicked) forControlEvents:UIControlEventTouchUpInside];
        button.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Light" size:20];
        [button setTitleColor:[UIColor colorWithHexString:@"##666666"] forState:0];
        [view addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(view).offset(10);
            make.height.equalTo(@69);
            make.width.equalTo(@132);
            make.centerX.equalTo(view);
        }];

    }
    return view;
}

//////是否允许移动Item
//- (BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath {
//
//    return YES;
//}
//
////移动Item时触发的方法
//- (void)collectionView:(UICollectionView *)collectionView moveItemAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath*)destinationIndexPath {
//
//}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{

    return [GDLunchManager collectionView:collectionView surveyModel:self.model sizeForItemAtIndexPath:indexPath];
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
    
    CGSize size = CGSizeZero;
    if (self.model.type == GDMultipleType&&section == 1) {
        size = CGSizeMake(SCREEN_WIDTH, 100);
    }

    return size;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        return;
    }else{
        
        if (self.model.type == GDMultipleType) {//多选题选项判断
            
            NSMutableArray *selectedArray = self.model.writeModel.selectedArray;
            if (selectedArray.count>indexPath.row) {

                BOOL status = [[selectedArray objectAtIndex:indexPath.row] boolValue];
                [selectedArray replaceObjectAtIndex:indexPath.row withObject:@(!status)];
                [collectionView reloadData];

            }
            
        }
   
    }

}

//多选选项提交
- (void)multipleOptionSubmitButtonClicked{
    
  //todo
}
@end
