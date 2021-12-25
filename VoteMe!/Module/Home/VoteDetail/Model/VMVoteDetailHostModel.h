//
//  VMVoteDetailHostModel.h
//  VoteMe!
//
//  Created by 李浩宇 on 2021/12/4.
//

#import "VMBaseModel.h"
#import "VMCardListOptionModel.h"
#import "VMCardListOptionModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface VMVoteDetailHostModel : VMBaseModel

@property(nonatomic, assign) NSInteger vote_id;

@property(nonatomic, copy) NSString *title;

@property(nonatomic, copy) NSString *content;

@property(nonatomic, copy) NSString *username;

@property(nonatomic, assign) NSInteger total;

@property(nonatomic, copy) NSString *end_time;

@property(nonatomic, copy) NSString *img;

@property(nonatomic, assign) NSInteger star;

@property(nonatomic, assign) NSInteger status;

@property(nonatomic, assign) BOOL is_owner;

@property(nonatomic, assign) BOOL has_involved;

@property(nonatomic, strong) NSMutableArray<VMCardListOptionModel *> *options;

@end

NS_ASSUME_NONNULL_END
