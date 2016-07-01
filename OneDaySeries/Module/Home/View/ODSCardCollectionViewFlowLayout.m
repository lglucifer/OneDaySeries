//
//  ODSCardCollectionViewFlowLayout.m
//  OneDaySeries
//
//  Created by LiuXiaoyu on 16/6/29.
//  Copyright © 2016年 cn.com.uzero. All rights reserved.
//

#import "ODSCardCollectionViewFlowLayout.h"

@interface ODSCardCollectionViewFlowLayout() {
    CGFloat _scalingFactor;
    CGFloat _alphaFactor;
    CGFloat _scalingOffset;
}

@end

@implementation ODSCardCollectionViewFlowLayout

- (instancetype)init {
    if (self = [super init]) {
        _scalingOffset = 200;
        _scalingFactor = .9;
        _alphaFactor = .5;
        UIEdgeInsets sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
        self.minimumLineSpacing = sectionInset.left + sectionInset.right;
        self.minimumInteritemSpacing = 0.f;
        self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        self.sectionInset = sectionInset;
    }
    return self;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return YES;
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    //取出父类算出的布局属性
    //不能直接修改需要copy
    NSArray *superAttributes = [super layoutAttributesForElementsInRect:rect];
    NSArray *newAttributes = [[NSArray alloc] initWithArray:superAttributes copyItems:YES];
    
    //collectionView中心点的值
    //屏幕中心点对应于collectionView中content位置
    CGPoint contentOffset = self.collectionView.contentOffset;
    CGSize size = self.collectionView.bounds.size;
    CGRect visiableRect = CGRectMake(contentOffset.x, contentOffset.y, size.width, size.height);
    CGFloat visiableCenterX = CGRectGetMidX(visiableRect);
    
    for (UICollectionViewLayoutAttributes *layoutAttributes in newAttributes) {
        CGFloat distanceFromCenter = visiableCenterX - layoutAttributes.center.x;
        CGFloat absDistanceFromCenter = MIN(ABS(distanceFromCenter), _scalingOffset);
        CGFloat scale = absDistanceFromCenter * (_scalingFactor - 1) / _scalingOffset + 1;
        layoutAttributes.transform3D = CATransform3DScale(CATransform3DIdentity, scale, scale, 1);
        CGFloat alpha = absDistanceFromCenter * (_alphaFactor - 1) / _scalingOffset + 1;
        layoutAttributes.alpha = alpha;
    }
    
    return newAttributes;
}

//设置滑动停止时的collectionView的位置
- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity {
    
    // 计算出最终显示的矩形框
    CGRect rect;
    rect.origin.y = 0;
    rect.origin.x = proposedContentOffset.x;//最终要停下来的X
    rect.size = self.collectionView.frame.size;
    
    //获得计算好的属性
    NSArray * original = [super layoutAttributesForElementsInRect:rect];
    NSArray * attsArray = [[NSArray alloc] initWithArray:original copyItems:YES];
    //计算collection中心点X
    //视图中心点相对于collectionView的content起始点的位置
    CGFloat centerX = proposedContentOffset.x + self.collectionView.frame.size.width / 2;
    CGFloat minSpace = MAXFLOAT;
    for (UICollectionViewLayoutAttributes *attrs in attsArray) {
        //找到距离视图中心点最近的cell，并将minSpace值置为两者之间的距离
        if (ABS(minSpace) > ABS(attrs.center.x - centerX)) {
            minSpace = attrs.center.x - centerX;        //各个不同的cell与显示中心点的距离
        }
    }
    // 修改原有的偏移量
    proposedContentOffset.x += minSpace;
    return proposedContentOffset;
}

@end
