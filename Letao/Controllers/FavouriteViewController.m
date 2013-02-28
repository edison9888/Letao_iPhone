//
//  FavouriteViewController.m
//  Letao
//
//  Created by Kaibin on 13-2-17.
//  Copyright (c) 2013年 Kaibin. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "FavouriteViewController.h"
#import "CustomGridViewCell.h"
#import "GMGridView.h"
#import "Item.h"
#import "GlobalConstants.h"
#import "UIImageView+WebCache.h"
#import "ItemManager.h"
#import "ItemDetailViewController.h"
#import "ItemManager.h"
#import "UIBarButtonItemExt.h"

@interface FavouriteViewController ()

@end

@implementation FavouriteViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)init
{
    self = [super init];
    if (self) {
        _data = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)loadView
{
    [super loadView];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSInteger spacing = INTERFACE_IS_PHONE ? 5 : 15;
    GMGridView *gmGridView = [[GMGridView alloc] initWithFrame:self.view.bounds];
    gmGridView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    gmGridView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:gmGridView];
    _gmGridView = gmGridView;
    
    _gmGridView.style = GMGridViewStyleSwap;
    _gmGridView.itemSpacing = spacing;
    _gmGridView.minEdgeInsets = UIEdgeInsetsMake(spacing, spacing, spacing, spacing);
    _gmGridView.centerGrid = NO;
    _gmGridView.enableEditOnLongPress = YES;
    _gmGridView.disableEditOnEmptySpaceTap = YES;
    _gmGridView.actionDelegate = self;
    _gmGridView.sortingDelegate = self;
    _gmGridView.transformDelegate = self;
    _gmGridView.dataSource = self;
    
    _helpLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 15, 275, 40)];
    _helpLabel.backgroundColor = [UIColor clearColor];
    _helpLabel.hidden = YES;
    NSString* text = @"在详情页面点击心形按钮添加喜欢的项目！";
    _helpLabel.numberOfLines = 0;
    _helpLabel.textAlignment = UITextAlignmentCenter;
    _helpLabel.text = text;
    _helpLabel.font = [UIFont systemFontOfSize:13];
    [self.view addSubview:_helpLabel];
}

- (void)loadFavouriteData
{
    [_data removeAllObjects];
    [_data addObjectsFromArray:[[ItemManager sharedManager] loadFavouriteItems]];
    [_gmGridView reloadData];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:240/255.0 green:248/255.0 blue:255/255.0 alpha:1.0];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self loadFavouriteData];
        
    if ([_data count] == 0) {
        _helpLabel.hidden = NO;
        self.navigationItem.rightBarButtonItem = nil;

    } else {
        _helpLabel.hidden = YES;
        
        UIImage *buttonBackground = [UIImage imageNamed:@"BarButtonBackground"];
        // use cap insets that leave a 1x1 pixel area in the center of the image
        UIEdgeInsets capInsets = UIEdgeInsetsMake(15, 5, 14, 5);
        UIImage *stretchy = [buttonBackground resizableImageWithCapInsets:capInsets];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        // this image should stretch to fill the button
        [button setBackgroundImage:stretchy forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont boldSystemFontOfSize:14];
        [button setTitle:@"   EDIT   " forState:UIControlStateNormal];
        [button sizeToFit];
        [button addTarget:self action:@selector(clickEdit:) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *rightBarButtonItem = [[[UIBarButtonItem alloc] initWithCustomView:button] autorelease];
        self.navigationItem.rightBarButtonItem = rightBarButtonItem;

    }
}

- (void)viewDidUnload
{
    _gmGridView = nil;
    _helpLabel = nil;
    _data = nil;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)dealloc
{
    [_data release], _data = nil;
    [_helpLabel release], _helpLabel = nil;
    [super dealloc];
}

#pragma mark -
#pragma mark GMGridViewDataSource

- (NSInteger)numberOfItemsInGMGridView:(GMGridView *)gridView
{
    NSLog(@"number of data count:%d",_data.count);
    return [_data count];
}

