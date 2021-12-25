//
//  CardListViewController.m
//  VoteMe!
//
//  Created by 李浩宇 on 2021/11/21.
//

#import "VMCardListViewController.h"
#import "VMMainViewController.h"
#import <objc/runtime.h>
#import "VMNotificationListController.h"

static NSString * const cellID = @"cellID";

@interface VMCardListViewController ()<UICollectionViewDataSource>

@end

@implementation VMCardListViewController

-(instancetype)init{
    self = [super init];
    
    
    
    //[[VMWebManager shareInstance] getVoteListWithOffset:3 Limit:13 Status:1 OrderBy:@"created_at"];
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //[self.ListCollectionView reloadData];
    self.navigationBarView.title.text = @"Vote Me !";
    self.navigationBarView.title.font = [UIFont fontWithName:@"OCRAStd" size:16 * HEIGHT_SCALE];
    self.navigationBarView.backBtn.hidden = true;
    self.navigationBarView.notificationView.hidden = false;
    
    [self.navigationBarView.notificationView.maskButton addAction:[UIAction actionWithHandler:^(__kindof UIAction * _Nonnull action) {
        
        VMNotificationListController *vc = [[VMNotificationListController alloc] init];
        [[VMMainViewController sharedInstance].navigationController pushViewController:vc animated:true];

    }] forControlEvents:UIControlEventTouchUpInside];
    
    //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(orderChange:) name:@"orderChange" object:nil];
    
    [self updateVotePullDown];
    
    [self configureHierachy];
    
    //[[NSNotificationCenter defaultCenter] addObserver:self.orderSelectBarView forKeyPath:@"orderState" options:NSKeyValueObservingOptionNew context:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updatetheVote) name:@"HomeOrderChange" object:nil];

}

-(void)viewWillAppear:(BOOL)animated{
    //[self.ListCollectionView reloadData];
    [super viewWillAppear:animated];
}

-(void)configureHierachy{
    
    [self.view addSubview:self.orderSelectBarView];
    [self.orderSelectBarView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.navigationBarView.mas_bottom).priority(1000);
        make.left.right.equalTo(self.view).priority(1000);
    }];

    [self.view addSubview:self.ListCollectionView];
    [self.ListCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.orderSelectBarView.mas_bottom).priority(1000);
        make.left.right.equalTo(self.view).priority(1000);
        make.bottom.equalTo(self.view);
    }];
    
    //[self.view addSubview:self.orderSelectBarView];
    
    [self.view addSubview:self.postNewVoteButtom];
    [self.postNewVoteButtom mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view).with.offset(-19 * WIDTH_SCALE);
        make.bottom.equalTo(self.view).with.offset(-65 * HEIGHT_SCALE);
        make.width.mas_equalTo(50 * WIDTH_SCALE);
        make.height.mas_equalTo(50 * WIDTH_SCALE);
    }];
    
    [self.view addSubview:self.orderSelectBarView.subSelectBarView];
    [self.orderSelectBarView.subSelectBarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(24 * HEIGHT_SCALE);
        make.top.equalTo(self.orderSelectBarView.mas_bottom);
        //make.bottom.equalTo(self);
    }];
    
        // 注册
    [self.ListCollectionView registerClass:[VMCardListCollectionCell class] forCellWithReuseIdentifier:cellID];
    
    [self.orderSelectBarView.superview bringSubviewToFront:self.orderSelectBarView];
}

#pragma mark - SEL

-(void)updatetheVote{
    [self updateVoteWithFlag:VMRefresh];
    
    
    //[[self ListCollectionView] scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionMiddle animated:NO];
    [self.ListCollectionView.mj_header beginRefreshing];
}



-(void)enterPostNewVoteVC{
    
//    VMLoadingView *view = [[VMLoadingView alloc] init];
//    [[[VMViewControllerManager sharedInstance] getNowViewController].view addSubview:view];
//    [view mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.equalTo([[VMViewControllerManager sharedInstance] getNowViewController].view);
//    }];
    
 //   [VMCellConfigure configureNotificationCell];
    
    [[VMMainViewController sharedInstance].navigationController pushViewController:[[VMPostNewVoteController alloc] init] animated:true];
}

-(void)updateVotePullDown{
    [self updateVoteWithFlag:VMRefresh];
}

-(void)updateVoteDragUp{
    [self updateVoteWithFlag:VMLoadMore];
}

