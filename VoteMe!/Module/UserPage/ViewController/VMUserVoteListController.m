//
//  VMUserCardListController.m
//  VoteMe!
//
//  Created by 李浩宇 on 2021/12/6.
//

#import "VMUserVoteListController.h"

static NSString * const favoriteCellID = @"favoriteCellID";
static NSString * const createCellID = @"createCellID";
static NSString * const joinCellID = @"joinCellID";

@interface VMUserVoteListController ()

@end

@implementation VMUserVoteListController

-(instancetype)initWithState:(VMUserTopBarState)Nowstate{
    self = [super init];
    
    self.state = Nowstate;
    
    
    
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationBarView.backBtn.hidden = false;
    
    [self configureHierachy];
    
    [self updateVotePullDownWithCollection:self.favoriteCollectionView];
    [self updateVotePullDownWithCollection:self.createCollectionView];
    [self updateVotePullDownWithCollection:self.joinCollectionView];
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [self switchCardList:self.state];
}

-(void)configureHierachy{
    
    [self.view addSubview:self.topBarView];
    [self.topBarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.navigationBarView.mas_bottom);
        make.left.right.equalTo(self.view);
        
    }];
    
    [self.view addSubview:self.backgroundScrollView];
    [self.backgroundScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(self.topBarView.mas_bottom);
    }];
    
    [self.backgroundScrollView addSubview:self.containerView];
    [self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.backgroundScrollView);
        make.height.equalTo(self.backgroundScrollView);
    }];
    
//    self.favoriteCollectionView.backgroundColor = [UIColor redColor];
//    self.createCollectionView.backgroundColor = [UIColor greenColor];
//    self.joinCollectionView.backgroundColor = [UIColor yellowColor];
    
    [self.containerView addSubview:self.favoriteCollectionView];
    [self.favoriteCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.left.equalTo(self.containerView);
        make.width.mas_equalTo(UIScreen.mainScreen.bounds.size.width);
    }];
    
    [self.containerView addSubview:self.createCollectionView];
    [self.createCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.containerView);
        make.left.equalTo(self.favoriteCollectionView.mas_right);
        make.width.mas_equalTo(UIScreen.mainScreen.bounds.size.width);
    }];
    
    [self.containerView addSubview:self.joinCollectionView];
    [self.joinCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.right.equalTo(self.containerView);
        make.left.equalTo(self.createCollectionView.mas_right);
        make.width.mas_equalTo(UIScreen.mainScreen.bounds.size.width);
    }];
    
    [self.favoriteCollectionView registerClass:[VMCardListCollectionCell class] forCellWithReuseIdentifier:favoriteCellID];
    [self.createCollectionView registerClass:[VMCardListCollectionCell class] forCellWithReuseIdentifier:createCellID];
    [self.joinCollectionView registerClass:[VMCardListCollectionCell class] forCellWithReuseIdentifier:joinCellID];
    
    
}
#pragma mark - SEL

-(void)updatetheVoteWithCollection:(UICollectionView *)collectionView{
    //[self updateVoteWithFlag:VMRefresh];
    
    //[[self ListCollectionView] scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionMiddle animated:NO];
    //[self.ListCollectionView.mj_header beginRefreshing];
    
    [self updateVoteWithCollection:collectionView Flag:VMRefresh];
    
    [collectionView.mj_header beginRefreshing];
    
}

-(void)updateVotePullDownWithCollection:(UICollectionView *)collectionView{
    //[self updateVoteWithFlag:VMRefresh];
    [self updateVoteWithCollection:collectionView Flag:VMRefresh];
}

-(void)updateVoteDragUpWithCollection:(UICollectionView *)collectionView{
    //[self updateVoteWithFlag:VMLoadMore];
    [self updateVoteWithCollection:collectionView Flag:VMLoadMore];
}


-(void)updateVoteWithCollection:(UICollectionView *)collectionView Flag:(VMResponseFlag)flag{
    [VMWebManager shareInstance].delegate = self;
    
    VMCardListModeFlag cardListModeFlag;
    NSInteger count;
    
    if([collectionView isEqual:self.favoriteCollectionView]){
        cardListModeFlag = VMFavorite;
        count = self.favoriteModelArray.count;
    }else if ([collectionView isEqual:self.createCollectionView]){
        cardListModeFlag = VMCreate;
        count = self.createModelArray.count;
    }else{
        cardListModeFlag = VMJoin;
        count = self.joinModelArray.count;
    }
    
    [VMWebManager shareInstance].delegate = self;
    if(flag == VMRefresh){
        [[VMWebManager shareInstance] getVoteListWithOffset:0 Limit:15 OrderBy:@"created_at" cardListMode:cardListModeFlag flag:flag];
    }else{
        [[VMWebManager shareInstance] getVoteListWithOffset:count Limit:15 OrderBy:@"created_at" cardListMode:cardListModeFlag flag:flag];
    }
}



