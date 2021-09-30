//
//  CollectionVCtr.m
//  BSApp
//
//  Created by LZBiao on 2021/9/21.
//  Copyright © 2021 LZBiao. All rights reserved.
//

#import "CollectionVCtr.h"
#import "CollectionViewCell.h"
#import "AdvertisingColumn.h"//头部滚动的，不需要可以去掉

static float headHeight = 150;
static NSString *cellidne = @"cellidne111";
static NSString *headidne = @"headidne111";

@interface CollectionVCtr ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (strong, nonatomic) AdvertisingColumn *headView; //广告栏
@property (strong, nonatomic) UICollectionView *collectView;
@property (copy, nonatomic) NSArray *datas;
@property (copy, nonatomic) NSDictionary *funcNameDic;

@end

@implementation CollectionVCtr

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = kWhiteColor;
    self.title = @"自定义UICollectionView";
    [self initData];
    [self creatView];
    
//    self.datas = [imgArray mutableCopy];
    
}
-(void)initData{
    self.funcNameDic = @{
        @"cat1":@"cat1",
        @"cat2":@"cat2",
        @"cat3":@"cat3",
        @"cat4":@"cat4",
        @"cat5":@"cat5",
        @"cat6":@"cat6",
        @"cat7":@"cat7",
        @"cat8":@"cat8",
        @"cat9":@"cat9",
        @"cat10":@"cat10"
    };
    
    self.datas = @[
        @{@"main_title":self.funcNameDic[@"cat1"],@"btn_title":@"cat1",@"image_name":@"cat.png",@"color":RGBAlpha(255, 243, 197, 1.0),@"vctr":@""},
        @{@"main_title":self.funcNameDic[@"cat2"],@"btn_title":@"cat1",@"image_name":@"cat.png",@"color":RGBAlpha(255, 243, 197, 1.0),@"vctr":@""},
        @{@"main_title":self.funcNameDic[@"cat3"],@"btn_title":@"cat3",@"image_name":@"cat.png",@"color":RGBAlpha(252, 226, 215, 1.0),@"vctr":@""},
        @{@"main_title":self.funcNameDic[@"cat4"],@"btn_title":@"cat4",@"image_name":@"cat.png",@"color":RGBAlpha(223, 223, 255, 1.0),@"vctr":@""},
        @{@"main_title":self.funcNameDic[@"cat5"],@"btn_title":@"cat5",@"image_name":@"cat.png",@"color":RGBAlpha(255, 247, 224, 1.0),@"vctr":@""},
        @{@"main_title":self.funcNameDic[@"cat6"],@"btn_title":@"cat6",@"image_name":@"cat.png",@"color":RGBAlpha(210, 249, 254, 1.0),@"vctr":@""},
        @{@"main_title":self.funcNameDic[@"cat7"],@"btn_title":@"cat7",@"image_name":@"cat.png",@"color":RGBAlpha(223, 255, 237, 1.0),@"vctr":@""},
        @{@"main_title":self.funcNameDic[@"cat8"],@"btn_title":@"cat8",@"image_name":@"cat.png",@"color":RGBAlpha(222, 240, 254, 1.0),@"vctr":@""},
        @{@"main_title":self.funcNameDic[@"cat9"],@"btn_title":@"cat9",@"image_name":@"cat.png",@"color":RGBAlpha(255, 234, 236, 1.0),@"vctr":@""},
        @{@"main_title":self.funcNameDic[@"cat10"],@"btn_title":@"cat10",@"image_name":@"cat.png",@"color":RGBAlpha(255, 243, 197, 1.0),@"vctr":@""}
    ];
    
}

