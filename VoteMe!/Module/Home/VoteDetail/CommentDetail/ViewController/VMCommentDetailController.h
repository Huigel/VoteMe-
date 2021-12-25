//
//  VMCommentDetailController.h
//  VoteMe!
//
//  Created by 李浩宇 on 2021/12/6.
//

#import "VMBaseViewController.h"
#import "VMCommentorView.h"
#import "VMCommentHostCell.h"
#import "VMCommentCell.h"
#import "VMVoteDetailCommentModel.h"
#import <MJRefresh.h>
#import "VMCellConfigure.h"

NS_ASSUME_NONNULL_BEGIN

@interface VMCommentDetailController : VMBaseViewController

@property(nonatomic, strong) VMCommentorView *commentorView;

@property(nonatomic, strong) UITableView *tableView;

@property(nonatomic, strong) VMCommentHostCell *hostCell;

@property(nonatomic, strong) NSMutableArray<VMCommentCell *> *commentCellArray;

@property(nonatomic, strong) VMVoteDetailCommentModel *hostModel;

@property(nonatomic, strong) NSMutableArray<VMVoteDetailCommentModel *> *modelArray;

-(instancetype)initWithHostModel:(VMVoteDetailCommentModel *)model;

@end

NS_ASSUME_NONNULL_END