#pragma mark - <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if([collectionView isEqual:self.favoriteCollectionView]){
        return self.favoriteModelArray.count;
    }else if ([collectionView isEqual:self.createCollectionView]){
        return self.createModelArray.count;
    }else{
        return self.joinModelArray.count;
    }
}
 
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if([collectionView isEqual:self.favoriteCollectionView]){
        VMCardListCollectionCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:favoriteCellID forIndexPath:indexPath];
        [VMCellConfigure configureVoteListCell:cell withModel:self.favoriteModelArray[indexPath.row]];
        return cell;
    }else if ([collectionView isEqual:self.createCollectionView]){
        VMCardListCollectionCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:createCellID forIndexPath:indexPath];
        [VMCellConfigure configureVoteListCell:cell withModel:self.createModelArray[indexPath.row]];
        return cell;
    }else{
        VMCardListCollectionCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:joinCellID forIndexPath:indexPath];
        [VMCellConfigure configureVoteListCell:cell withModel:self.joinModelArray[indexPath.row]];
        return cell;
    }
    
//    [VMCellConfigure configureVoteListCell:cell withModel:self.CardModelArray[indexPath.row]];
//
//    NSLog(@"func1");
//
//    return cell;
}

#pragma mark - waterFallLayout delegate
- (CGFloat)waterFallLayout:(VMWaterFallLayout *)waterFallLayout heightForItemAtIndexPath:(NSUInteger)indexPath itemWidth:(CGFloat)itemWidth{
    
    if([waterFallLayout isEqual:self.favoriteWaterFallLayout]){
        return [self judgeCollectionCellWithModel:self.favoriteModelArray[indexPath]];
    }else if ([waterFallLayout isEqual:self.createollectionWaterFallLayout]){
        return [self judgeCollectionCellWithModel:self.createModelArray[indexPath]];
    }else{
        return [self judgeCollectionCellWithModel:self.joinModelArray[indexPath]];
    }
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



-(void)back{
    [self.navigationController popViewControllerAnimated:TRUE];
}


-(void)switchCardList:(VMUserTopBarState)newState{
    self.topBarView.currentState = newState;
    self.state = newState;

    
    [UIView animateWithDuration:0.1 animations:^{
        self.backgroundScrollView.contentOffset = CGPointMake(UIScreen.mainScreen.bounds.size.width * newState, 0);
//        CGFloat test = self.backgroundScrollView.contentOffset.x;
//        NSInteger i = 1;
    }];
    //UIButton *nextButton = [[UIButton alloc] init];
    switch (newState) {
        case VMUserTopBarCollection:
            [self.topBarView.collectionButton setTitleColor:[UIColor colorWithHexString:kVMButtonSelectedColor] forState:UIControlStateNormal];
            [self.topBarView.createdButton setTitleColor:[UIColor colorWithHexString:kVMButtonUnselectedColor] forState:UIControlStateNormal];
            [self.topBarView.joinedButton setTitleColor:[UIColor colorWithHexString:kVMButtonUnselectedColor] forState:UIControlStateNormal];
            //nextButton = self.myHoleTabBtn;

            if(self.favoriteCollectionView.mj_header.isRefreshing){
                [self.favoriteCollectionView.mj_header endRefreshing];
                [self.favoriteCollectionView reloadData];
            }
            if(self.favoriteCollectionView.mj_footer.isRefreshing){
                [self.favoriteCollectionView.mj_footer endRefreshing];
                [self.favoriteCollectionView reloadData];
            }
            {
                [self.topBarView.bottomBarView mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.width.mas_equalTo(40 * WIDTH_SCALE);
                    make.height.mas_equalTo(1 * HEIGHT_SCALE);
                    make.bottom.equalTo(self.topBarView).with.offset(-6 * HEIGHT_SCALE);
                    make.centerX.equalTo(self.topBarView.collectionButton);
                }];
            }
            break;
        case VMUserTopBarCreated:
            [self.topBarView.collectionButton setTitleColor:[UIColor colorWithHexString:kVMButtonUnselectedColor] forState:UIControlStateNormal];
            [self.topBarView.createdButton setTitleColor:[UIColor colorWithHexString:kVMButtonSelectedColor] forState:UIControlStateNormal];
            [self.topBarView.joinedButton setTitleColor:[UIColor colorWithHexString:kVMButtonUnselectedColor] forState:UIControlStateNormal];
            //nextButton = self.myFollowTabBtn;
            if(self.createCollectionView.mj_header.isRefreshing){
                [self.createCollectionView.mj_header endRefreshing];
                [self.createCollectionView reloadData];
            }
            if(self.createCollectionView.mj_footer.isRefreshing){
                [self.createCollectionView.mj_footer endRefreshing];
                [self.createCollectionView reloadData];
            }
            {
                [self.topBarView.bottomBarView mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.width.mas_equalTo(40 * WIDTH_SCALE);
                    make.height.mas_equalTo(1 * HEIGHT_SCALE);
                    make.bottom.equalTo(self.topBarView).with.offset(-6 * HEIGHT_SCALE);
                    make.centerX.equalTo(self.topBarView.createdButton);
                }];
            }
            break;
        case VMUserTopBarJoined:
            [self.topBarView.collectionButton setTitleColor:[UIColor colorWithHexString:kVMButtonUnselectedColor] forState:UIControlStateNormal];
            [self.topBarView.createdButton setTitleColor:[UIColor colorWithHexString:kVMButtonUnselectedColor] forState:UIControlStateNormal];
            [self.topBarView.joinedButton setTitleColor:[UIColor colorWithHexString:kVMButtonSelectedColor] forState:UIControlStateNormal];
            //nextButton = self.myReplyTabBtn;
            if(self.joinCollectionView.mj_header.isRefreshing){
                [self.joinCollectionView.mj_header endRefreshing];
                [self.joinCollectionView reloadData];
            }
            if(self.joinCollectionView.mj_footer.isRefreshing){
                [self.joinCollectionView.mj_footer endRefreshing];
                [self.joinCollectionView reloadData];
            }
            {
                [self.topBarView.bottomBarView mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.width.mas_equalTo(40 * WIDTH_SCALE);
                    make.height.mas_equalTo(1 * HEIGHT_SCALE);
                    make.bottom.equalTo(self.topBarView).with.offset(-6 * HEIGHT_SCALE);
                    make.centerX.equalTo(self.topBarView.joinedButton);
                }];
            }
            break;

        default:
            break;
    }
