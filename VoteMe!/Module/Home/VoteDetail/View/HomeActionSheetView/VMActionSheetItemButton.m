//
//  VMActionSheetItemButton.m
//  VoteMe!
//
//  Created by 李浩宇 on 2021/12/13.
//

#import "VMActionSheetItemButton.h"

@implementation VMActionSheetItemButton

-(instancetype)initWithImage:(UIImage *)image Text:(NSString *)text{
    self = [super init];
    
    self.itemImageView.image = image;
    self.itemLabel.text = text;
    
    [self addSubview:self.itemImageView];
    [self.itemImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.top.equalTo(self);
        make.width.mas_equalTo(21 *WIDTH_SCALE);
        make.height.mas_equalTo(21 * HEIGHT_SCALE);
    }];
    
    [self addSubview:self.itemLabel];
    [self.itemLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.itemImageView.mas_bottom).with.offset(5 * HEIGHT_SCALE);
        make.height.mas_equalTo(14 * HEIGHT_SCALE);
    }];
    
    
    return self;
}

#pragma mark - lazy load

-(UIImageView *)itemImageView{
    if(!_itemImageView){
        _itemImageView = [[UIImageView alloc] init];
    }
    return _itemImageView;
}

-(UILabel *)itemLabel{
    if(!_itemLabel){
        _itemLabel = [[UILabel alloc] init];
        _itemLabel.textColor = [UIColor colorWithHexString:@"#000000"];
        _itemLabel.font = [UIFont systemFontOfSize:8 * WIDTH_SCALE];
        _itemLabel.numberOfLines = 1;
    }
    return _itemLabel;
}

@end
