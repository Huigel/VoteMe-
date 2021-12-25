//
//  VoteDetailViewController.h
//  VoteMe!
//
//  Created by 李浩宇 on 2021/11/27.
//

#import "VMBaseViewController.h"
#import "VMVoteDetailHostCell.h"
#import "VMVoteDetailCommentCell.h"
#import "VMVoteDetailOptionView.h"
#import "VMCommentorView.h"
#import "VMVoteDetailHostModel.h"
#import "VMVoteDetailCommentModel.h"
#import "VMCellConfigure.h"
#import "VMCommentDetailController.h"
#import <MJRefresh.h>
#import "VMOptionSelectedProtocol.h"
#import "VMActionSheetView.h"


NS_ASSUME_NONNULL_BEGIN

@interface VMVoteDetailViewController : VMBaseViewController<UITableViewDelegate, UITableViewDataSource, VMOptionSelectedProtocol>

@property(nonatomic, strong) UITableView *tableView;

@property(nonatomic, strong) VMVoteDetailHostModel *hostModel;

@property(nonatomic, strong) VMVoteDetailHostCell *hostCell;

@property(nonatomic, strong) NSMutableArray<VMVoteDetailCommentModel *> *commentModelArray;

@property(nonatomic, strong) VMCommentorView *commentView;

@property(nonatomic, assign) NSInteger selectedOptionIndex;

@property(nonatomic, strong) VMActionSheetView *actionSheet;

@property(nonatomic, strong) VMLoadingView *uploadingView;

@property(nonatomic, assign) bool onFavorite;

@property(nonatomic, assign) BOOL couldVote;

-(instancetype)initWithHostModel:(VMCardListCellModel *)model;

@end

NS_ASSUME_NONNULL_END
