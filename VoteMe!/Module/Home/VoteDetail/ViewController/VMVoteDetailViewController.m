//
//  VoteDetailViewController.m
//  VoteMe!
//
//  Created by 李浩宇 on 2021/11/27.
//

#import "VMVoteDetailViewController.h"
#import "VMMainViewController.h"

static NSString *const voteOwnerCellIdentifier  = @"voteOwnerCellIdentifier";
static NSString *const commentCellIdentifier  = @"commentCellIdentifier";

@interface VMVoteDetailViewController ()

@end

@implementation VMVoteDetailViewController

-(instancetype)initWithHostModel:(VMCardListCellModel *)model{
    self = [super init];
    
    //self.hostModel = model;
    self.hostModel.vote_id = model.vote_id;
    self.hostModel.title = model.title;
    self.hostModel.content = model.content;
    self.hostModel.total = model.total;
    self.hostModel.end_time = model.end_time;
    self.hostModel.star = model.star;
    self.hostModel.status = model.status;
    self.hostModel.username = model.username;
    self.hostModel.options = model.options;
    self.hostModel.is_owner = model.is_owner;
    self.hostModel.has_involved = model.has_involved;
    self.hostModel.img = model.img;
    
    if(self.hostModel.is_owner || self.hostModel.has_involved){
        self.couldVote = false;
    }else{
        self.couldVote = true;
    }
    
    [VMWebManager shareInstance].delegate = self;
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationBarView.backBtn.hidden = false;
    self.navigationBarView.hidden = false;
    self.navigationBarView.moreButton.hidden = false;
    
    [self.navigationBarView.moreButton addTarget:self action:@selector(showActionSheet) forControlEvents:UIControlEventTouchUpInside];
    
    [self updateCommentPullDown];
    //[self updateVoteWith:self.hostModel.vote_id];
    
    [[VMWebManager shareInstance] favoriteCheckWithVoteID:self.hostModel.vote_id];
    
    [self configureHierachy];
}

-(void)viewWillAppear:(BOOL)animated{
    
    self.commentView.replyTo = self.hostModel.vote_id;
    
    [self.tableView reloadData];
    [super viewWillAppear:animated];
}


-(void)configureHierachy{
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.navigationBarView.mas_bottom);
    }];
    
    [self.view addSubview:self.commentView];
    [self.commentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(self.tableView.mas_bottom);
    }];
    
    
}

-(void)back{
    [self.navigationController popViewControllerAnimated:TRUE];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.commentModelArray.count + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        
        VMVoteDetailHostCell *cell = [[VMVoteDetailHostCell alloc] initWithCouldVoteFlag:self.couldVote];
        [VMCellConfigure configDetailHostCell:cell withModel:self.hostModel couldVote:self.couldVote];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.OptionDelectDelegate = self;

        self.hostCell = cell;
        
        [cell.submitButton addTarget:self action:@selector(vote) forControlEvents:UIControlEventTouchUpInside];
        
        return cell;
    }else{
        
        VMVoteDetailCommentCell *cell = [[VMVoteDetailCommentCell alloc] init];
        [VMCellConfigure configDetailCommentCell:cell withModel:self.commentModelArray[indexPath.row - 1]];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:true];
    
    if(indexPath.row > 0){
        
        VMCommentDetailController *vc = [[VMCommentDetailController alloc] initWithHostModel:self.commentModelArray[indexPath.row - 1]];
        
        [self.navigationController pushViewController:vc animated:false];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
//    CGFloat test = UITableViewAutomaticDimension;
//    return test;
    return UITableViewAutomaticDimension;
  //  return 450 * HEIGHT_SCALE;
}

//- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForHeaderInSection:(NSInteger)section{
//    return 500;
//}

#pragma mark - SEL
-(void)updateCommentPullDown{
    [self updateCommentWithFlag:VMRefresh];
    [self updateVoteWith:self.hostModel.vote_id];
}

-(void)updateCommentDragUp{
    [self updateCommentWithFlag:VMLoadMore];
    [self updateVoteWith:self.hostModel.vote_id];
}


