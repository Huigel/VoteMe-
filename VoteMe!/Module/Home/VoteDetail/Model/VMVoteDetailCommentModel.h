//
//  VMVoteDetailCommentModel.h
//  VoteMe!
//
//  Created by 李浩宇 on 2021/12/4.
//

#import "VMBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface VMVoteDetailCommentModel : VMBaseModel

@property(nonatomic, assign) NSInteger user_id;

@property(nonatomic, copy) NSString *name;

@property(nonatomic, assign) NSInteger remark_id;

@property(nonatomic, copy) NSString *content;

@property(nonatomic, copy) NSString *imgurl;

@property(nonatomic, copy) NSString *send_at;

@property(nonatomic, copy) NSMutableArray<VMVoteDetailCommentModel *> *remarks;

@end

NS_ASSUME_NONNULL_END
