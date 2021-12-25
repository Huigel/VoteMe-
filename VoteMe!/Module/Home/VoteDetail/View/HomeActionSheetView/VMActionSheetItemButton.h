//
//  VMActionSheetItemButton.h
//  VoteMe!
//
//  Created by 李浩宇 on 2021/12/13.
//

#import <UIKit/UIKit.h>
#import "VMViewSizeAndColor.h"

NS_ASSUME_NONNULL_BEGIN

@interface VMActionSheetItemButton : UIButton

@property(nonatomic, strong) UIImageView *itemImageView;

@property(nonatomic, strong) UILabel *itemLabel;

-(instancetype)initWithImage:(UIImage *)image Text:(NSString *)text;

@end

NS_ASSUME_NONNULL_END