//    [self.lineView mas_remakeConstraints:^(MASConstraintMaker *make) {
//        make.width.mas_equalTo(38 * WIDTH_SCALE);
//        make.height.mas_equalTo(4);
//        make.bottom.equalTo(self.pageSwitchBar);
//        make.centerX.equalTo(nextButton);
//    }];
   // self.backgroundScrollView.contentOffset = CGPointMake(UIScreen.mainScreen.bounds.size.width * newState, 0);

}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if(scrollView == self.backgroundScrollView){
        
        if(scrollView.contentOffset.x == 0){
            if(self.favoriteCollectionView.mj_header.isRefreshing){
                [self.favoriteCollectionView.mj_header endRefreshing];
                [self.favoriteCollectionView reloadData];
            }
            if(self.favoriteCollectionView.mj_footer.isRefreshing){
                [self.favoriteCollectionView.mj_footer endRefreshing];
                [self.favoriteCollectionView reloadData];
            }

        }else if (scrollView.contentOffset.x == UIScreen.mainScreen.bounds.size.width){
//            if(self.createCollectionView.mj_header.isRefreshing){
                [self.createCollectionView.mj_header endRefreshing];
//                [self.createCollectionView reloadData];
//            }
//            if(self.createCollectionView.mj_footer.isRefreshing){
                [self.createCollectionView.mj_footer endRefreshing];
                [self.createCollectionView reloadData];
//            }

        }else if (scrollView.contentOffset.x == 2 * UIScreen.mainScreen.bounds.size.width){
            if(self.joinCollectionView.mj_header.isRefreshing){
                [self.joinCollectionView.mj_header endRefreshing];
                [self.joinCollectionView reloadData];
            }
            if(self.joinCollectionView.mj_footer.isRefreshing){
                [self.joinCollectionView.mj_footer endRefreshing];
                [self.joinCollectionView reloadData];
            }

        }
        
        NSInteger offset_x = scrollView.contentOffset.x;
        NSInteger tab = offset_x / UIScreen.mainScreen.bounds.size.width;
        switch (tab) {
            case 0:
                [self switchCardList:VMUserTopBarCollection];
                break;
            case 1:
                [self switchCardList:VMUserTopBarCreated];
                break;
            case 2:
                [self switchCardList:VMUserTopBarJoined];
                break;
            default:
                break;
        }
    }

}


