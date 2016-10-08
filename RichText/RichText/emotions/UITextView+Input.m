//
//  UITextView+Input.m
//  RichText
//
//  Created by Tesiro on 16/10/8.
//  Copyright © 2016年 Tesiro. All rights reserved.
//

#import "UITextView+Input.h"
#import "EmoticonAttachment.h"

@implementation UITextView (Input)
-(NSString *)getEmoticonString{
    NSMutableAttributedString *attrMstr =[[NSMutableAttributedString alloc]initWithAttributedString: self.attributedText];
    //遍历属性字符串
    NSRange range = NSMakeRange(0, attrMstr.length);
    [attrMstr enumerateAttributesInRange:range options:nil usingBlock:^(NSDictionary<NSString *,id> * _Nonnull attrs, NSRange range, BOOL * _Nonnull stop) {
        if (attrs[@"NSAttachment"]) {
            EmoticonAttachment *attachment = (EmoticonAttachment*)attrs[@"NSAttachment"];
            
        }
    }];
    return  attrMstr.string;
}
-(void)insertEmoticon:(Emoticon*)emotion{
    if (emotion.isEmpty) {
        return;
    }
    if (emotion.isRemove) {
        [self deleteBackward];
        return;
    }
    if (emotion.emojiCode != nil) {
        UITextRange *textRange = self.selectedTextRange;
        [self replaceRange:textRange withText:emotion.emojiCode];
        return;
    }
    UITextRange *range1 = self.selectedTextRange;
    [self replaceRange:range1 withText:emotion.chs];
}
@end
