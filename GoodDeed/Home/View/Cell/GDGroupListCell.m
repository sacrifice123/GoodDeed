//
//  GDGroupListCell.m
//  GoodDeed
//
//  Created by xiaozhan on 2018/9/20.
//  Copyright © 2018年 GoodDeed. All rights reserved.
//

#import "GDGroupListCell.h"
#import "GDGroupListItemCell.h"

@interface GDGroupListCell()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UILabel *groupTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalMoneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalMoneySubLabel;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) NSMutableArray *dataArray;
@property (weak, nonatomic) IBOutlet UIView *inviteView;

@end
@implementation GDGroupListCell

- (void)awakeFromNib {
    [super awakeFromNib];

    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    [self.collectionView registerNib:[UINib nibWithNibName:@"GDGroupListItemCell" bundle:nil] forCellWithReuseIdentifier:@"GDGroupListItemCell"];
}


- (NSMutableArray *)dataArray{
    
    if (_dataArray==nil) {
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}

- (IBAction)invite:(id)sender {
    
    
}



- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 4;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    GDGroupListItemCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"GDGroupListItemCell" forIndexPath:indexPath];
    GDGroupListModel *model = self.dataArray[indexPath.row];
    model.index = indexPath;
    cell.model = model;
    return cell;
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake((SCREEN_WIDTH-65)*0.5, (SCREEN_WIDTH-65)*0.5+30);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 20, 0, 20);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
    
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    
    return 25;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 3) {
        self.inviteView.hidden = NO;
    }
}
//完成
- (IBAction)finish:(id)sender {
    
    self.inviteView.hidden = YES;
}


@end
