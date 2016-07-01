//
//  CollectionViewController.m
//  NightKiss
//
//  Created by Tolecen on 15/7/5.
//  Copyright © 2015年 Tolecen. All rights reserved.
//

#import "ODSCollectionViewController.h"

@interface HCell : UICollectionViewCell
@property (nonatomic,retain)UIImageView * albumView;
@property (nonatomic,retain)UILabel * desL;
@property (nonatomic,retain)UILabel * timeL;

@end
@implementation HCell
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.contentView.backgroundColor = [UIColor clearColor];
        self.backgroundColor = [UIColor clearColor];
        
        float myWidth = (ODSScreenWidth-30)/2;
        
        UIView * b = [[UIView alloc] initWithFrame:CGRectMake(0, 0, myWidth, myWidth)];
        b.backgroundColor = [UIColor whiteColor];
        b.layer.cornerRadius = 10;
        b.layer.masksToBounds = YES;
        [self.contentView addSubview:b];

        self.albumView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, myWidth, 2*myWidth/3)];
        self.albumView.backgroundColor = [UIColor colorWithWhite:200/255.0f alpha:1];
        [b addSubview:self.albumView];
        
        
        self.desL = [[UILabel alloc] initWithFrame:CGRectMake(5, myWidth-(myWidth/3-10)/2-5, myWidth-10, (myWidth/3-10)/2)];
        self.desL.textColor = [UIColor colorWithWhite:120/255.0f alpha:1];
        self.desL.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:self.desL];
        self.desL.text = @"看着鱼的猫咪，干瞪眼";
        
        self.timeL = [[UILabel alloc] initWithFrame:CGRectMake(5, 2*myWidth/3+5, myWidth-10, (myWidth/3-10)/2)];
        self.timeL.textColor = [UIColor colorWithRed:0.235 green:0.776 blue:1 alpha:1];
        self.timeL.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:self.timeL];
        self.timeL.text = @"June. 23, 2015";
    }
    return self;
}
@end

@implementation ODSCollectionViewController
-(void)viewDidLoad
{
    [super viewDidLoad];
    
    currentPage = 0;
    
    self.view.backgroundColor = [UIColor clearColor];
    UIImageView * h = [[UIImageView alloc] initWithFrame:self.view.frame];
    h.image = [UIImage imageNamed:@"background"];
    [self.view addSubview:h];
    
    
    UICollectionViewFlowLayout* layout = [[UICollectionViewFlowLayout alloc]init];
    float width = (self.view.frame.size.width-30)/2;
    layout.itemSize = CGSizeMake(width,width);
    layout.sectionInset = UIEdgeInsetsMake(40, 10, 10, 10);
    layout.minimumInteritemSpacing = 10;
    layout.minimumLineSpacing = 10;
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    self.contentView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    self.contentView.delegate = self;
    self.contentView.dataSource = self;
    self.contentView.backgroundColor = [UIColor clearColor];
    self.contentView.backgroundView = nil;
    [self.view addSubview:self.contentView];
    self.contentView.showsHorizontalScrollIndicator = NO;
    [self.contentView registerClass:[HCell class] forCellWithReuseIdentifier:@"hccell"];
    
    

    
    [self getList];
    
}
-(void)getList
{
   
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 20;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *hCellIdentifier = @"hccell";
    HCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:hCellIdentifier forIndexPath:indexPath];
    [cell.albumView setImage:[UIImage imageNamed:@"exmp_pic_list"]];
//    cell.albumView.sd_imageURL = [NSURL URLWithString:@"http://i9.topit.me/9/12/af/1108263372db4af129o.jpg"];
//    cell.headView.imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@?imageView2/2/w/50",petalk.petInfo.headImgURL]];
//    cell.nameL.text = petalk.petInfo.nickname;
//    cell.timesL.text = [NSString stringWithFormat:@"%@人浏览",petalk.browseNum];
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}

-(void)scrollViewWillBeginDragging:(nonnull UIScrollView *)scrollView
{
    lastOffsetY = scrollView.contentOffset.y;
}
-(void)scrollViewDidScroll:(nonnull UIScrollView *)scrollView
{

        
        
}

- (void)scrollViewDidScrollToTop:(UIScrollView *)scrollView;
{

}
-(void)backAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