-(void)updateVoteWithFlag:(VMResponseFlag)flag{
    [VMWebManager shareInstance].delegate = self;
    
    if(flag == VMRefresh){
        //[[HHWebmanager shareInstance] getHoleWith:0 list_size:15 addFlag:flag is_last_reply:self.orderView.order == HHHoleShowOrderCommentFirst ? true : false];
        NSString *orderBy;
        switch (self.orderSelectBarView.orderState) {
            case 0:
                orderBy = @"end_time";
                break;
            
            case 1:
                orderBy = @"created_at";
                break;
                
            case 2:
                orderBy = @"updated_at";
                break;
            
            default:
                break;
        }
        
        [[VMWebManager shareInstance] getVoteListWithOffset:0 Limit:15 Status:(self.orderSelectBarView.orderState == VMOrderedCompleted ? 1 : 0) OrderBy:orderBy flag:(VMResponseFlag)VMRefresh];
        
    }else{

        //[[HHWebmanager shareInstance] getHoleWith:self.holesArray.count list_size:15 addFlag:flag is_last_reply:self.orderView.order == HHHoleShowOrderCommentFirst ? true : false];
        NSString *orderBy;
        switch (self.orderSelectBarView.orderState) {
            case 0:
                orderBy = @"end_time";
                break;
            
            case 1:
                orderBy = @"created_at";
                break;
                
            case 2:
                orderBy = @"updated_at";
                break;
            
            default:
                break;
        }
        
        [[VMWebManager shareInstance] getVoteListWithOffset:self.CardModelArray[self.CardModelArray.count - 1].vote_id Limit:15 Status:(self.orderSelectBarView.orderState == VMOrderedCompleted ? 1 : 0) OrderBy:orderBy flag:(VMResponseFlag)VMLoadMore];
    }
}




#pragma mark - <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    //return 20;
    return self.CardModelArray.count;
}
 
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    VMCardListCollectionCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    
    [VMCellConfigure configureVoteListCell:cell withModel:self.CardModelArray[indexPath.row]];
    
    NSLog(@"func1");
 
    return cell;
}

//-(void)enterDetailVCWithModel:(VMCardListCellModel *)model{
//    NSLog(@"func1");
//    
//    VMVoteDetailViewController *vc = [[VMVoteDetailViewController alloc] init];
//    [[VMMainViewController sharedInstance].navigationController pushViewController:vc animated:true];
//}




#pragma mark - 监测滚动
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
}

#pragma mark - waterFallLayout delegate
- (CGFloat)waterFallLayout:(VMWaterFallLayout *)waterFallLayout heightForItemAtIndexPath:(NSUInteger)indexPath itemWidth:(CGFloat)itemWidth{
    
//    [cell.masButton addAction:[UIAction actionWithHandler:^(__kindof UIAction * _Nonnull action) {
//
//        [self enterDetailVCWithModel:self.CardModelArray[indexPath.row]];
//
//    }]forControlEvents:UIControlEventTouchUpInside];
    
    return [self judgeCollectionCellWithModel:self.CardModelArray[indexPath]];
}

-(CGFloat)judgeCollectionCellWithModel:(VMCardListCellModel *)model{
    CGFloat titleBaseHaight = 41 * HEIGHT_SCALE, contentBaseHaight = 4 * HEIGHT_SCALE, optionsBaseHaight = 29 * HEIGHT_SCALE, optionsPlusHeight = 19 * HEIGHT_SCALE;
    

    NSInteger optionsNumber = model.optionsNumber;
    CGFloat optionHeight = optionsBaseHaight + optionsPlusHeight * optionsNumber;
    
    CGFloat titlePlusHeight = [model.title boundingRectWithSize:CGSizeMake(140 * WIDTH_SCALE, MAXFLOAT)
    options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin
    attributes:@{ NSFontAttributeName : [UIFont systemFontOfSize:12 * WIDTH_SCALE]} context:nil].size.height;
    CGFloat titleHeight = titleBaseHaight + MIN(titlePlusHeight, 34 * HEIGHT_SCALE);
    
    CGFloat contentPlusHeight = [model.content boundingRectWithSize:CGSizeMake(145 * WIDTH_SCALE, MAXFLOAT)
    options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin
    attributes:@{ NSFontAttributeName : [UIFont systemFontOfSize:7 * WIDTH_SCALE]} context:nil].size.height;
    CGFloat contentHeight = contentBaseHaight + MIN(contentPlusHeight, 34 * HEIGHT_SCALE);
    
    CGFloat sumHeight = titleHeight + contentHeight + optionHeight;
    return sumHeight;
    //return 300;
}

