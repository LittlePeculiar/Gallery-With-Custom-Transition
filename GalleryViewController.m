//
//  GalleryViewController.m
//  LA Fitness
//
//  Created by Gina Mullins on 8/1/13.
//  Copyright (c) 2013 Fitness International. All rights reserved.
//

#import "GalleryViewController.h"
#import "GalleryDetailViewController.h"
#import "CollectionCell.h"
#import "ZoomPresentAnimationController.h"
#import "ShrinkDismissAnimationController.h"

#define kMAX_IMAGE          25


NSString * const REUSE_COLLECTION_CELL_ID = @"CollectionCell";

@interface GalleryViewController ()

@property (nonatomic, strong) GalleryDetailViewController *detailView;
@property (nonatomic, strong) NSMutableArray *thumbPhotos;
@property (nonatomic, assign) CGPoint touchPoint;

@end


@implementation GalleryViewController
{
    ZoomPresentAnimationController *_zoomAnimationController;
    ShrinkDismissAnimationController *_shrinkAnimationController;
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        self.thumbPhotos = [[NSMutableArray alloc] initWithCapacity:kMAX_IMAGE];
        _zoomAnimationController = [ZoomPresentAnimationController new];
        _shrinkAnimationController = [ShrinkDismissAnimationController new];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Register the custom collection cell
    UINib *collectionNib = [UINib nibWithNibName:REUSE_COLLECTION_CELL_ID bundle:[NSBundle bundleForClass:[CollectionCell class]]];
    [self.collectionView registerNib:collectionNib forCellWithReuseIdentifier:REUSE_COLLECTION_CELL_ID];
    
    // needed for animated transitions
    self.navigationController.delegate = self;
    
	//set up photos array
    for (int i = 1; i <= kMAX_IMAGE; i++)
    {
        NSString *thmImageName = [NSString stringWithFormat:@"thmImage%d.jpg", i];
        [self.thumbPhotos addObject:thmImageName];
    }
    
    if (self.detailView == nil)
    {
        self.detailView = [[GalleryDetailViewController alloc] initWithNibName:@"GalleryDetailViewController" bundle:nil];
        self.detailView.transitioningDelegate = self;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

#pragma mark CollectionView

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.thumbPhotos count];
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:REUSE_COLLECTION_CELL_ID forIndexPath:indexPath];
    
    UIImageView *imageView = (UIImageView *)[cell viewWithTag:100];
    imageView.image = [UIImage imageNamed:[self.thumbPhotos objectAtIndex:indexPath.row]];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    // let the zoomController know which cell was selected
    _zoomAnimationController.cellSelected = indexPath.row;
    
    // also send relative coords for selected cell
    if ([self.collectionView.indexPathsForVisibleItems containsObject:indexPath])
    {
        CollectionCell *cell = (CollectionCell*)[self.collectionView cellForItemAtIndexPath:indexPath];
        CGFloat relativeX = cell.frame.origin.x - self.collectionView.contentOffset.x + cell.cellImage.frame.origin.x;
        CGFloat relativeY = cell.frame.origin.y - self.collectionView.contentOffset.y + cell.cellImage.frame.origin.y;
        
        self.touchPoint = CGPointMake(relativeX, relativeY);
        _zoomAnimationController.touchPoint = self.touchPoint;
    }
    self.detailView.cellIndex = indexPath.row;
    [self.navigationController presentViewController:self.detailView animated:YES completion:nil];
}


#pragma mark - Transitioning delegate

- (id<UIViewControllerAnimatedTransitioning>) animationControllerForDismissedController:(UIViewController *)dismissed
{
    return _shrinkAnimationController;
}

#pragma mark UIViewControllerTransitioningDelegate

- (id<UIViewControllerAnimatedTransitioning>) animationControllerForPresentedController:(UIViewController *)presented
                                                                   presentingController:(UIViewController *)presenting
                                                                       sourceController: (UIViewController *)source
{
    return _zoomAnimationController;
}



@end
