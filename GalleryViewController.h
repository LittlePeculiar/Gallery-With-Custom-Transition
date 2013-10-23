//
//  GalleryViewController.h
//  LA Fitness
//
//  Created by Gina Mullins on 8/1/13.
//  Copyright (c) 2013 xxxxxxxxxx. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface GalleryViewController : UIViewController <UIViewControllerTransitioningDelegate, UINavigationControllerDelegate>

// UI

@property (nonatomic, weak) IBOutlet UICollectionView *collectionView;


@end