-(void)updateCommentWithFlag:(VMResponseFlag)flag{
    [VMWebManager shareInstance].delegate = self;
    
    if(flag == VMRefresh){
        //[[HHWebmanager shareInstance] getHoleWith:0 list_size:15 addFlag:flag is_last_reply:self.orderView.order == HHHoleShowOrderCommentFirst ? true : false];
        NSString *orderBy = @"created_at";
        [VMWebManager shareInstance].delegate = self;
        [[VMWebManager shareInstance] getCommentWithVoteID:self.hostModel.vote_id Offset:0 Limit:15 OrderBy:orderBy flag:VMRefresh];
        
        //[[VMWebManager shareInstance] getVoteListWithOffset:0 Limit:15 Status:(self.orderSelectBarView.orderState == VMOrderedCompleted ? 1 : 0) OrderBy:orderBy flag:(VMResponseFlag)VMRefresh];
        
    }else{

        //[[HHWebmanager shareInstance] getHoleWith:self.holesArray.count list_size:15 addFlag:flag is_last_reply:self.orderView.order == HHHoleShowOrderCommentFirst ? true : false];
        NSString *orderBy = @"created_at";
        [VMWebManager shareInstance].delegate = self;
        [[VMWebManager shareInstance] getCommentWithVoteID:self.hostModel.vote_id Offset:self.commentModelArray.count Limit:15 OrderBy:orderBy flag:VMLoadMore];
        //[[VMWebManager shareInstance] getVoteListWithOffset:self.CardModelArray.count Limit:15 Status:(self.orderSelectBarView.orderState == VMOrderedCompleted ? 1 : 0) OrderBy:orderBy flag:(VMResponseFlag)VMLoadMore];
    }
}

-(void)updateVoteWith:(NSInteger)voteID{
    [VMWebManager shareInstance].delegate = self;
    [[VMWebManager shareInstance] getSingleVoteWithVoteID:self.hostModel.vote_id];
}


-(void)vote{
    
    [VMWebManager shareInstance].delegate = self;
    [[VMWebManager shareInstance] voteWithVoteID:self.hostModel.vote_id optionID:[self.hostModel.options[self.selectedOptionIndex] valueForKey:@"option_id"]];
    
}