#pragma mark - 网络请求回调

-(void)handleVoteListWithResponse:(id)response mode:(VMCardListModeFlag)cardListModeFlag flag:(VMResponseFlag)flag{
    
    UICollectionView *collectionView;
    NSMutableArray<VMCardListCellModel *> *modelArray;
    
    if(cardListModeFlag == VMFavorite){
        collectionView = self.favoriteCollectionView;
        modelArray = self.favoriteModelArray;
    }else if (cardListModeFlag == VMCreate){
        collectionView = self.createCollectionView;
        modelArray = self.createModelArray;
    }else{
        collectionView = self.joinCollectionView;
        modelArray = self.joinModelArray;
    }
    
    if(flag == VMRefresh && response){
        [modelArray removeAllObjects];
        
//        if(cardListModeFlag == VMFavorite){
//            [self.favoriteModelArray removeAllObjects];
//        }else if (cardListModeFlag == VMCreate){
//            [self.createModelArray removeAllObjects];
//        }else{
//            [self.joinModelArray removeAllObjects];
//        }
        
        [collectionView.mj_header endRefreshing];
    }else if(flag == VMLoadMore){
        [collectionView.mj_footer endRefreshing];
    }else{
        if(collectionView.mj_header.isRefreshing) [collectionView.mj_header endRefreshing];
        if(collectionView.mj_footer.isRefreshing) [collectionView.mj_footer endRefreshing];
        //[modelArray removeAllObjects];
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [collectionView reloadData];
            [self switchCardList:self.state];
        });
        return ;
    }
    if(!response){
        return;
    }
//    if([response objectForKey:@"Code"]){
//        return;
//    }
    for (NSDictionary *dict in (NSArray *) response) {
        VMCardListCellModel *model = [VMCardListCellModel yy_modelWithDictionary:dict];
        
        if(!model){
            break;
        }
        
        for ( NSDictionary *optionDict in (NSArray *) [dict valueForKey:@"options"]){
            model.optionsNumber++;
        }
        
        [modelArray addObject:model];
//        if(cardListModeFlag == VMFavorite){
//            [self.favoriteModelArray addObject:model];
//        }else if (cardListModeFlag == VMCreate){
//            [self.createModelArray addObject:model];
//        }else{
//            [self.joinModelArray addObject:model];
//        }
    }

    dispatch_async(dispatch_get_main_queue(), ^{
        
        [collectionView reloadData];
        [self switchCardList:self.state];
    });
}


#pragma mark - lazy load
-(UIScrollView *)backgroundScrollView{
    if(!_backgroundScrollView){
        _backgroundScrollView = [[UIScrollView alloc] init];
        _backgroundScrollView.pagingEnabled = true;
        _backgroundScrollView.showsHorizontalScrollIndicator = false;
        _backgroundScrollView.showsVerticalScrollIndicator = false;
        _backgroundScrollView.delegate = self;
        
        
    }
    return _backgroundScrollView;
}

-(UIView *)containerView{
    if(!_containerView){
        _containerView = [[UIView alloc] init];
    }
    return _containerView;
}

-(UICollectionView *)favoriteCollectionView{
    if(!_favoriteCollectionView){
        UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];;
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
     
        // 创建collectionView
        CGFloat collectionViewW = self.view.frame.size.width;
        CGFloat collectionViewH = self.view.frame.size.height;
        _favoriteCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 100, collectionViewW, collectionViewH) collectionViewLayout:self.favoriteWaterFallLayout];
        
        _favoriteCollectionView.backgroundColor = [UIColor colorWithHexString:kVMBackgroundColor];
        _favoriteCollectionView.dataSource = self;
        
        __weak typeof(self) Weakself = self;
        _favoriteCollectionView.mj_header = [MJRefreshHeader headerWithRefreshingBlock:^{
            [Weakself updateVotePullDownWithCollection:_favoriteCollectionView];
        }];
        _favoriteCollectionView.mj_footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
            [Weakself updateVoteDragUpWithCollection:_favoriteCollectionView];
        }];
    }
    return _favoriteCollectionView;
}

