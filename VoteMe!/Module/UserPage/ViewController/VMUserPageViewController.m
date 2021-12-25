//
//  VMUserViewController.m
//  VoteMe!
//
//  Created by 李浩宇 on 2021/11/25.
//

#import "VMUserPageViewController.h"
#import "VMMainViewController.h"
#import "VMLoginViewController.h"

@interface VMUserPageViewController ()

@end

@implementation VMUserPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationBarView.hidden = true;
    //self.navigationBarView.notificationView.hidden = false;
    self.view.backgroundColor = [UIColor colorWithHexString:kVMBackgroundColor];
    
    [self configureHierachy];
    
    [self updateUserInfo];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self getUserInfo];
}


-(void)configureHierachy{
    
    UIView *backgroundView1 = [[UIView alloc] init];
    backgroundView1.backgroundColor = [UIColor colorWithHexString:@"#A6B9FF"];
    
    UIView *backgroundView2 = [[UIView alloc] init];
    backgroundView2.backgroundColor = [UIColor colorWithHexString:@"#A6B9FF"];
    backgroundView2.layer.cornerRadius = 15 * WIDTH_SCALE;
    
    [self.view addSubview:backgroundView1];
    [backgroundView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.height.mas_equalTo(100 * HEIGHT_SCALE);
    }];
    [self.view addSubview:backgroundView2];
    [backgroundView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.height.mas_equalTo(200 * HEIGHT_SCALE);
    }];
    
    [self.view addSubview:self.userNameLabel];
    [self.userNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).with.offset(114 * HEIGHT_SCALE);
        make.left.equalTo(self.view).with.offset(35 * HEIGHT_SCALE);
        make.height.mas_equalTo(32 * HEIGHT_SCALE);
    }];
    
    [self.view addSubview:self.userEmailLabel];
    [self.userEmailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).with.offset(159 * HEIGHT_SCALE);
        make.left.equalTo(self.userNameLabel);
        make.height.mas_equalTo(15 * HEIGHT_SCALE);
    }];
    
    [self.view addSubview:self.myFavoriteButton];
    [self.myFavoriteButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view.mas_top).with.offset(348 * HEIGHT_SCALE);
        make.centerX.equalTo(self.view);
        make.width.mas_equalTo(310 * WIDTH_SCALE);
        make.height.mas_offset(116 * HEIGHT_SCALE);
    }];
    
    UIView *separater1 = [[UIView alloc] init];
    separater1.backgroundColor = [UIColor colorWithHexString:@"#CDD0CB"];
    [self.view addSubview:separater1];
    [separater1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.myFavoriteButton.mas_bottom);
        make.left.equalTo(self.myFavoriteButton);
        make.width.mas_equalTo(310 * WIDTH_SCALE);
        make.height.mas_offset(0.5 * HEIGHT_SCALE);
    }];
    
    [self.view addSubview:self.myCreateButton];
    [self.myCreateButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.myFavoriteButton.mas_bottom);
        make.centerX.equalTo(self.view);
        make.width.mas_equalTo(310 * WIDTH_SCALE);
        make.height.mas_offset(116 * HEIGHT_SCALE);
    }];
    
    UIView *separater2 = [[UIView alloc] init];
    separater2.backgroundColor = [UIColor colorWithHexString:@"#CDD0CB"];
    [self.view addSubview:separater2];
    [separater2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.myCreateButton.mas_bottom);
        make.left.equalTo(self.myCreateButton);
        make.width.mas_equalTo(310 * WIDTH_SCALE);
        make.height.mas_offset(0.5 * HEIGHT_SCALE);
    }];
    
    [self.view addSubview:self.myJoinButton];
    [self.myJoinButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.myCreateButton.mas_bottom);
        make.centerX.equalTo(self.view);
        make.width.mas_equalTo(310 * WIDTH_SCALE);
        make.height.mas_offset(116 * HEIGHT_SCALE);
    }];
    
    
    [self.view addSubview:self.notificationBubble];
    [self.notificationBubble mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.bottom.equalTo(self).with.offset(-13 * HEIGHT_SCALE);
        make.top.equalTo(self.view).with.offset(42 * HEIGHT_SCALE);
        make.right.equalTo(self.view).with.offset(-28 * WIDTH_SCALE);
//        make.width.mas_offset(10 * WIDTH_SCALE * 3);
//        make.height.mas_equalTo(18 * HEIGHT_SCALE * 2);
    }];
    
    [self.view addSubview:self.logoutButton];
    [self.logoutButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.myJoinButton.mas_bottom).with.offset(20 * HEIGHT_SCALE);
        make.centerX.equalTo(self.view);
        make.width.mas_equalTo(157 * WIDTH_SCALE);
        make.height.mas_equalTo(40 * HEIGHT_SCALE);
    }];
    
}


-(void)showMyFavorate{
    VMUserVoteListController *vc = [[VMUserVoteListController alloc] initWithState:VMUserTopBarCollection];
    
    [[VMMainViewController sharedInstance].navigationController pushViewController:vc animated:true];
    
}

-(void)showMyCreate{
    VMUserVoteListController *vc = [[VMUserVoteListController alloc] initWithState:VMUserTopBarCreated];
    
    [[VMMainViewController sharedInstance].navigationController pushViewController:vc animated:true];
}

-(void)showMyJoin{
    VMUserVoteListController *vc = [[VMUserVoteListController alloc] initWithState:VMUserTopBarJoined];
    
    [[VMMainViewController sharedInstance].navigationController pushViewController:vc animated:true];
}