-(void)showActionSheet{
    
    [self.view addSubview:self.actionSheet];
    
    [self.actionSheet mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [self.view bringSubviewToFront:self.actionSheet];
    
}

-(void)changeFavoriteState{
    [VMWebManager shareInstance].delegate = self;
    if(self.onFavorite){
        [[VMWebManager shareInstance] favoriteDeleteWithVoteID:self.hostModel.vote_id];
    }else{
        [[VMWebManager shareInstance] favoriteAddWithVoteID:self.hostModel.vote_id];
    }
}

-(void)deleteVote{
    
    VMPopView *popView = [[VMPopView alloc] initWithType:VMPopType0 title:@"删除不？" content:@"你到底删不删" leftText:@"不删除" rightText:@"删除"];

    [popView.rightButton addAction:[UIAction actionWithHandler:^(__kindof UIAction * _Nonnull action) {
        [VMWebManager shareInstance].delegate = self;
        [[VMWebManager shareInstance] deleteVoteWithVoteID:self.hostModel.vote_id];
    }]forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:popView];
    [popView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [self.view bringSubviewToFront:popView];
}

#pragma mark - 代理

-(void)switchSelectWithIndex:(NSInteger)index{
    
    if(!self.couldVote){
        return;
    }
    for(NSInteger i = 0; i < self.hostCell.optionArray.count; i++){
        if(i == index){
            self.hostCell.optionArray[index].backgroundView.backgroundColor = [UIColor colorWithHexString:kVMOptionSelectedColor];
        }else{
            self.hostCell.optionArray[i].backgroundView.backgroundColor = [UIColor colorWithHexString:kVMOptionUnselectedColor];
        }
    }
    self.selectedOptionIndex = index;
    
}

#pragma mark - 网络请求回调

-(void)handleSingleVoteDetailWithResponse:(_Nullable id)response flag:(VMResponseFlag)flag{
    
    if(flag != VMFailed && [[response valueForKey:@"msg"] isEqualToString:@"查询无结果"]){
        [self.navigationController popViewControllerAnimated:TRUE];
        [[VMMainViewController sharedInstance].view makeToast:@"该投票不存在" duration:1 position:CSToastPositionCenter];
    }
    
    self.hostModel = [VMVoteDetailHostModel yy_modelWithDictionary:[response valueForKey:@"vote"]];
    
    if(self.hostModel.is_owner || self.hostModel.has_involved){
        self.couldVote = false;
    }
    
    [self.tableView reloadData];
}

-(void)handleCommentListForVoteWithResponse:(_Nullable id)response flag:(VMResponseFlag)flag{
    
    if(flag != VMFailed && [response isKindOfClass:[NSDictionary class]] && [[response valueForKey:@"Code"] isEqualToString:@"42102"]){
        if(self.tableView.mj_header.isRefreshing) [self.tableView.mj_header endRefreshing];
        if(self.tableView.mj_footer.isRefreshing) [self.tableView.mj_footer endRefreshing];
        return;
    }
    
    if(flag == VMRefresh){
        self.commentModelArray = [[NSMutableArray alloc] init];
        [self.commentModelArray removeAllObjects];
        [self.tableView.mj_header endRefreshing];
    }else if(flag == VMLoadMore){
        [self.tableView.mj_footer endRefreshing];
    }else if(flag == VMFailed){
        if(self.tableView.mj_header.isRefreshing) [self.tableView.mj_header endRefreshing];
        if(self.tableView.mj_footer.isRefreshing) [self.tableView.mj_footer endRefreshing];
        //[[UIWindow getRootWindow].rootViewController.view makeToast:@"请检查您的网络连接"];
        return ;
    }
    for (NSDictionary *dict in (NSArray *) response) {
        VMVoteDetailCommentModel *model = [VMVoteDetailCommentModel yy_modelWithDictionary:dict];
        [self.commentModelArray addObject:model];
    }
    [self.tableView reloadData];
}

-(void)handleVoteWithResponse:(id)response success:(BOOL)success{
    if(success && [[response valueForKey:@"Msg"] isEqualToString:@"投票成功"]){
        [[[VMViewControllerManager sharedInstance] getNowViewController].view makeToast:@"投票成功" duration:1 position:CSToastPositionCenter];
    }else{
        [[[VMViewControllerManager sharedInstance] getNowViewController].view makeToast:@"投票失败" duration:1 position:CSToastPositionCenter];
    }
    
    [self updateVoteWith:self.hostModel.vote_id];
}

-(void)handlePostCommentWithResponse:(_Nullable id)response success:(BOOL)success{
    self.commentView.sendButton.userInteractionEnabled = YES;
    [self.commentView.uploadingView removeFromSuperview];
    if(success){
        [self.commentView resetInputTextField];
        [[[VMViewControllerManager sharedInstance] getNowViewController].view makeToast:@"评论成功" duration:1 position:CSToastPositionCenter];
        
        [self updateCommentPullDown];
    }else{
        [[[VMViewControllerManager sharedInstance] getNowViewController].view makeToast:@"评论失败" duration:1 position:CSToastPositionCenter];
    }
}

-(void)handleFavotiteAddWithResponse:(_Nullable id)response success:(BOOL)success{
    if(success && [[response valueForKey:@"Msg"] isEqualToString:@"收藏成功"]){
        self.onFavorite = true;
        self.actionSheet.favoriteButton.itemImageView.image = [UIImage imageNamed:@"StarItem"];
    }else{
        self.onFavorite = false;
    }
}

-(void)handleFavotiteCheckWithResponse:(_Nullable id)response success:(BOOL)success{
    if(success && [[response valueForKey:@"Msg"] isEqualToString:@"已收藏"]){
        self.onFavorite = true;
        self.actionSheet.favoriteButton.itemImageView.image = [UIImage imageNamed:@"StarItem"];
    }else{
        self.onFavorite = false;
        self.actionSheet.favoriteButton.itemImageView.image = [UIImage imageNamed:@"UnstarItem"];
    }
}

-(void)handleFavotiteDeleteWithResponse:(_Nullable id)response success:(BOOL)success{
    if(success && [[response valueForKey:@"Msg"] isEqualToString:@"删除收藏成功"]){
        self.onFavorite = false;
        self.actionSheet.favoriteButton.itemImageView.image = [UIImage imageNamed:@"UnstarItem"];
    }else{
        self.onFavorite = true;
    }
}


-(void)handleVoteDeleteWithResponse:(_Nullable id)response success:(BOOL)success{
    if(success && [[response valueForKey:@"Msg"] isEqualToString:@"删除成功"]){
        [self.navigationController popViewControllerAnimated:TRUE];
        [[VMMainViewController sharedInstance].view makeToast:@"删除成功" duration:1 position:CSToastPositionCenter];
    }else{
        [self.view makeToast:@"删除失败" duration:1 position:CSToastPositionCenter];
    }
}

-(void)handlePictureTokenWith:(id)response success:(BOOL)success{
    if(success){
        if([response objectForKey:@"token"]){
            
            NSString *token = [response valueForKey:@"token"];
            
            [VMPictureUploadManager shareInstance].delegate = self;
            [[VMPictureUploadManager shareInstance] resetPictureToken:token];
            [[VMPictureUploadManager shareInstance] uploadSinglePictureWithImage:self.commentView.image];
            
        }else{
            
        }
    }else{
        
    }
}

#pragma mark - 图片发送回调
-(void)handleSinglePictureUploadWith:(_Nullable id)response success:(BOOL)success{
    if(success){
        if([response objectForKey:@"key"]){
            NSString *imageUrl = [NSString stringWithFormat:@"r43nngl92.hd-bkt.clouddn.com/%@",[response valueForKey:@"key"]];
            
            [VMWebManager shareInstance].delegate = self;
            [[VMWebManager shareInstance] postCommentFor:(self.commentView.nowMode == VMCommentModeForVote ? true : false) WithID:self.commentView.replyTo Content:self.commentView.inputTextView.text Imgurl:imageUrl];
            
        }
    }
}

#pragma mark - lazy load

-(UITableView *)tableView{
    if(!_tableView){
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
        [_tableView registerClass:VMVoteDetailHostCell.class  forCellReuseIdentifier:voteOwnerCellIdentifier];
        [_tableView registerClass:VMVoteDetailCommentCell.class forCellReuseIdentifier:commentCellIdentifier];
        
        _tableView.backgroundColor = [UIColor colorWithHexString:kVMBackgroundColor];
        _tableView.mj_header = [MJRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(updateCommentPullDown)];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        //_tableView.estimatedRowHeight = 300;
        //_tableView.rowHeight = UITableViewAutomaticDimension;
        _tableView.mj_footer = [MJRefreshBackFooter footerWithRefreshingTarget:self refreshingAction:@selector(updateCommentDragUp)];
    }
    return _tableView;
}

-(VMCommentorView *)commentView{
    if(!_commentView){
        _commentView = [[VMCommentorView alloc] initWithMode:VMCommentModeForVote replyTo:-1];
    }
    return _commentView;
}

-(VMVoteDetailHostModel *)hostModel{
    if(!_hostModel){
        _hostModel = [[VMVoteDetailHostModel alloc] init];
        
    }
    return _hostModel;
}

-(NSMutableArray<VMVoteDetailCommentModel *> *)commentModelArray{
    if(!_commentModelArray){
        _commentModelArray = [[NSMutableArray<VMVoteDetailCommentModel *> alloc] init];
    }
    return _commentModelArray;
}

//-(VMVoteDetailHostCell *)hostCell{
//    if(!_hostCell){
//        _hostCell = [[VMVoteDetailHostCell alloc] init];
//    }
//    return _hostCell;
//}

-(VMActionSheetView *)actionSheet{
    if(!_actionSheet){
        _actionSheet = [[VMActionSheetView alloc] init];
        
        [_actionSheet.itemArray addObject:_actionSheet.favoriteButton];
        [_actionSheet.favoriteButton addTarget:self action:@selector(changeFavoriteState) forControlEvents:UIControlEventTouchUpInside];
        
        if(self.hostModel.is_owner){
            [_actionSheet.itemArray addObject:_actionSheet.deleteButton];
            [_actionSheet.deleteButton addTarget:self action:@selector(deleteVote) forControlEvents:UIControlEventTouchUpInside];
        }
        
        [_actionSheet configureHierachy];
    }
    return _actionSheet;
}

-(VMLoadingView *)uploadingView{
    if(!_uploadingView){
        _uploadingView = [[VMLoadingView alloc] init];
    }
    return _uploadingView;
}

@end
