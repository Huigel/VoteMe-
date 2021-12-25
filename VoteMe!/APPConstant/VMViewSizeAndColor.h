//
//  CIVIewSizeAndColor.h
//  VoteMe!
//
//  Created by 李浩宇 on 2021/11/21.
//

#import <Foundation/Foundation.h>
#import "VMBaseView.h"

#define WIDTH_SCALE UIScreen.mainScreen.bounds.size.width / 375
#define HEIGHT_SCALE UIScreen.mainScreen.bounds.size.height / 812

NS_ASSUME_NONNULL_BEGIN

static NSString *const kVMBackgroundColor                = @"#FBFCFE";

static NSString *const kVMButtonSelectedColor            = @"#081C34";

static NSString *const kVMButtonUnselectedColor          = @"#A7B0B5";

static NSString *const kVMOptionSelectedColor            = @"#A6B9FF";

static NSString *const kVMOptionUnselectedColor          = @"#FFFFFF";

@interface VMViewSizeAndColor : NSObject



@end

NS_ASSUME_NONNULL_END
