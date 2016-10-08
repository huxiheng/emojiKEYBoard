//
//  EmotionController.m
//  RichText
//
//  Created by Tesiro on 16/10/5.
//  Copyright © 2016年 Tesiro. All rights reserved.
//

#import "EmotionController.h"
#import "emotionManager.h"
#import "EmotionPackage.h"
#import "EmioticonViewCell.h"

@interface EmotionController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, strong)UICollectionView *collectionView;
@property (nonatomic, strong)UIToolbar        *toolBar;
@property (nonatomic, strong)emotionManager   *manager;

@end

@implementation EmotionController

-(instancetype)initWithemotionCallBack:(emotionCallBack)callback{
    if (self== [super initWithNibName:nil bundle:nil]) {
        self.emotionCallBack = callback;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.manager = [[emotionManager alloc] init];
    [self setUpUI];
}

#pragma mark -- 布置ui界面－－－－
-(void)setUpUI{
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:[[EmoticonCollectionViewLayout alloc] init]];
    [self.collectionView setBackgroundColor:[UIColor purpleColor]];
    [self.view addSubview:self.collectionView];
    
    self.toolBar = [[UIToolbar alloc] init];
    self.toolBar.backgroundColor = [UIColor darkGrayColor];
    [self.view addSubview:self.toolBar];
    
    //设置子控件的frame
    self.collectionView.translatesAutoresizingMaskIntoConstraints = NO;
    self.toolBar.translatesAutoresizingMaskIntoConstraints = NO;
    NSDictionary *views = @{@"tBar" : self.toolBar,@"cView" : self.collectionView};
    NSMutableArray *cons = [NSMutableArray array];
   [cons addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[tBar]-0-|" options:nil metrics:nil views:views]] ;
    [cons addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[cView]-0-[tBar]-0-|" options:NSLayoutFormatAlignAllRight | NSLayoutFormatAlignAllLeft metrics:nil views:views]];
    [self.view addConstraints:cons];
    
    //准备collectionview
    [self prepareCollectionView];
    
    //准备toolbar
    [self prepareToolBar];
    
}

-(void)prepareCollectionView{
    [self.collectionView registerClass:[EmioticonViewCell class] forCellWithReuseIdentifier:@"emotionCell"];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
}

-(void)prepareToolBar{
    //定义iterms中的title
    NSArray *titles = @[@"最近",@"默认",@"emoji",@"浪小花"];
    //遍历标题，创建iterm
    int index = 0;
    NSMutableArray *tempIterms = [[NSMutableArray alloc] init];
    for (NSString* title in titles) {
        UIBarButtonItem *iterm = [[UIBarButtonItem alloc] initWithTitle:title style:UIBarButtonItemStylePlain target:self action:@selector(itermClick:)];
        iterm.tag = index;
        index ++;
        [tempIterms addObject:iterm];
        [tempIterms addObject:[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil]];
        
    }
    [tempIterms  removeLastObject];
    self.toolBar.items = tempIterms;
    self.toolBar.tintColor = [UIColor orangeColor];
}

- (void)itermClick:(UIBarButtonItem *)item{
    //获取点击iterm的tag
    NSInteger tag = item.tag;
    //根据tag获取当前的组
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:0 inSection:tag];
    //滚到对应的位置
    [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:true];
    
}

#pragma mark ----//collectionView数据源和代理方法----
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return self.manager.packages.count;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    EmotionPackage *package = [self.manager.packages objectAtIndex:section];
    
    return package.emoticons.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    EmioticonViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"emotionCell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor redColor];
    Emoticon *emoticon = ((EmotionPackage*)(self.manager.packages[indexPath.section])).emoticons[indexPath.item];
    cell.emoticon = emoticon;
    
    return cell;
    
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    EmotionPackage *package = self.manager.packages[indexPath.section];
    Emoticon *emotion = package.emoticons[indexPath.item];
    [self insertRecentlyEmoticon:emotion];
}

-(void)insertRecentlyEmoticon:(Emoticon *)emotion{
    self.emotionCallBack(emotion);
    //如果是空白表情或者是删除按钮，不需要插入
    if (emotion.isEmpty || emotion.isRemove) {
        return;
    }
    //删除一个表情
    if ([((EmotionPackage*)self.manager.packages.firstObject).emoticons containsObject:emotion]) {
        NSUInteger index = [( (EmotionPackage*)self.manager.packages.firstObject).emoticons indexOfObject:emotion];
        [( (EmotionPackage*)self.manager.packages.firstObject).emoticons removeObjectAtIndex:index];
        
    }else{
        [( (EmotionPackage*)self.manager.packages.firstObject).emoticons removeObjectAtIndex:19];
    }
    // 将emoticon插入到最近分组中
    [( (EmotionPackage*)self.manager.packages.firstObject).emoticons insertObject:emotion atIndex:0];
}


@end

@implementation EmoticonCollectionViewLayout
- (void)prepareLayout{
    [super prepareLayout];
    
    //计算itermwh
    CGFloat itemWH = [UIScreen mainScreen].bounds.size.width / 7;
    CGSize itemSize = CGSizeMake(itemWH, itemWH);
    self.itemSize = itemSize;
    self.minimumInteritemSpacing = 0;
    self.minimumLineSpacing = 0;
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    //设置collectionview的属性
    self.collectionView.pagingEnabled = YES;
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    CGFloat insertMargin = (self.collectionView.bounds.size.height - 3*itemWH)/2;
    self.collectionView.contentInset = UIEdgeInsetsMake(insertMargin, 0, insertMargin, 0);
    
}


@end
