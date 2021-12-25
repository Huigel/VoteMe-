//
//  VMNewVoteModel.h
//  VoteMe!
//
//  Created by 李浩宇 on 2021/12/4.
//

#import "VMBaseModel.h"
#import "VMNewVoteOptionModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface VMNewVoteModel : VMBaseModel

@property(nonatomic, copy) NSString *title;

@property(nonatomic, copy) NSString *content;

@property(nonatomic, copy) NSString *end_time;

@property(nonatomic, copy) NSString *img_link;

@property(nonatomic, assign) BOOL havePictureFlag;

@property(nonatomic, strong) NSMutableArray<VMNewVoteOptionModel *> *options;

-(instancetype)init;

@end

NS_ASSUME_NONNULL_END
