//
//  GalleryDetailViewController.h
//  LAFitness
//
//  Created by Gina Mullins on 10/15/13.
//  Copyright (c) 2013 xxxxxxxxxx LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iCarousel.h"


@interface GalleryDetailViewController : UIViewController <iCarouselDataSource, iCarouselDelegate>

@property (nonatomic, assign) NSInteger cellIndex;
@property (weak, nonatomic) IBOutlet iCarousel *aCarousel;
@property (weak, nonatomic) IBOutlet UIImageView *headerView;

- (IBAction)goBack:(id)sender;


@end
