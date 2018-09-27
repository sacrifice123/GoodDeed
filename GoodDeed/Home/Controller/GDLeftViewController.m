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
#import "GDPGChooseViewController.h"
#import "GDHomeViewController.h"
#import <MediaPlayer/MediaPlayer.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import <AVFoundation/AVFoundation.h>


@interface GDLeftViewController ()<UITableViewDelegate, UITableViewDataSource,UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *datas;
@property (nonatomic, strong) GDLeftHeaderView *headerView;
@property (nonatomic, strong) UIImagePickerController *imagePickerController;

@end

@implementation GDLeftViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];

    __weak typeof(self) weakSelf = self;
    self.headerView.chooseBlock = ^{
        [weakSelf chooseHeadImage];
    };
    [self.tableView registerNib:[UINib nibWithNibName:@"GDLeftCell" bundle:nil] forCellReuseIdentifier:@"GDLeftCell"];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadTableView) name:GDReloadHome object:nil];
}

- (UIImagePickerController *)imagePickerController{
    
    if (_imagePickerController == nil) {
        _imagePickerController = [[UIImagePickerController alloc] init];
        // 设置代理
        _imagePickerController.delegate = self;
        // 是否显示裁剪框编辑（默认为NO），等于YES的时候，照片拍摄完成可以进行裁剪
        _imagePickerController.allowsEditing = YES;

    }
    
    return _imagePickerController;
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
    GDLeftModel *model = self.datas[indexPath.row];
    model.index = indexPath;
    cell.model = model;
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
    [self showHomeView:NO];
    switch (indexPath.row) {
        case 0:{//首页
            [GDHomeManager closeDrawer];
        }
            break;
        case 1:{//我的事业
            GDPGChooseViewController *chooseVc = [GDPGChooseViewController new];
            chooseVc.isClose = NO;
            [self presentViewController:chooseVc animated:YES completion:nil];
        }
            
            break;
        case 2:{//我的团队
            MMDrawerController *mmdc = [GDHomeManager getRootMMDVc];
            UINavigationController *nav = (UINavigationController *)mmdc.centerViewController;
            if (nav.viewControllers&&nav.viewControllers.count>0) {
                for (UIViewController *obj in nav.viewControllers) {
                    if ([obj isKindOfClass:[GDHomeViewController class]]) {
                        GDHomeViewController *home = (GDHomeViewController *)obj;
                        [home reloadDataWithType:GDHomeTeamType];
                        break;
                    }
                }
            }

        }
            [GDHomeManager closeDrawer];
            break;
        case 3:{//我的调查
        }
            
            break;
        case 4:{//反馈与帮助
            [GDHomeManager closeDrawer];
            [self showHomeView:YES];
        }
            break;
        case 5:{//退出
            [self showQuitAlert];
        }
            break;

        default:
            break;
    }
    
}

//反馈与帮助
- (void)showHomeView:(BOOL)isHelp{
    
    MMDrawerController *mmdc = [GDHomeManager getRootMMDVc];
    UINavigationController *nav = (UINavigationController *)mmdc.centerViewController;
    if (nav.viewControllers&&nav.viewControllers.count>0) {
        for (UIViewController *obj in nav.viewControllers) {
            if ([obj isKindOfClass:[GDHomeViewController class]]) {
                GDHomeViewController *home = (GDHomeViewController *)obj;
                for (UIView *view in obj.view.subviews) {
                    if (view.tag == 1001&&isHelp) {
                        [home showHelpView];
                        break;
                    }else if (view.tag == 1000){
                        [home showAdHorizontally];
                        break;
                    }
                }
                break;
            }
        }
    }
}

- (void)chooseHeadImage {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    // Create the actions.
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        [self showCamera];
    }];
    
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"从手机相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        [self selectImageFromAlbum];
        
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
    }];
    

    // Add the actions.
    [alertController addAction:action1];
    [alertController addAction:action2];
    [alertController addAction:cancelAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)showQuitAlert {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"你确定要退出GoodDeed吗？" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    // Create the actions.
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
    }];
    
    UIAlertAction *otherAction = [UIAlertAction actionWithTitle:@"退出" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [GDHomeManager clearCache];
        GDWindow.rootViewController = [GDHomeManager getRootController:NO];
        
    }];
    [otherAction setValue:[UIColor colorWithHexString:@"#FF3B30"] forKey:@"titleTextColor"];
    
    // Add the actions.
    [alertController addAction:cancelAction];
    [alertController addAction:otherAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

#pragma mark 打开相机
- (void)showCamera{
    
    // 设置照片来源为相机
    self.imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
    // 设置进入相机时使用前置或后置摄像头
    self.imagePickerController.cameraDevice = UIImagePickerControllerCameraDeviceRear;
    // 展示选取照片控制器
    [self presentViewController:self.imagePickerController animated:YES completion:nil];
    
}


#pragma mark 从相册获取图片
- (void)selectImageFromAlbum
{
    self.imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:self.imagePickerController animated:YES completion:nil];
}

#pragma mark - UIImagePickerControllerDelegate
// 完成图片的选取后调用的方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    // 选取完图片后跳转回原控制器
    [picker dismissViewControllerAnimated:YES completion:nil];
    // 从info中将图片取出，并加载到imageView当中
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    [GDHomeManager uploadImage:image];
    if (self.headerView.imageBlock) {
        self.headerView.imageBlock(image);
    }
}

// 取消选取调用的方法
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self dismissViewControllerAnimated:YES completion:nil];
}

//刷新列表
- (void)reloadTableView{
    [self.tableView reloadData];
    
}

- (void)dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
