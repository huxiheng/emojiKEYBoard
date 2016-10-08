//
//  Emoticon.h
//  RichText
//
//  Created by Tesiro on 16/10/8.
//  Copyright © 2016年 Tesiro. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Emoticon : NSObject
@property (nonatomic,copy)NSString *code;
@property (nonatomic,copy)NSString *png;
@property (nonatomic,copy)NSString *chs;
@property (nonatomic,copy)NSString *pngPath;
@property (nonatomic,copy)NSString *emojiCode;
@property (nonatomic,assign)BOOL isRemove;
@property (nonatomic,assign)BOOL isEmpty;

- (instancetype)initWithDict:(NSDictionary *)dict;
- (instancetype)initWithIsRemove:(BOOL)isRemove;
- (instancetype)initWithEmpty:(BOOL)isEmpty;

@end