- (CGSize)GMGridView:(GMGridView *)gridView sizeForItemsInInterfaceOrientation:(UIInterfaceOrientation)orientation
{
    if (INTERFACE_IS_PHONE)
    {
        if (UIInterfaceOrientationIsLandscape(orientation))
        {
            return CGSizeMake(170, 135);
        }
        else
        {
            return CGSizeMake(150, 110);
        }
    }
    else
    {
        if (UIInterfaceOrientationIsLandscape(orientation))
        {
            return CGSizeMake(285, 205);
        }
        else
        {
            return CGSizeMake(230, 175);
        }
    }
}

- (GMGridViewCell *)GMGridView:(GMGridView *)gridView cellForItemAtIndex:(NSInteger)index
{
    static NSString *CellIdentifier = @"GridCell";
    GMGridViewCell *cell = [gridView dequeueReusableCellWithIdentifier:CellIdentifier];
    CustomGridViewCell *customCell = (CustomGridViewCell*)cell;
    
    if (!cell)
    {
        customCell = [[CustomGridViewCell alloc] init];
        customCell.deleteButtonIcon = [UIImage imageNamed:@"close_x.png"];
        customCell.deleteButtonOffset = CGPointMake(-15, -15);

    }
    [[customCell.contentView subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    Item *item = [_data objectAtIndex:index];
    customCell.textLabel.text = [item title];
    
    NSString *imageUrl = [item.imageList objectAtIndex:0];
    if (![imageUrl hasPrefix:@"http"]) {
        imageUrl = [DUREX_IMAGE_BASE_URL stringByAppendingString:imageUrl];
    }
    [customCell.imageView setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:[UIImage imageNamed:@"photo-placeholder"]];
    return customCell;
}

- (void)removeItem
{
    NSLog(@"remove item from superview");
    
}

- (void)clickEdit:(id)sender
{
    _gmGridView.editing = !_gmGridView.isEditing;
    [_gmGridView layoutSubviewsWithAnimation:GMGridViewItemAnimationFade];

}

- (BOOL)GMGridView:(GMGridView *)gridView canDeleteItemAtIndex:(NSInteger)index
{
    return YES;
}

#pragma mark -
#pragma mark GMGridViewActionDelegate

- (void)GMGridView:(GMGridView *)gridView didTapOnItemAtIndex:(NSInteger)position
{
    ItemDetailViewController *controller = [[ItemDetailViewController alloc] initWithItem:[_data objectAtIndex:position]];
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)GMGridViewDidTapOnEmptySpace:(GMGridView *)gridView
{
    NSLog(@"Tap on empty space");
}

- (void)GMGridView:(GMGridView *)gridView processDeleteActionForItemAtIndex:(NSInteger)index
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Confirm" message:@"Are you sure you want to delete this item?" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Delete", nil];
    
    [alert show];
    [alert release];
    
    _lastDeleteItemIndexAsked = index;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1)
    {
        [[ItemManager sharedManager] removeItemFromFavourite:[_data objectAtIndex:_lastDeleteItemIndexAsked]];
        [_data removeObjectAtIndex:_lastDeleteItemIndexAsked];
        [_gmGridView removeObjectAtIndex:_lastDeleteItemIndexAsked withAnimation:GMGridViewItemAnimationFade];
    }
}

#pragma mark -
#pragma mark GMGridViewSortingDelegate

- (void)GMGridView:(GMGridView *)gridView didStartMovingCell:(GMGridViewCell *)cell
{
    [UIView animateWithDuration:0.3
                          delay:0
                        options:UIViewAnimationOptionAllowUserInteraction
                     animations:^{
                         cell.contentView.backgroundColor = [UIColor orangeColor];
                         cell.contentView.layer.shadowOpacity = 0.7;
                     }
                     completion:nil
     ];
}

- (void)GMGridView:(GMGridView *)gridView didEndMovingCell:(GMGridViewCell *)cell
{
    [UIView animateWithDuration:0.3
                          delay:0
                        options:UIViewAnimationOptionAllowUserInteraction
                     animations:^{
                         cell.contentView.backgroundColor = [UIColor redColor];
                         cell.contentView.layer.shadowOpacity = 0;
                     }
                     completion:nil
     ];
}

