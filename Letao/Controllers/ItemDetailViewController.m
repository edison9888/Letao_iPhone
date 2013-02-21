//
//  ItemDetailViewController.m
//  Letao
//
//  Created by Callon Tom on 13-2-6.
//  Copyright (c) 2013年 Kaibin. All rights reserved.
//

#import "ItemDetailViewController.h"
#import "SlideImageView.h"
#import "UIImageUtil.h"
#import "GlobalConstants.h"
#import "ItemManager.h"
#import <MBProgressHUD/MBProgressHUD.h>
#import "ShareToSinaController.h"

@interface ItemDetailViewController ()

@end

@implementation ItemDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithItem:(Item*)item
{
    self = [super init];
    if (self) {
        self.item = item;
    }
    return self;
}

- (void)viewDidAppear:(BOOL)animated
{
    self.hidesBottomBarWhenPushed = YES;
    [super viewDidAppear:animated];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"详情";
    
    [self addSlideImageView];
    
    [self addDetailView];
    
    [self addFavouriteView];
            
    [_dataScrollView setContentSize:CGSizeMake(self.view.frame.size.width, _totalHeight)];
    
}

- (void)clickFavourite:(id)sender
{
    ItemManager *itemManager = [ItemManager defaultManager];
    [itemManager addItemIntoFavourite:self.item];
    
    MBProgressHUD *HUD =[[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    HUD.labelText = @"成功添加到我的喜欢";
    HUD.mode = MBProgressHUDModeCustomView;
    HUD.customView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Checkmark"]] autorelease];

    [HUD showAnimated:YES whileExecutingBlock:^{
        sleep(1);
    } completionBlock:^{
        [HUD removeFromSuperview];
        [HUD release];
    }];
    
}

- (void)clickShare:(id)sender
{
    ShareToSinaController *controller = [[ShareToSinaController alloc] initWithItem:_item];
    [self.navigationController pushViewController:controller animated:YES];
    [controller release];
}

- (void)addFavouriteView
{
    UIView *favouritesView = [[UIView alloc]initWithFrame:CGRectMake(0, _totalHeight, self.view.frame.size.width, 40)];
    favouritesView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bottombg.png"]];
    
    UIButton *favButton = [[UIButton alloc] initWithFrame:CGRectMake((self.view.frame.size.width-200)/2, 5, 93, 29)];
    [favButton addTarget:self action:@selector(clickFavourite:) forControlEvents:UIControlEventTouchUpInside];
    favButton.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"favorites.png"]];
    [favButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [favButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [favButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 18, 0, 0)];
    [favButton setTitle:@"喜欢" forState:UIControlStateNormal];
    [favButton setEnabled:YES];
    [favouritesView addSubview:favButton];
    [favButton release];
    
    UIButton *shareButton = [[UIButton alloc] initWithFrame:CGRectMake((self.view.frame.size.width+50)/2, 5, 93, 29)];
    [shareButton addTarget:self action:@selector(clickShare:) forControlEvents:UIControlEventTouchUpInside];
    shareButton.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"favorites.png"]];
    [shareButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [shareButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [shareButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 18, 0, 0)];
    [shareButton setTitle:@"分享" forState:UIControlStateNormal];
    [shareButton setEnabled:YES];
    [favouritesView addSubview:shareButton];
    [shareButton release];

    
    [_dataScrollView addSubview:favouritesView];
    [favouritesView release];
    
    _totalHeight += favouritesView.frame.size.height;
}


