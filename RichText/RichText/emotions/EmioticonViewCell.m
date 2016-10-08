//
//  EmioticonViewCell.m
//  RichText
//
//  Created by Tesiro on 16/10/8.
//  Copyright © 2016年 Tesiro. All rights reserved.
//

#import "EmioticonViewCell.h"

@implementation EmioticonViewCell
//-(UIButton *)emotionBtn{
//    if (!_emotionBtn) {
//        _emotionBtn= [[UIButton alloc] init];
//    }
//    return _emotionBtn;
//}


-(void)setEmoticon:(Emoticon *)emoticon{
    [_emotionBtn setImage:[UIImage imageWithContentsOfFile:emoticon.pngPath] forState:UIControlStateNormal];
    [_emotionBtn setTitle:emoticon.emojiCode forState:UIControlStateNormal];
    if (emoticon.isRemove) {
        [_emotionBtn setImage:[UIImage imageNamed:@"compose_emotion_delete"] forState:UIControlStateNormal];
    }
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        
    }
    return self;
}

-(void)setupUI{
    _emotionBtn= [UIButton buttonWithType:UIButtonTypeCustom];
    
    [self addSubview:_emotionBtn];
    _emotionBtn.frame = self.bounds;
    _emotionBtn.userInteractionEnabled = NO;
    _emotionBtn.titleLabel.font = [UIFont systemFontOfSize:32];
    
}

@end