- (BOOL)GMGridView:(GMGridView *)gridView shouldAllowShakingBehaviorWhenMovingCell:(GMGridViewCell *)cell atIndex:(NSInteger)index
{
    return YES;
}

- (void)GMGridView:(GMGridView *)gridView moveItemAtIndex:(NSInteger)oldIndex toIndex:(NSInteger)newIndex
{
    NSObject *object = [_data objectAtIndex:oldIndex];
    [_data removeObject:object];
    [_data insertObject:object atIndex:newIndex];
}

- (void)GMGridView:(GMGridView *)gridView exchangeItemAtIndex:(NSInteger)index1 withItemAtIndex:(NSInteger)index2
{
    [_data exchangeObjectAtIndex:index1 withObjectAtIndex:index2];
}

#pragma mark -
#pragma mark DraggableGridViewTransformingDelegate

- (CGSize)GMGridView:(GMGridView *)gridView sizeInFullSizeForCell:(GMGridViewCell *)cell atIndex:(NSInteger)index inInterfaceOrientation:(UIInterfaceOrientation)orientation
{
    if (INTERFACE_IS_PHONE)
    {
        if (UIInterfaceOrientationIsLandscape(orientation))
        {
            return CGSizeMake(320, 210);
        }
        else
        {
            return CGSizeMake(300, 310);
        }
    }
    else
    {
        if (UIInterfaceOrientationIsLandscape(orientation))
        {
            return CGSizeMake(700, 530);
        }
        else
        {
            return CGSizeMake(600, 500);
        }
    }
}

- (UIView *)GMGridView:(GMGridView *)gridView fullSizeViewForCell:(GMGridViewCell *)cell atIndex:(NSInteger)index
{
    UIView *fullView = [[UIView alloc] init];
    fullView.backgroundColor = [UIColor yellowColor];
    fullView.layer.masksToBounds = NO;
    fullView.layer.cornerRadius = 8;
    
    CGSize size = [self GMGridView:gridView sizeInFullSizeForCell:cell atIndex:index inInterfaceOrientation:[[UIApplication sharedApplication] statusBarOrientation]];
    fullView.bounds = CGRectMake(0, 0, size.width, size.height);
    
    UILabel *label = [[UILabel alloc] initWithFrame:fullView.bounds];
    label.text = [NSString stringWithFormat:@"Fullscreen View for cell at index %d", index];
    label.textAlignment = NSTextAlignmentCenter;
    label.backgroundColor = [UIColor clearColor];
    label.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    if (INTERFACE_IS_PHONE)
    {
        label.font = [UIFont boldSystemFontOfSize:15];
    }
    else
    {
        label.font = [UIFont boldSystemFontOfSize:20];
    }
    
    [fullView addSubview:label];
    
    
    return fullView;
}

- (void)GMGridView:(GMGridView *)gridView didStartTransformingCell:(GMGridViewCell *)cell
{
    [UIView animateWithDuration:0.5
                          delay:0
                        options:UIViewAnimationOptionAllowUserInteraction
                     animations:^{
                         cell.contentView.backgroundColor = [UIColor blueColor];
                         cell.contentView.layer.shadowOpacity = 0.7;
                     }
                     completion:nil];
}

- (void)GMGridView:(GMGridView *)gridView didEndTransformingCell:(GMGridViewCell *)cell
{
    [UIView animateWithDuration:0.5
                          delay:0
                        options:UIViewAnimationOptionAllowUserInteraction
                     animations:^{
                         cell.contentView.backgroundColor = [UIColor redColor];
                         cell.contentView.layer.shadowOpacity = 0;
                     }
                     completion:nil];
}

- (void)GMGridView:(GMGridView *)gridView didEnterFullSizeForCell:(UIView *)cell
{
    
}

#pragma mark -
#pragma mark private methods

@end
