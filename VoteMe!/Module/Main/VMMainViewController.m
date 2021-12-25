//
//  CIMainViewController.m
//  VoteMe!
//
//  Created by 李浩宇 on 2021/11/25.
//

#import "VMMainViewController.h"

@interface VMMainViewController ()

@end

@implementation VMMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[VMWebManager shareInstance] getNowUserInfo];
    
    self.mainVC = self.HomePageVC;
    
    
    self.SubViewConrollerArray = [[NSMutableArray alloc] initWithObjects:self.HomePageVC, self.RankPageVC, self.UserPageVC, nil];
    
    [self configureHierachy];
    
    // Do any additional setup after loading the view.
}

+(instancetype)sharedInstanceWithRefreshFlag:(BOOL)flag{
    static dispatch_once_t MainViewSingleFlag;
    static VMMainViewController * shared;
    if(flag){
        shared = [[VMMainViewController alloc] init];
    }else{
        dispatch_once(&MainViewSingleFlag, ^{
            shared = [[VMMainViewController alloc] init];
            
        });
    }
    return shared;
}

+(instancetype)sharedInstance{
    return [self sharedInstanceWithRefreshFlag:false];
}

//-(void)destroyMainViewcontroller{
//    _BottomTabBar = [[VMBottomTabBar alloc] init];
//    _BottomTabBar.backgroundColor = [UIColor colorWithHexString:@"#FFFFFF"];
//    _BottomTabBar.ChangeViewControllerDelegate = self;
//    [_BottomTabBar configureBarItem];
//
//    _HomePageVC = [[VMCardListViewController alloc] init];
//    _RankPageVC = [[VMRankingViewController alloc] init];
//    _UserPageVC = [[VMUserPageViewController alloc] init];
//}

-(void)viewWillAppear:(BOOL)animated{
    [VMMainViewController sharedInstance].navigationController.navigationBarHidden = true;
    //[self.BottomTabBar configureBarItem];
}

-(void)configureHierachy{
    
    [self.view addSubview:self.mainVC.view];
    [self.mainVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [self.view addSubview:self.BottomTabBar];
    [self.BottomTabBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.view);
        //make.bottom.equalTo(self.view).with.offset(-13 * HEIGHT_SCALE);
        make.height.mas_equalTo(60 * HEIGHT_SCALE);
    }];
}

#pragma mark - BottomTabBar Delegate
-(void)switchMainViewController:(NSInteger)VCTag{
    [self.mainVC.view removeFromSuperview];
    self.mainVC = self.SubViewConrollerArray[VCTag];
    [self.view addSubview:self.mainVC.view];
    [self.mainVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);
    }];
    [self.view bringSubviewToFront:self.BottomTabBar];
}

#pragma mark - lazy load
-(VMBottomTabBar *)BottomTabBar{
    if(!_BottomTabBar){
        _BottomTabBar = [[VMBottomTabBar alloc] init];
        _BottomTabBar.backgroundColor = [UIColor colorWithHexString:@"#FFFFFF"];
        _BottomTabBar.ChangeViewControllerDelegate = self;
        [_BottomTabBar configureBarItem];
    }
    return _BottomTabBar;
}

-(VMBaseViewController *)HomePageVC{
    if(!_HomePageVC){
        _HomePageVC = [[VMCardListViewController alloc] init];
    }
    return _HomePageVC;
}

-(VMBaseViewController *)RankPageVC{
    if(!_RankPageVC){
        _RankPageVC = [[VMRankingViewController alloc] init];
    }
    return _RankPageVC;
}

-(VMBaseViewController *)UserPageVC{
    if(!_UserPageVC){
        _UserPageVC = [[VMUserPageViewController alloc] init];
    }
    return _UserPageVC;
}

@end
