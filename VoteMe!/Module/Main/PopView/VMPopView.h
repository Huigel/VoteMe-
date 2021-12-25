//
//  VMPopView.h
//  VoteMe!
//
//  Created by 李浩宇 on 2021/12/13.
//

#import "VMBaseView.h"

typedef NS_ENUM(NSInteger, VMPopViewType){
    VMPopType0 //点击灰色蒙版与左按钮都会关闭弹窗
};

NS_ASSUME_NONNULL_BEGIN

@interface VMPopView : VMBaseView

@property(nonatomic, strong) UIButton *maskButton;

@property(nonatomic, strong) UIView *containerView;

@property(nonatomic, strong) UIImageView *imageView;

@property(nonatomic, strong) UILabel *titleLabel;

@property(nonatomic, strong) UILabel *contentLabel;

@property(nonatomic, strong) UIButton *leftButton;

@property(nonatomic, strong) UIButton *rightButton;

@property(nonatomic, assign) VMPopViewType type;

-(instancetype)initWithType:(VMPopViewType)type title:(NSString *)titleText content:(NSString *)contentText leftText:(NSString *)leftText rightText:(NSString *)rightText;

@end

NS_ASSUME_NONNULL_END
