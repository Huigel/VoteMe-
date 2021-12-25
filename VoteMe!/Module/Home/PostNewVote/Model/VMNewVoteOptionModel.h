//
//  VMNewVoteOptionModel.h
//  VoteMe!
//
//  Created by 李浩宇 on 2021/12/8.
//

#import "VMBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface VMNewVoteOptionModel : VMBaseModel

@property(nonatomic, copy) NSString *name;

@property(nonatomic, copy) NSString *img_link;

@property(nonatomic, assign) BOOL havePictureFlag;

-(instancetype)init;

@end 

NS_ASSUME_NONNULL_END
