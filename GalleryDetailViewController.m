//
//  GalleryDetailViewController.m
//  LAFitness
//
//  Created by Gina Mullins on 10/15/13.
//  Copyright (c) 2013 Fitness International LLC. All rights reserved.
//

#import "GalleryDetailViewController.h"

#define kMAX_IMAGE          13

@interface GalleryDetailViewController ()

@property (nonatomic, strong) NSMutableArray *gallery;
@property (nonatomic, assign) NSInteger carouselWidth;

@end

@implementation GalleryDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        //set up data
        //your carousel should always be driven by an array of
        //data of some kind - don't store data in your item views
        //or the recycling mechanism will destroy your data once
        //your item views move off-screen
        
        self.gallery = [[NSMutableArray alloc] initWithCapacity:kMAX_IMAGE];
        
        for (int i = 1; i <= kMAX_IMAGE; i++)
        {
            NSString *imageName = [NSString stringWithFormat:@"largeImageL%d.jpg", i];
            [self.gallery addObject:imageName];
        }
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
	//set up carousel data
    self.aCarousel.type = iCarouselTypeLinear;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.aCarousel scrollToItemAtIndex:self.cellIndex animated:NO];
}

- (IBAction)prevImage:(id)sender
{
    [self.aCarousel scrollToItemAtIndex:self.aCarousel.currentItemIndex-1 animated:YES];
}

- (IBAction)nextImage:(id)sender
{
    [self.aCarousel scrollToItemAtIndex:self.aCarousel.currentItemIndex+1 animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
    [self setGallery:nil];
}



#pragma - mark iCarousel Delegate

- (NSUInteger)numberOfItemsInCarousel:(iCarousel *)carousel
{
    return [self.gallery count];
}

- (UIView*)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSUInteger)index reusingView:(UIView *)view
{
    // create a numbered view
    view = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[self.gallery objectAtIndex:index]]];
    return view;
}

- (NSUInteger)numberOfPlaceholdersInCarousel:(iCarousel *)carousel
{
    return 0;
}

- (CGFloat)carouselItemWidth:(iCarousel *)carousel
{
    // usually this should be slightly wider than the item views
    return self.carouselWidth;
}


- (void)carouselDidScroll:(iCarousel *)carousel
{
    // can do something
}

- (IBAction)goBack:(id)sender
{
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}


- (BOOL)shouldAutorotate
{
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskAll;
}

-(void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    UIInterfaceOrientation devOrientation = self.interfaceOrientation;
    
    if (UIInterfaceOrientationLandscapeLeft == devOrientation || UIInterfaceOrientationLandscapeRight == devOrientation)
    {
        // Code for landscape setup
        self.headerView.image = [UIImage imageNamed:@"homeHeaderLandscapewLogo.png"];
        
        if ([[Utils sharedInstance] isIPhone5])
        {
            self.carouselWidth = 500;
            self.aCarousel.frame = CGRectMake(0, 50, self.carouselWidth, 260);
        }
        else
        {
            self.carouselWidth = 400;
            self.aCarousel.frame = CGRectMake(0, 50, self.carouselWidth, 260);
        }
        
    }
    else
    {
        // Code for portrait setup
        self.headerView.image = [UIImage imageNamed:@"homeHeaderPortraitwLogo.png"];
        
        self.carouselWidth = 320;       // does not change for any model
        if ([[Utils sharedInstance] isIPhone5])
        {
            self.aCarousel.frame = CGRectMake(0, 50, self.carouselWidth, 525);
        }
        else
        {
            self.aCarousel.frame = CGRectMake(0, 50, self.carouselWidth, 425);
        }
        
        
    }
}

@end
