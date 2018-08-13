//
//  GDLeftViewController.m
//  GoodDeed
//
//  Created by xiaozhan on 2018/6/7.
//  Copyright © 2018年 GoodDeed. All rights reserved.
//

#import "GDLeftViewController.h"
#import "GDLeftCell.h"
#import "GDLeftHeaderView.h"
#import "GDLeftModel.h"

@interface GDLeftViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *datas;
@property (nonatomic, strong) GDLeftHeaderView *headerView;

@end

@implementation GDLeftViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"GDLeftCell" bundle:nil] forCellReuseIdentifier:@"GDLeftCell"];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}


- (UITableView *)tableView {
    
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStyleGrouped];
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.bounces = NO;
        _tableView.scrollEnabled = NO;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableHeaderView = self.headerView;
        _tableView.backgroundColor = [UIColor colorWithHexString:@"#535353"];
    }
    return _tableView;
}

- (GDLeftHeaderView *)headerView{
    
    if (_headerView == nil) {
        _headerView = [[NSBundle mainBundle] loadNibNamed:@"GDLeftHeaderView" owner:self options:nil].lastObject;
        _headerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 130);
    }
    return _headerView;
}

- (NSMutableArray *)datas{
    
    if (_datas == nil) {
        _datas = [[NSMutableArray alloc] init];
        NSArray *titles = @[@"首页",@"我的事业",@"我的团队",@"我的调查",@"反馈与帮助",@"退出"];
        for (int i=0; i<titles.count; i++) {
            GDLeftModel *model = [[GDLeftModel alloc] init];
            model.title = titles[i];
            [_datas addObject:model];
        }
    }
    return _datas;
}

#pragma mark - UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.datas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    GDLeftCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GDLeftCell" forIndexPath:indexPath];
    cell.model = self.datas[indexPath.row];
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 75;
}

//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//
//    return self.headerView;
//}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 130;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
   // [GDHomeManager closeDrawerWithFull];
    [GDHomeManager closeDrawer];
    switch (indexPath.row) {
        case 0:{//首页
        }
            break;
        case 1:{//我的事业
        }
            
            break;
        case 2:{//我的团队
        }
            
            break;
        case 3:{//我的团队
        }
            
            break;
        case 4:{//我的调查
        }
            
            break;
        case 5:{//反馈与帮助
            
        }
            break;
        case 6:{//退出
            
        }
            break;

        default:
            break;
    }
    
}


@end