- (void)addDetailView
{
    float padding = 5;
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, _totalHeight, 310, 30)];
    titleLabel.backgroundColor = [UIColor colorWithRed:65/255.0 green:105/255.0 blue:225/255.0 alpha:1.0];
    titleLabel.font = [UIFont systemFontOfSize:15];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.text =  [NSString stringWithFormat:(@" %@"),_item.title];
    [self.dataScrollView addSubview:titleLabel];
    _totalHeight += titleLabel.frame.size.height + padding;
    [titleLabel release];
    
    NSString *subtitle = _item.subtitle;
    if ([subtitle length] > 0) {
        UILabel *subtitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, _totalHeight, 300, 30)];
        subtitleLabel.backgroundColor = [UIColor clearColor];
        subtitleLabel.font = [UIFont systemFontOfSize:14];
        subtitleLabel.text =  subtitle;
        [self.dataScrollView addSubview:subtitleLabel];
        _totalHeight += subtitleLabel.frame.size.height + padding;
        [subtitleLabel release];
    }
    
    CGSize withinSize = CGSizeMake(300, CGFLOAT_MAX);
    NSString *description = [_item.description stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@"\n"];
    CGSize size = [description sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:withinSize lineBreakMode:UILineBreakModeWordWrap];
     UILabel *descriptionLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, _totalHeight, 300, size.height)];
    descriptionLabel.lineBreakMode = UILineBreakModeWordWrap;
    descriptionLabel.numberOfLines = 0;
    descriptionLabel.backgroundColor = [UIColor clearColor];
    descriptionLabel.font = [UIFont systemFontOfSize:14];
    descriptionLabel.text = description;
    [self.dataScrollView addSubview:descriptionLabel];
    _totalHeight += descriptionLabel.frame.size.height + padding;
    [descriptionLabel release];
    
    
    NSString *smooth_index = _item.smooth_index;
    if ([smooth_index length] > 0) {
        UILabel *smooth_indexLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, _totalHeight, 300, 30)];
        smooth_indexLabel.backgroundColor = [UIColor clearColor];
        smooth_indexLabel.font = [UIFont systemFontOfSize:14];
        smooth_indexLabel.text =  smooth_index;
        [self.dataScrollView addSubview:smooth_indexLabel];
        _totalHeight += smooth_indexLabel.frame.size.height + padding;
        [smooth_indexLabel release];

    }
    
    NSString *information = [[_item.information stringByReplacingOccurrencesOfString:@"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" withString:@"&nbsp;"] stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@"\n"];
    size = [information sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:withinSize lineBreakMode:UILineBreakModeWordWrap];
    UILabel *informationLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, _totalHeight, 300, size.height)];
    informationLabel.lineBreakMode = UILineBreakModeWordWrap;
    informationLabel.numberOfLines = 0;
    informationLabel.backgroundColor = [UIColor clearColor];
    informationLabel.font = [UIFont systemFontOfSize:14];
    informationLabel.text = information;
    [self.dataScrollView addSubview:informationLabel];
    _totalHeight += informationLabel.frame.size.height + padding;
    [informationLabel release];
    
    NSString *tips = _item.tips;
    if ([tips length] > 0) {
        tips = _item.tips;
        tips = [[_item.tips stringByReplacingOccurrencesOfString:@"●" withString:@"\n●"] stringByReplacingOccurrencesOfString:@"【" withString:@"\n【"];
        tips = [[[[[[tips stringByReplacingOccurrencesOfString:@"&plusmn;" withString:@"±"] stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@""] stringByReplacingOccurrencesOfString:@"&ldquo;" withString:@"“"]stringByReplacingOccurrencesOfString:@"&rdquo;" withString:@"”"]stringByReplacingOccurrencesOfString:@"&mdash;" withString:@"—"]stringByReplacingOccurrencesOfString:@"&quot;" withString:@"”"];
        
        tips = [[[[tips stringByReplacingOccurrencesOfString:[_item.title stringByAppendingString:@"描述"] withString:@""] stringByReplacingOccurrencesOfString:@"基本信息" withString:@"\n基本信息："] stringByReplacingOccurrencesOfString:@"温馨提示" withString:@"\n温馨提示："] stringByReplacingOccurrencesOfString:@"品牌介绍" withString:@"\n品牌介绍：\n"];
        
        size = [tips sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:withinSize lineBreakMode:UILineBreakModeWordWrap];
        UILabel *tipsLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, _totalHeight, 300, size.height)];
        tipsLabel.lineBreakMode = UILineBreakModeWordWrap;
        tipsLabel.numberOfLines = 0;
        tipsLabel.backgroundColor = [UIColor clearColor];
        tipsLabel.font = [UIFont systemFontOfSize:14];
        tipsLabel.text = tips;
        [self.dataScrollView addSubview:tipsLabel];
        _totalHeight += tipsLabel.frame.size.height + padding;
        [tipsLabel release];
    }    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)dealloc
{
    [_item release];
    [super dealloc];
}

- (void)addSlideImageView
{
    NSMutableArray *imagePathList = [[NSMutableArray alloc] init];
    for (NSString *image in _item.imageList) {
        if (image.length == 0) {
            break;
        }
        NSString *path = image;
        if (![image hasPrefix:@"http"]) {
            path = [DUREX_IMAGE_BASE_URL stringByAppendingString:image];
        }
        [imagePathList addObject:path];
    }
    
    SlideImageView *slideImageView = [[SlideImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 200)];
    slideImageView.defaultImage = @"3.png";
    
    [slideImageView.pageControl setPageIndicatorImageForCurrentPage:[UIImage strectchableImageName:@"point_pic3.png"] forNotCurrentPage:[UIImage strectchableImageName:@"point_pic4.png"]];
    [slideImageView setImages:imagePathList];
    [_dataScrollView addSubview:slideImageView];
    _totalHeight = slideImageView.frame.size.height;

    [imagePathList release];
    [slideImageView release];
}

@end