-(void)creatView{
    [self.view addSubview:self.collectView];
    
    self.headView = [[AdvertisingColumn alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, headHeight)];
    self.headView.backgroundColor = kCyanColor;
    
    /**
     *  广告栏
     */
    self.headView = [[AdvertisingColumn alloc]initWithFrame:CGRectMake(5, 5, kScreenWidth-10, headHeight)];
    self.headView.backgroundColor = kCyanColor;
    /**
     *  加载的数据
     */
    NSArray *imgArray = [NSArray arrayWithObjects:@"cat.png",@"cat.png",@"cat.png",@"cat.png",@"cat.png",@"cat.png",@"cat.png",@"cat.png",@"cat.png",@"cat.png",@"cat.png",@"cat.png",@"cat.png",@"cat.png",@"cat.png",@"cat.png",@"cat.png",@"cat.png",@"cat.png",@"cat.png",@"cat.png",@"cat.png",@"cat.png",@"cat.png",@"cat.png",@"cat.png",@"cat.png",@"cat.png",@"cat.png",@"cat.png",@"cat.png",@"cat.png",@"cat.png",@"cat.png",@"cat.png",@"cat.png",@"cat.png",@"cat.png",@"cat.png",@"cat.png", nil];
    [self.headView setArray:imgArray];
    
}


-(UICollectionView *)collectView{
    if(_collectView == nil){
        
        int gap = 10;
        int cloumn = 3;//列数 collectview显示几列，是根据item的自身宽度和所有item之间的间隔决定的。显示不下就会自动换行
        float itemWidth = (kScreenWidth - 2*cloumn*gap)/cloumn;

        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
        //头部大小
        flowLayout.headerReferenceSize = CGSizeMake(kScreenWidth, headHeight+10);
        //每个item的大小
        flowLayout.itemSize = CGSizeMake(itemWidth, itemWidth+50);
        //相邻两 排 item的间距
        flowLayout.minimumLineSpacing = gap * 5;
        //相邻两 个 item的间距
        flowLayout.minimumInteritemSpacing = gap;
        //UICollectionView 的四边边距距
        flowLayout.sectionInset = UIEdgeInsetsMake(50, gap, 200, gap);
        //滚动方向
        flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        
        _collectView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) collectionViewLayout:flowLayout];
        _collectView.backgroundColor = kWhiteColor;
        
        //注册cell和ReusableView（相当于头部）
        [_collectView registerClass:[CollectionViewCell class] forCellWithReuseIdentifier:cellidne];
        [_collectView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headidne];
        //注册代理
        _collectView.dataSource = self;
        _collectView.delegate = self;
        //自适应大小
        _collectView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        
    }
    
    return _collectView;
    
}
#pragma mark - UICollectionView delegate dataSource

#pragma mark 定义展示的Section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

#pragma mark 定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.datas.count;
}

#pragma mark 每个UICollectionView展示的内容
-(__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellidne forIndexPath:indexPath];
    [cell sizeToFit];
//    cell.imgView.image = [UIImage imageNamed:self.datas[indexPath.item]];
//    cell.text.text = [NSString stringWithFormat:@"cat %ld",indexPath.item];
    cell.data = self.datas[indexPath.item];

    return cell;
}

#pragma mark 头部显示的内容
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionReusableView *rview = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headidne forIndexPath:indexPath];
    
    [rview addSubview:self.headView];
    return rview;
    
}
#pragma mark UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%ld,%ld,%ld,%ld",indexPath.section,indexPath.item,indexPath.row,indexPath.length);
}

#pragma mark - 定时滚动scrollView
-(void)viewDidAppear:(BOOL)animated {//显示窗口
    [super viewDidAppear:animated];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.headView openTimer];//开启定时器
    });
}
-(void)viewWillDisappear:(BOOL)animated {//将要隐藏窗口
    [super viewWillDisappear:animated];
    if (self.headView .totalNum>1) {
        [self.headView  closeTimer];//关闭定时器
    }
}
#pragma mark - scrollView也是适用于tableView的cell滚动 将开始和将要结束滚动时调用
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.headView  closeTimer];//关闭定时器
}
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    if (self.headView .totalNum>1) {
        [self.headView  openTimer];//开启定时器
    }
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
