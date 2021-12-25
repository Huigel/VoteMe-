//
//  VMRankBoardCellModel.h
//  VoteMe!
//
//  Created by 李浩宇 on 2021/11/28.
//

#import "VMBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface VMRankBoardCellModel : VMBaseModel

//@property(nonatomic, assign) NSInteger rank;

@property(nonatomic, assign) NSInteger score;

@property(nonatomic, copy) NSString *name;

@end

NS_ASSUME_NONNULL_END
