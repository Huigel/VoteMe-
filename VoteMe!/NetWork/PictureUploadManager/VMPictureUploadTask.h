//
//  VMPictureUploadTask.h
//  VoteMe!
//
//  Created by 李浩宇 on 2021/12/23.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, VMPicturetaskFlag){
    VMPictureTaskDoing,
    VMPictureTaskSuccessed,
    VMPictureTaskFailure
};

NS_ASSUME_NONNULL_BEGIN

@interface VMPictureUploadTask : NSObject

@property(nonatomic, strong) UIImage *image;

@property(nonatomic, assign) VMPicturetaskFlag uploadState;

@property(nonatomic, copy) NSString *imageUrl;

@property(nonatomic, assign) NSInteger index;

@end

NS_ASSUME_NONNULL_END