-(UICollectionView *)createCollectionView{
    if(!_createCollectionView){
        UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];;
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
     
        // 创建collectionView
        CGFloat collectionViewW = self.view.frame.size.width;
        CGFloat collectionViewH = self.view.frame.size.height;
        _createCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 100, collectionViewW, collectionViewH) collectionViewLayout:self.createollectionWaterFallLayout];

        _createCollectionView.backgroundColor = [UIColor colorWithHexString:kVMBackgroundColor];
        _createCollectionView.dataSource = self;
        
        __weak typeof(self) Weakself = self;
        _createCollectionView.mj_header = [MJRefreshHeader headerWithRefreshingBlock:^{
            [Weakself updateVotePullDownWithCollection:_createCollectionView];
        }];
        _createCollectionView.mj_footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
            [Weakself updateVoteDragUpWithCollection:_createCollectionView];
        }];
    }
    return _createCollectionView;
}

-(UICollectionView *)joinCollectionView{
    if(!_joinCollectionView){
        UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];;
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
     
        // 创建collectionView
        CGFloat collectionViewW = self.view.frame.size.width;
        CGFloat collectionViewH = self.view.frame.size.height;
        _joinCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 100, collectionViewW, collectionViewH) collectionViewLayout:self.joinWaterFallLayout];

        _joinCollectionView.backgroundColor = [UIColor colorWithHexString:kVMBackgroundColor];
        _joinCollectionView.dataSource = self;
        
        __weak typeof(self) Weakself = self;
        _joinCollectionView.mj_header = [MJRefreshHeader headerWithRefreshingBlock:^{
            [Weakself updateVotePullDownWithCollection:_joinCollectionView];
        }];
        _joinCollectionView.mj_footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
            [Weakself updateVoteDragUpWithCollection:_joinCollectionView];
        }];
    }
    return _joinCollectionView;
}


-(VMWaterFallLayout *)favoriteWaterFallLayout{
    if(!_favoriteWaterFallLayout){
        _favoriteWaterFallLayout = [[VMWaterFallLayout alloc] init];
        _favoriteWaterFallLayout.delegate = self;
        
    }
    return _favoriteWaterFallLayout;
}

-(VMWaterFallLayout *)createollectionWaterFallLayout{
    if(!_createollectionWaterFallLayout){
        _createollectionWaterFallLayout = [[VMWaterFallLayout alloc] init];
        _createollectionWaterFallLayout.delegate = self;
        
    }
    return _createollectionWaterFallLayout;
}

-(VMWaterFallLayout *)joinWaterFallLayout{
    if(!_joinWaterFallLayout){
        _joinWaterFallLayout = [[VMWaterFallLayout alloc] init];
        _joinWaterFallLayout.delegate = self;
        
    }
    return _joinWaterFallLayout;
}

-(NSMutableArray<VMCardListCellModel *> *)favoriteModelArray{
    if(!_favoriteModelArray){
        _favoriteModelArray = [[NSMutableArray<VMCardListCellModel *> alloc] init];
    }
    return _favoriteModelArray;
}

-(NSMutableArray<VMCardListCellModel *> *)createModelArray{
    if(!_createModelArray){
        _createModelArray = [[NSMutableArray<VMCardListCellModel *> alloc] init];
    }
    return _createModelArray;
}

-(NSMutableArray<VMCardListCellModel *> *)joinModelArray{
    if(!_joinModelArray){
        _joinModelArray = [[NSMutableArray<VMCardListCellModel *> alloc] init];
    }
    return _joinModelArray;
}

-(VMUserTopBarView *)topBarView{
    if(!_topBarView){
        _topBarView = [[VMUserTopBarView alloc] initWithState:self.state];
        [_topBarView.collectionButton addAction:[UIAction actionWithHandler:^(__kindof UIAction * _Nonnull action) {
            [self switchCardList:VMUserTopBarCollection];
        }] forControlEvents:UIControlEventTouchUpInside];
        [_topBarView.createdButton addAction:[UIAction actionWithHandler:^(__kindof UIAction * _Nonnull action) {
            [self switchCardList:VMUserTopBarCreated];
        }] forControlEvents:UIControlEventTouchUpInside];
        [_topBarView.joinedButton addAction:[UIAction actionWithHandler:^(__kindof UIAction * _Nonnull action) {
            [self switchCardList:VMUserTopBarJoined];
        }] forControlEvents:UIControlEventTouchUpInside];
    }
    return _topBarView;
}


@end
