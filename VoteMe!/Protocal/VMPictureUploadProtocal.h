//
//  VMPictureUploadProtocal.h
//  VoteMe!
//
//  Created by 李浩宇 on 2021/12/22.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol VMPictureUploadProtocal <NSObject>


-(void)handleSinglePictureUploadWith:(_Nullable id)response success:(BOOL)success;

-(void)handlePictureUploadWith:(_Nullable id)response index:(NSInteger)index success:(BOOL)success;

@end

NS_ASSUME_NONNULL_END
