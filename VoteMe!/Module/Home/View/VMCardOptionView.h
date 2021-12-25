//
//  VMCardOptionView.h
//  VoteMe!
//
//  Created by 李浩宇 on 2021/11/28.
//

#import "VMBaseView.h"

NS_ASSUME_NONNULL_BEGIN

@interface VMCardOptionView : VMBaseView

@property(nonatomic, strong) UILabel *declareLabel;

@property(nonatomic, strong) UIImageView *havePictureImageView;

@property(nonatomic, assign) bool haveImage;

@property(nonatomic, strong) UIImage *image;

-(instancetype)initWithContent:(NSString *)content havePicture:(BOOL)pictureFlag;

@end

NS_ASSUME_NONNULL_END
