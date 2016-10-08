//
//  emotionManager.m
//  RichText
//
//  Created by Tesiro on 16/10/8.
//  Copyright © 2016年 Tesiro. All rights reserved.
//

#import "emotionManager.h"
#import "EmotionPackage.h"

@implementation emotionManager

-(instancetype)init{
    if (self = [super init]) {
        _packages = [[NSMutableArray alloc] init];
        //添加最近的表情包
        [_packages addObject:[[EmotionPackage alloc] initWithID:@""]];
        //2添加默认的表情包
        [_packages addObject:[[EmotionPackage alloc] initWithID:@"com.sina.default"]];
        //添加emoji表情包
        [_packages addObject:[[EmotionPackage alloc] initWithID:@"com.apple.emoji"]];
        //添加浪小花表情包
        [_packages addObject:[[EmotionPackage alloc] initWithID:@"com.sina.lxh"]];
    }
    return self;
}

@end