-(void)updateUserInfo{
    if([[VMUserDefaultManager sharedInstance] valueForKey:@"name"]){
        self.userNameLabel.text = [[VMUserDefaultManager sharedInstance] valueForKey:@"name"];
    }
    if([[VMUserDefaultManager sharedInstance] valueForKey:@"email"]){
        self.userEmailLabel.text = [[VMUserDefaultManager sharedInstance] valueForKey:@"email"];
    }
    //self.userEmailLabel.text = [[VMUserDefaultManager sharedInstance] valueForKey:@"email"];
}

-(void)getUserInfo{
    [VMWebManager shareInstance].delegate = self;
    [[VMWebManager shareInstance] getNowUserInfo];
}

-(void)logout{
    VMPopView *popView = [[VMPopView alloc] initWithType:VMPopType0 title:@"确认退出此账号" content:@"你将从此设备登出账户，再次使用此账户需要重新登录！" leftText:@"取消" rightText:@"确认"];
    
    [popView.rightButton addAction:[UIAction actionWithHandler:^(__kindof UIAction * _Nonnull action) {
        
        [[VMUserDefaultManager sharedInstance] logOut];
        
        VMLoginViewController *welVC = [[VMLoginViewController alloc] init];
        
        UINavigationController *navigate = [[UINavigationController alloc] initWithRootViewController:welVC];
        
        [UIWindow getRootWindow].rootViewController = navigate;
        navigate.navigationBar.hidden = true;
        [[UIWindow getRootWindow] makeKeyAndVisible];
        
    }]forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:popView];
    [popView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [self.view bringSubviewToFront:popView];
}

#pragma mark - 网络请求回调

-(void)handleNowUserInfoWithResponse:(id)response success:(BOOL)success{
    
    if(success){
        [[VMUserDefaultManager sharedInstance] setValue:[[response valueForKey:@"Info"] valueForKey:@"name"] forKey:@"name"];
        [[VMUserDefaultManager sharedInstance] setValue:[[response valueForKey:@"Info"] valueForKey:@"email"] forKey:@"email"];
    }

    [self updateUserInfo];
}


#pragma mark - lazy load
-(UILabel *)userNameLabel{
    if(!_userNameLabel){
        _userNameLabel = [[UILabel alloc] init];
        _userNameLabel.font = [UIFont systemFontOfSize:24 * WIDTH_SCALE];
        _userNameLabel.textColor = [UIColor colorWithHexString:@"#191D21"];
        _userNameLabel.text = @"野兽先辈";
    }
    return _userNameLabel;
}

-(UILabel *)userEmailLabel{
    if(!_userEmailLabel){
        _userEmailLabel = [[UILabel alloc] init];
        _userEmailLabel.font = [UIFont systemFontOfSize:12 * WIDTH_SCALE];
        _userEmailLabel.textColor = [UIColor colorWithHexString:@"#000000"];
        _userEmailLabel.text = @"114514@von.com";
    }
    return _userEmailLabel;
}

-(VMUserPageButton *)myFavoriteButton{
    if(!_myFavoriteButton){
        _myFavoriteButton = [[VMUserPageButton alloc] initWithImageName:@"UserMyFavoriteIcon" labelTaxt:@"我收藏的"];
        [_myFavoriteButton.actionButton addTarget:self action:@selector(showMyFavorate) forControlEvents:UIControlEventTouchUpInside];
    }
    return _myFavoriteButton;
}

-(VMUserPageButton *)myCreateButton{
    if(!_myCreateButton){
        _myCreateButton = [[VMUserPageButton alloc] initWithImageName:@"UserMyCreateIcon" labelTaxt:@"我发起的"];
        [_myCreateButton.actionButton addTarget:self action:@selector(showMyCreate) forControlEvents:UIControlEventTouchUpInside];
    }
    return _myCreateButton;
}

-(VMUserPageButton *)myJoinButton{
    if(!_myJoinButton){
        _myJoinButton = [[VMUserPageButton alloc] initWithImageName:@"UserMyJoinIcon" labelTaxt:@"我参与的"];
        [_myJoinButton.actionButton addTarget:self action:@selector(showMyJoin) forControlEvents:UIControlEventTouchUpInside];
    }
    return _myJoinButton;
}

-(VMNotificationBubbleView *)notificationBubble{
    if(!_notificationBubble){
        _notificationBubble = [[VMNotificationBubbleView alloc] init];
    }
    return _notificationBubble;
}

-(UIButton *)logoutButton{
    if(!_logoutButton){
        _logoutButton = [[UIButton alloc] init];
        
        _logoutButton.backgroundColor = [UIColor colorWithHexString:@"#F8FCFF"];
        _logoutButton.layer.cornerRadius = 20 * WIDTH_SCALE;
        
        _logoutButton.titleLabel.font = [UIFont systemFontOfSize:16 * WIDTH_SCALE];
        [_logoutButton setTitle:@"退出账号" forState:(UIControlStateNormal)];
        [_logoutButton setTitleColor:[UIColor colorWithHexString:@"#000000"] forState:(UIControlStateNormal)];
        
        [UIView configureShadow:_logoutButton];
        
        [_logoutButton addTarget:self action:@selector(logout) forControlEvents:UIControlEventTouchUpInside];
    }
    return _logoutButton;
}
//-(VMLabel *)testLabel{
//    if(!_testLabel){
//        _testLabel = [[VMLabel alloc] init];
//        _testLabel.backgroundColor = [UIColor whiteColor];
//        _testLabel.textColor       = [UIColor blackColor];
//        _testLabel.font            = [UIFont systemFontOfSize:12.0f];
//        _testLabel.textInsets      = UIEdgeInsetsMake(0, 50, 0, 0); // 设置左内边距
//        _testLabel.text = @"哈哈哈哈哈啊哈";
//    }
//    return _testLabel;
//}

@end
