//
//  EmotionPackage.m
//  RichText
//
//  Created by Tesiro on 16/10/8.
//  Copyright © 2016年 Tesiro. All rights reserved.
//

#import "EmotionPackage.h"
#import "Emoticon.h"

@implementation EmotionPackage


- (instancetype)initWithID:(NSString *)ids{
    if (self = [super init]) {
        _emoticons = [NSMutableArray arrayWithCapacity:0];
        if ([ids isEqualToString:@""]) {
            [self addEmptyEmoticon:YES];
            return self;
        }
        NSString *plistPath = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@/info.plist",ids] ofType:nil inDirectory:@"Emoticons.bundle"];
        NSArray *array = [NSArray arrayWithContentsOfFile:plistPath];
        //遍历数组
        int index = 0;
        for (NSMutableDictionary *dict in array) {
            if (dict[@"png"]) {
                 dict[@"png"] = [NSString stringWithFormat:@"%@/%@",ids,dict[@"png"]];
            }
            [_emoticons addObject:[[Emoticon alloc] initWithDict:dict]];
            index++;
            if (index == 20) {
                [_emoticons addObject:[[Emoticon alloc] initWithIsRemove:YES]];
                index =0;
            }
            
        }
        
        //5添加空白表情
        NSInteger count = _emoticons.count % 21;
        if (count ==0) {
            return self;
        }
        for (NSInteger i=count; i<20; i++) {
            [_emoticons addObject:[[Emoticon alloc] initWithEmpty:YES]];
        }
        [_emoticons addObject:[[Emoticon alloc] initWithIsRemove:YES]];
        
    }
    return self;
}

- (void)addEmptyEmoticon:(BOOL)isRecently{
    NSInteger count = _emoticons.count % 21;
    if (count == 0 && !isRecently) {
        return;
    }
    
    for (NSInteger i = count; i<20; i++) {
        [_emoticons addObject:[[Emoticon alloc] initWithEmpty:YES]];
    }
    [_emoticons addObject:[[Emoticon alloc] initWithIsRemove:YES]];
}
@end
