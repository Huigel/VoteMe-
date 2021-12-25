//
//  UIView+Shadow.m
//  VoteMe!
//
//  Created by 李浩宇 on 2021/12/4.
//

#import "UIView+Shadow.h"

@implementation  UIView (Shadow)

+(void)configureShadow:(UIView *)view{
    view.layer.shadowColor = [UIColor grayColor].CGColor;
    view.layer.shadowOffset = CGSizeMake(0 * WIDTH_SCALE, 2 * HEIGHT_SCALE);
    view.layer.shadowOpacity = 0.4;
    view.layer.shadowRadius = 3 * WIDTH_SCALE;
}

@end