#pragma mark - Handle Web Response
-(void)handleVoteListWithResponse:(id)response flag:(VMResponseFlag)flag{
    if(flag == VMRefresh && [[response valueForKey:@"msg"] isEqualToString:@"查询成功"]){
        self.CardModelArray = [[NSMutableArray alloc] init];
        [self.CardModelArray removeAllObjects];
        [self.ListCollectionView.mj_header endRefreshing];
    }else if(flag == VMLoadMore  && [[response valueForKey:@"msg"] isEqualToString:@"查询成功"]){
        [self.ListCollectionView.mj_footer endRefreshing];
    }else{
        if([[response valueForKey:@"msg"] isEqualToString:@"查询无结果"]){
            if(flag == VMLoadMore){
                [self.ListCollectionView reloadData];
            }else{
                [self.CardModelArray removeAllObjects];
                [self.ListCollectionView reloadData];
            }

        }
        if(self.ListCollectionView.mj_header.isRefreshing) [self.ListCollectionView.mj_header endRefreshing];
        if(self.ListCollectionView.mj_footer.isRefreshing) [self.ListCollectionView.mj_footer endRefreshing];
        
        return ;
    }
    for (NSDictionary *dict in (NSArray *) [response valueForKey:@"data"]) {
        VMCardListCellModel *model = [VMCardListCellModel yy_modelWithDictionary:dict];
        
        for ( NSDictionary *optionDict in (NSArray *) [dict valueForKey:@"options"]){
            model.optionsNumber++;
        }
        
        [self.CardModelArray addObject:model];
    }
    [self.ListCollectionView reloadData];
    
    //[self.ListCollectionView reloadSections:[NSIndexSet indexSetWithIndex:0]];
}

//-(void)handleSingleVoteInfo:(id)response{
//
//    VMVoteDetailHostModel *model = [VMVoteDetailHostModel yy_modelWithDictionary:(NSDictionary *)response];
//
//    VMVoteDetailViewController *detailVC = [[VMVoteDetailViewController alloc] initWithHostModel:model];
//
//    [[VMMainViewController sharedInstance].navigationController pushViewController:detailVC animated:true];
//
//}

 

#pragma mark - lazy load

-(UICollectionView *)ListCollectionView{
    if(!_ListCollectionView){
        UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
            //layout.itemSize = CGSizeMake(50, 50);
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
     
        // 创建collectionView
        CGFloat collectionViewW = self.view.frame.size.width;
        CGFloat collectionViewH = self.view.frame.size.height;
//        _ListCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 100, collectionViewW, collectionViewH) collectionViewLayout:layout];
        _ListCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 100, collectionViewW, collectionViewH) collectionViewLayout:self.waterFallLayout];

        _ListCollectionView.backgroundColor = [UIColor colorWithHexString:kVMBackgroundColor];
        _ListCollectionView.dataSource = self;
        
        //_ListCollectionView.delegate = self;
        _ListCollectionView.mj_header = [MJRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(updateVotePullDown)];
        _ListCollectionView.mj_footer = [MJRefreshBackFooter footerWithRefreshingTarget:self refreshingAction:@selector(updateVoteDragUp)];
        
    }
    return _ListCollectionView;
    
}

-(VMWaterFallLayout *)waterFallLayout{
    if(!_waterFallLayout){
        _waterFallLayout = [[VMWaterFallLayout alloc] init];
        _waterFallLayout.delegate = self;
        
    }
    return _waterFallLayout;
}

-(UIButton *)postNewVoteButtom{
    if(!_postNewVoteButtom){
        _postNewVoteButtom = [[UIButton alloc] init];
        
        UIImageView *imageView= [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"PostNewVoteButtom"]];
        [_postNewVoteButtom addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(_postNewVoteButtom);
        }];
        
        [_postNewVoteButtom addTarget:self action:@selector(enterPostNewVoteVC) forControlEvents:UIControlEventTouchUpInside];
    }
    return _postNewVoteButtom;
}

-(VMOrderSelectBarView *)orderSelectBarView{
    if(!_orderSelectBarView){
        _orderSelectBarView = [[VMOrderSelectBarView alloc] init];
    }
    return _orderSelectBarView;
}

@end
