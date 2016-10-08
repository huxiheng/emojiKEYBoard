//
//  Emoticon.m
//  RichText
//
//  Created by Tesiro on 16/10/8.
//  Copyright © 2016年 Tesiro. All rights reserved.
//

#import "Emoticon.h"

@implementation Emoticon

- (instancetype)initWithDict:(NSDictionary *)dict{
    self =[super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dict];
        if (_png) {
            _pngPath = [NSString stringWithFormat:@"%@/Emoticons.bundle/%@",[NSBundle mainBundle].bundlePath,_png];
        }
       
        if (_code) {
            //创建扫描器
            NSScanner *scanner = [NSScanner scannerWithString:_code];
//            UInt32 value = 0;
            unsigned unicodeInt = 0;
            [scanner scanHexInt:&unicodeInt];
            char chars[4];
            int len = 4;
            
            chars[0] = (unicodeInt >> 24) & (1 << 24) - 1;
            chars[1] = (unicodeInt >> 16) & (1 << 16) - 1;
            chars[2] = (unicodeInt >> 8) & (1 << 8) - 1;
            chars[3] = unicodeInt & (1 << 8) - 1;
            self.emojiCode =[[NSString alloc] initWithBytes:chars
                                                    length:len
                                                  encoding:NSUTF32StringEncoding];;
            
        }
        
    }
    return self;
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}

-(NSString*)description{
    return [self dictionaryWithValuesForKeys:@[@"emojiCode",@"pngPath",@"chs"]].description;
}
- (instancetype)initWithIsRemove:(BOOL)isRemove{
    if (self=[super init]) {
        self.isRemove = isRemove;
    }
    return self;
}
- (instancetype)initWithEmpty:(BOOL)isEmpty{
    if (self=[super init]) {
        self.isEmpty = isEmpty;
    }
    return self;
}
@end
