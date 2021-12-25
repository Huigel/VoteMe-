//
//  VMRankViewController.m
//  VoteMe!
//
//  Created by 李浩宇 on 2021/11/25.
//

#import "VMRankingViewController.h"
#import "VMMainViewController.h"
#import "VMNotificationListController.h"

@interface VMRankingViewController ()

@end

@implementation VMRankingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationBarView.title.text = @"Vote Me !";
    self.navigationBarView.title.font = [UIFont fontWithName:@"OCRAStd" size:16 * HEIGHT_SCALE];
    self.navigationBarView.backBtn.hidden = true;
    self.navigationBarView.notificationView.hidden = false;
    
    [self.navigationBarView.notificationView.maskButton addAction:[UIAction actionWithHandler:^(__kindof UIAction * _Nonnull action) {
        
        VMNotificationListController *vc = [[VMNotificationListController alloc] init];
        [[VMMainViewController sharedInstance].navigationController pushViewController:vc animated:true];

    }] forControlEvents:UIControlEventTouchUpInside];
    
    if([[VMUserDefaultManager sharedInstance] objectForKey:@"name"]){
        self.userCard.UserNameLabel.text = [[VMUserDefaultManager sharedInstance] valueForKey:@"name"];
    }
    
    [VMWebManager shareInstance].delegate = self;
    [[VMWebManager shareInstance] getRankListWithOffset:0 Limit:40];
    [[VMWebManager shareInstance] getMyRank];
    
    self.view.backgroundColor = [UIColor colorWithHexString:kVMBackgroundColor];
    
    [self configureHierachy];
    // Do any additional setup after loading the view.
}


-(void)configureHierachy{
    [self.view addSubview:self.userCard];
    [self.userCard mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.width.mas_equalTo(326 * WIDTH_SCALE);
        make.height.mas_equalTo(101 * HEIGHT_SCALE);
        make.top.equalTo(self.view).with.offset(137 * HEIGHT_SCALE);
    }];
    
    [self.view addSubview:self.listBoard];
    [self.listBoard mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.width.mas_equalTo(326 * WIDTH_SCALE);
        make.height.mas_equalTo(455 * HEIGHT_SCALE);
        make.top.equalTo(self.userCard.mas_bottom).with.offset(20 * HEIGHT_SCALE);
    }];
    
    [self.view addSubview:self.tipsButton];
    [self.tipsButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.width.mas_equalTo(200 * WIDTH_SCALE);
        make.height.mas_equalTo(14 * HEIGHT_SCALE);
        make.top.equalTo(self.listBoard.mas_bottom).with.offset(8 * HEIGHT_SCALE);
    }];
    
//    self.rankBoardCellModelArray = [[NSMutableArray<VMRankBoardCellModel *> alloc] init];
//    for(NSInteger i = 1 ; i <= 35; i++){
//        VMRankBoardCellModel *model = [[VMRankBoardCellModel alloc] init];
//        
//        model.score = 666;
//        model.name = @"张飞";
//        [self.rankBoardCellModelArray addObject:model];
//    }
//    
//    [self.listBoard configureCell:self.rankBoardCellModelArray];
    
}


-(void)enterTipsVC{
    [[VMMainViewController sharedInstance].navigationController pushViewController:[[VMRankTipsViewController alloc] init] animated:true];
    NSLog(@"??");
}


#pragma mark - ScrollView Delegate
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
}

#pragma mark - 网络请求回调

-(void)handleRankListWithResponse:(_Nullable id)response success:(BOOL)success{
    if(success){
        [self.rankBoardCellModelArray removeAllObjects];
        
        for (NSDictionary *dict in (NSArray *) response) {
            VMRankBoardCellModel *model = [VMRankBoardCellModel yy_modelWithDictionary:dict];
            
            [self.rankBoardCellModelArray addObject:model];
        }
        
        [self.listBoard configureCell:self.rankBoardCellModelArray];
    }

}

-(void)handleMyRankWithResponse:(_Nullable id)response success:(BOOL)success{
    if(success){
        if([response objectForKey:@"Score"]){
            self.userCard.UserScoreLabel.text = [NSString stringWithFormat:@"你的积分为：%@分",[response valueForKey:@"Score"]];
        }
        if([response objectForKey:@"Rank"]){
            self.userCard.UserRankingLabel.text = [NSString stringWithFormat:@"排名是：%@名",[response valueForKey:@"Rank"]];
        }
    }else{
        [self.view makeToast:@"获取积分失败" duration:1 position:CSToastPositionCenter];
    }
}

#pragma mark - lazy load
-(VMRankPageUserCardView *)userCard{
    if(!_userCard){
        _userCard = [[VMRankPageUserCardView alloc] init];
        
    }
    return _userCard;
}

-(VMRankListBoardView *)listBoard{
    if(!_listBoard){
        _listBoard = [[VMRankListBoardView alloc] init];
        _listBoard.rankingScrollView.delegate = self;
    }
    return _listBoard;
}

-(UIButton *)tipsButton{
    if(!_tipsButton){
        _tipsButton = [[UIButton alloc] init];
        UILabel *tipsButtonLabel = [[UILabel alloc] init];
        tipsButtonLabel.text = @"什么是排行榜？如何计算积分和排名？";
        tipsButtonLabel.font = [UIFont systemFontOfSize:(11 * WIDTH_SCALE)];
        tipsButtonLabel.textColor = [UIColor colorWithHexString:@"#FFC76F"];
        [_tipsButton addSubview:tipsButtonLabel];
        [tipsButtonLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(tipsButtonLabel);
        }];
        [_tipsButton addTarget:self action:@selector(enterTipsVC) forControlEvents:UIControlEventTouchUpInside];
    }
    return _tipsButton;
}

-(NSMutableArray<VMRankBoardCellModel *> *)rankBoardCellModelArray{
    if(!_rankBoardCellModelArray){
        _rankBoardCellModelArray = [[NSMutableArray<VMRankBoardCellModel *> alloc] init];
    }
    return _rankBoardCellModelArray;
}

@end
