//
//  FindEmoticon.m
//  RichText
//
//  Created by Tesiro on 16/10/8.
//  Copyright © 2016年 Tesiro. All rights reserved.
//

#import "FindEmoticon.h"
#import "EmotionPackage.h"
#import "Emoticon.h"

@implementation FindEmoticon
+ (FindEmoticon *) shareInstance {
    static dispatch_once_t onceToken;
    static FindEmoticon *findEmoticon;
    dispatch_once(&onceToken, ^{
        findEmoticon  = [[FindEmoticon alloc] init];
    });
    
    return findEmoticon;
}

-(NSMutableAttributedString*)findATTriString:(NSString*)statusText font:(UIFont*)font{
    //创建拼配的规则
    NSString *pattern = @"\\[.*?\\]";
    //2创建正则表达式的对象
   NSRegularExpression*regex= [[NSRegularExpression alloc] initWithPattern:pattern options:nil error:
                               nil];
    
        //开始匹配
  
        NSArray *results=[regex matchesInString:statusText options:nil range:NSMakeRange(0, statusText.length)];
        //获取结果
        NSMutableAttributedString *attrMstr = [[NSMutableAttributedString alloc] initWithString:statusText];
        for (int i =results.count - 1; i>=0; i--) {
            NSTextCheckingResult* result =results[i];
            NSString *chs=[statusText substringWithRange:result.range];
            NSString *pngPath = [self findPngPath:chs];
            if (pngPath) {
                NSTextAttachment*attachMent = [[NSTextAttachment alloc] init];
                attachMent.image = [UIImage imageWithContentsOfFile:pngPath];
                UIFont *font1 = font;
                attachMent.bounds = CGRectMake(0, -4, font1.lineHeight, font1.lineHeight);
                NSAttributedString *attrImageStr = [NSAttributedString attributedStringWithAttachment:attachMent];
                [attrMstr replaceCharactersInRange:result.range withAttributedString:attrImageStr];
            }
        }
        return attrMstr;
    
    
}

-(NSString *)findPngPath:(NSString*)chs{
    self.manager = [[emotionManager alloc] init];
    for (EmotionPackage *package in self.manager.packages) {
        for (Emoticon *emoticon in package.emoticons) {
            if ([emoticon.chs isEqualToString:chs]) {
                return emoticon.pngPath;
            }
        }
    }
    return nil;
}

@end
