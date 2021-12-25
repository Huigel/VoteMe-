//
//  VMCommentDetailController.m
//  VoteMe!
//
//  Created by 李浩宇 on 2021/12/6.
//

#import "VMCommentDetailController.h"

static NSString *const commentHostCellIdentifier  = @"commentHostCellIdentifier";
static NSString *const commentFollowCellIdentifier  = @"commentFollowCellIdentifier";

@interface VMCommentDetailController ()

@end

@implementation VMCommentDetailController

-(instancetype)initWithHostModel:(VMVoteDetailCommentModel *)model{
    self = [super init];
    
    self.hostModel = model;
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationBarView.backBtn.hidden = false;
    self.navigationBarView.hidden = false;
    [self updateCommentPullDown];
    
//    VMVoteDetailCommentModel *testModel = [[VMVoteDetailCommentModel alloc] init];
//    testModel.name = @"王司徒";
//    testModel.content = @"我从未见过有如此厚颜无耻之人";
//    [self.modelArray addObject:testModel];
//    [self.modelArray addObject:testModel];
//    [self.modelArray addObject:testModel];
//    [self.modelArray addObject:testModel];
//
//    [self.tableView reloadData];
    
    
    [self configureHierachy];
    
}

-(void)viewWillAppear:(BOOL)animated{
    
    [self.tableView reloadData];
    [super viewWillAppear:animated];
}

-(void)configureHierachy{
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.navigationBarView.mas_bottom);
    }];
    
    [self.view addSubview:self.commentorView];
    [self.commentorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(self.tableView.mas_bottom);
    }];
}

-(void)back{
    [self.navigationController popViewControllerAnimated:TRUE];
}

#pragma mark - UITableView Delegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    //return (self.commentModelArray.count + 1);
    return self.modelArray.count + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        
        self.hostCell = [[VMCommentHostCell alloc] init];

        [VMCellConfigure configCommentDetailHostCell:self.hostCell withModel:self.hostModel];
        
        self.hostCell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
        return self.hostCell;
    }else{
        
        VMCommentCell *cell = [[VMCommentCell alloc] init];
        [VMCellConfigure configCommentDetailfollowCell:cell withModel:self.modelArray[indexPath.row - 1]];
        
        if(indexPath.row == 1){
            cell.separaterLine.hidden = true;
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:true];
    
    if(indexPath.row == 0){
        self.commentorView.replyToName = @"";
    }else{
        self.commentorView.replyToName = self.modelArray[indexPath.row - 1].name;
    }
    
    //self.commentorView.replyTo = self.modelArray[indexPath.row - 1].remark_id;
    //这里不能改replyTo，因为后端返回评论列表是指返回对指定回复的回复列表，因此这个页面里只有对host的回复。如果把replyTo改为点击的评论，那么发出的评论将无法在这个页面里显示，除非对此页面每一条评论单独拉取，但那样就会过于麻烦了。
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
    //return 300 * HEIGHT_SCALE;
}

#pragma mark - SEL
-(void)updateCommentPullDown{
    [self updateCommentWithFlag:VMRefresh];
}

-(void)updateCommentDragUp{
    [self updateCommentWithFlag:VMLoadMore];
}

-(void)updateCommentWithFlag:(VMResponseFlag)flag{
    [VMWebManager shareInstance].delegate = self;
    
    if(flag == VMRefresh){

        NSString *orderBy = @"created_at";
        [VMWebManager shareInstance].delegate = self;
        [[VMWebManager shareInstance] getCommentWithCommentID:self.hostModel.remark_id Offset:0 Limit:15 OrderBy:orderBy flag:VMRefresh];
        
    }else{

        NSString *orderBy = @"created_at";
        [VMWebManager shareInstance].delegate = self;
        [[VMWebManager shareInstance] getCommentWithCommentID:self.hostModel.remark_id Offset:self.modelArray.count Limit:15 OrderBy:orderBy flag:VMLoadMore];
    }
}

#pragma mark - 网络请求回调

-(void)handleCommentListForVoteWithResponse:(_Nullable id)response flag:(VMResponseFlag)flag{
    if(flag == VMRefresh){
        //self.modelArray = [[NSMutableArray alloc] init];
        [self.modelArray removeAllObjects];
        [self.tableView.mj_header endRefreshing];
    }else if(flag == VMLoadMore){
        [self.tableView.mj_footer endRefreshing];
    }else{
        if(self.tableView.mj_header.isRefreshing) [self.tableView.mj_header endRefreshing];
        if(self.tableView.mj_footer.isRefreshing) [self.tableView.mj_footer endRefreshing];
        //[[UIWindow getRootWindow].rootViewController.view makeToast:@"请检查您的网络连接"];
        return ;
    }
    for (NSDictionary *dict in (NSArray *) response) {
        VMVoteDetailCommentModel *model = [VMVoteDetailCommentModel yy_modelWithDictionary:dict];
        [self.modelArray addObject:model];
    }
    
    
    [self.tableView reloadData];
}

-(void)handlePostCommentWithResponse:(_Nullable id)response success:(BOOL)success{
    self.commentorView.sendButton.userInteractionEnabled = YES;
    [self.commentorView.uploadingView removeFromSuperview];
    if(success){
        if([[response valueForKey:@"Code"] isEqualToString:@"42000"]){
            [self.commentorView resetInputTextField];
            
            [self.view makeToast:@"评论成功" duration:1 position:CSToastPositionCenter];
            [self.commentorView resetInputTextField];
            
            [self updateCommentPullDown];
        }else{
            [self.view makeToast:[response valueForKey:@"Msg"] duration:1 position:CSToastPositionCenter];
        }
    }else{
        [self.view makeToast:@"评论失败，网络异常" duration:1 position:CSToastPositionCenter];
    }
}

#pragma mark - lazy load
-(UITableView *)tableView{
    if(!_tableView){
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
        [_tableView registerClass:VMCommentHostCell.class forCellReuseIdentifier:commentHostCellIdentifier];
        [_tableView registerClass:VMCommentCell.class forCellReuseIdentifier:commentFollowCellIdentifier];
        
        _tableView.backgroundColor = [UIColor colorWithHexString:kVMBackgroundColor];
        _tableView.mj_header = [MJRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(updateCommentPullDown)];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        //_tableView.estimatedRowHeight = 300;
        //_tableView.rowHeight = UITableViewAutomaticDimension;
        _tableView.mj_footer = [MJRefreshBackFooter footerWithRefreshingTarget:self refreshingAction:@selector(updateCommentDragUp)];
    }
    return _tableView;
}

-(VMCommentorView *)commentorView{
    if(!_commentorView){
        _commentorView = [[VMCommentorView alloc] initWithMode:VMCommentModeForComment replyTo:self.hostModel.remark_id];
    }
    return _commentorView;
}

-(NSMutableArray<VMVoteDetailCommentModel *> *)modelArray{
    if(!_modelArray){
        _modelArray = [[NSMutableArray<VMVoteDetailCommentModel *> alloc] init];
    }
    return _modelArray;
}



@end
