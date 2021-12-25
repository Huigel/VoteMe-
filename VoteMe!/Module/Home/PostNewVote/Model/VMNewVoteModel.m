//
//  VMNewVoteModel.m
//  VoteMe!
//
//  Created by 李浩宇 on 2021/12/4.
//

#import "VMNewVoteModel.h"

@implementation VMNewVoteModel

-(instancetype)init{
    self = [super init];
    
    
    
    return self;
}


#pragma mark - lazy load

-(NSMutableArray<VMNewVoteOptionModel *> *)options{
    if(!_options){
        _options = [[NSMutableArray<VMNewVoteOptionModel *> alloc] init];
    }
    return _options;
}


@end
