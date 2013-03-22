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
#import "CommentCell.h"
#import "UIImage+Scale.h"
#import "CommentViewController.h"
#import "CommentService.h"

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
        _commentList = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)viewDidAppear:(BOOL)animated
{
    [self loadComments];
    self.hidesBottomBarWhenPushed = YES;
    [super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)dealloc
{
    [_dataScrollView release], _dataScrollView = nil;
    [_commentTableView release], _commentTableView = nil;
    [_commentButton release], _commentButton = nil;
    [_commentList release], _commentList = nil;
    [super dealloc];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    _dataScrollView = nil;
    _commentTableView = nil;
    _commentButton = nil;
    _commentList = nil;
    _item = nil;
}

//#define TITLE_COLOR [UIColor colorWithRed:37.0/255.0 green:66.0/255.0 blue:80/255.0 alpha:1.0]
//#define DESCRIPTION_COLOR [UIColor colorWithRed:74.0/255.0 green:74.0/255.0 blue:74.0/255.0 alpha:1.0]
//#define BG_COLOR [UIColor colorWithRed:222/255.0 green:239/255.0 blue:247/255.0 alpha:1.0]
#define TITLE_COLOR [UIColor blackColor]
#define DESCRIPTION_COLOR [UIColor blackColor]
#define BG_COLOR [UIColor colorWithWhite:1 alpha:0.3f]

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIButton *backButton = [[[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)] autorelease];
    [backButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(clickBack:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[[UIBarButtonItem alloc] initWithCustomView:backButton] autorelease];
    
    UIView *rightBarView = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, 90, 24)] autorelease];
    UIButton *commentButon = [[[UIButton alloc] initWithFrame:CGRectMake(0, 0, 24, 24)] autorelease];
    UIButton *favouriteButon = [[[UIButton alloc] initWithFrame:CGRectMake(34, 0, 24, 24)] autorelease];
    UIButton *shareButon = [[[UIButton alloc] initWithFrame:CGRectMake(68, 0, 24, 24)] autorelease];
    
    [commentButon setImage:[UIImage imageNamed:@"edit@2x"] forState:UIControlStateNormal];
    [favouriteButon setImage:[UIImage imageNamed:@"favourite"] forState:UIControlStateNormal];
    [shareButon setImage:[UIImage imageNamed:@"share"] forState:UIControlStateNormal];
    [favouriteButon addTarget:self action:@selector(clickFavourite:) forControlEvents:UIControlEventTouchUpInside];
    [shareButon addTarget:self action:@selector(clickShare:) forControlEvents:UIControlEventTouchUpInside];
    [commentButon addTarget:self action:@selector(addComment:) forControlEvents:UIControlEventTouchUpInside];
    
    [rightBarView addSubview:favouriteButon];
    [rightBarView addSubview:shareButon];
    [rightBarView addSubview:commentButon];
    
    UIBarButtonItem *rightBarButtonItem = [[[UIBarButtonItem alloc] initWithCustomView:rightBarView] autorelease];
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;

    self.title = @"详情";

    self.view.backgroundColor = BG_COLOR;
    
    [self addSlideImageView];
    
    [self addDetailView];
    
    [self addCommentSectionView];
        
    [_dataScrollView setContentSize:CGSizeMake(self.view.frame.size.width, _totalHeight)];
    
}

- (void)loadComments
{
    [self.commentList removeAllObjects];
    [_commentButton removeFromSuperview];
    _totalHeight -= _commentTableView.frame.size.height;
    [[CommentService sharedService] findCommentsWithItemId:_item._id delegate:self];
}

- (void)clickBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)clickFavourite:(id)sender
{
    ItemManager *itemManager = [ItemManager sharedManager];
    MBProgressHUD *HUD =[[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    if ([itemManager existItemInFavourites:self.item]) {
        HUD.labelText = @"已经喜欢过了！";
    } else {
        [itemManager addItemIntoFavourites:self.item];
        HUD.labelText = @"成功添加到我的喜欢！";
        HUD.customView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tick"]] autorelease];
    }
    HUD.mode = MBProgressHUDModeCustomView;
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
    
    UIButton *shareButton = [[UIButton alloc] initWithFrame:CGRectMake((self.view.frame.size.width+30)/2, 5, 93, 29)];
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
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, _totalHeight, 320, 30)];
    UIImage *bgImage = [UIImage imageNamed:@"section-bar2"];
    bgView.backgroundColor = [UIColor colorWithPatternImage:bgImage];
    [_dataScrollView addSubview:bgView];
    [bgView release];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, _totalHeight, 310, 30)];
    titleLabel.font = [UIFont systemFontOfSize:15];
    titleLabel.textColor = TITLE_COLOR;
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.text =  [NSString stringWithFormat:(@" %@"),_item.title];
    [self.dataScrollView addSubview:titleLabel];
    _totalHeight += titleLabel.frame.size.height + padding;
    [titleLabel release];
    
    NSString *subtitle = _item.subtitle;
    if ([subtitle length] > 0) {
        UILabel *subtitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, _totalHeight, 300, 20)];
        subtitleLabel.backgroundColor = [UIColor clearColor];
        subtitleLabel.font = [UIFont systemFontOfSize:14];
        subtitleLabel.textColor = DESCRIPTION_COLOR;
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
    descriptionLabel.textColor = DESCRIPTION_COLOR;
    descriptionLabel.text = description;
    [self.dataScrollView addSubview:descriptionLabel];
    _totalHeight += descriptionLabel.frame.size.height + padding;
    [descriptionLabel release];
    
    if ([_item.price length] > 0) {
        UILabel *priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, _totalHeight, 300, 20)];
        priceLabel.backgroundColor = [UIColor clearColor];
        priceLabel.font = [UIFont systemFontOfSize:14];
        priceLabel.textColor = DESCRIPTION_COLOR;
        priceLabel.text =  [@"推荐报价" stringByAppendingFormat:@": %@",_item.price];;
        [self.dataScrollView addSubview:priceLabel];
        _totalHeight += priceLabel.frame.size.height + padding;
        [priceLabel release];
    }
    
    NSString *smooth_index = _item.smooth_index;
    if ([smooth_index length] > 0) {
        UILabel *smooth_indexLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, _totalHeight, 300, 30)];
        smooth_indexLabel.backgroundColor = [UIColor clearColor];
        smooth_indexLabel.font = [UIFont systemFontOfSize:14];
        smooth_indexLabel.text =  smooth_index;
        smooth_indexLabel.textColor = DESCRIPTION_COLOR;
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
    informationLabel.textColor = DESCRIPTION_COLOR;
    informationLabel.text = information;
    [self.dataScrollView addSubview:informationLabel];
    _totalHeight += informationLabel.frame.size.height + padding;
    [informationLabel release];
    
    NSString *tips = _item.tips;
    if ([tips length] > 0) {
        tips = _item.tips;
//        tips = [[_item.tips stringByReplacingOccurrencesOfString:@"●" withString:@"\n●"] stringByReplacingOccurrencesOfString:@"【" withString:@"\n【"];
//        tips = [[[[[[tips stringByReplacingOccurrencesOfString:@"&plusmn;" withString:@"±"] stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@""] stringByReplacingOccurrencesOfString:@"&ldquo;" withString:@"“"]stringByReplacingOccurrencesOfString:@"&rdquo;" withString:@"”"]stringByReplacingOccurrencesOfString:@"&mdash;" withString:@"—"]stringByReplacingOccurrencesOfString:@"&quot;" withString:@"”"];
//        
//        tips = [[[[tips stringByReplacingOccurrencesOfString:[_item.title stringByAppendingString:@"描述"] withString:@""] stringByReplacingOccurrencesOfString:@"基本信息" withString:@"\n基本信息："] stringByReplacingOccurrencesOfString:@"温馨提示" withString:@"\n温馨提示："] stringByReplacingOccurrencesOfString:@"品牌介绍" withString:@"\n品牌介绍：\n"];
        
        size = [tips sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:withinSize lineBreakMode:UILineBreakModeWordWrap];
        UILabel *tipsLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, _totalHeight, 300, size.height)];
        tipsLabel.lineBreakMode = UILineBreakModeWordWrap;
        tipsLabel.numberOfLines = 0;
        tipsLabel.backgroundColor = [UIColor clearColor];
        tipsLabel.font = [UIFont systemFontOfSize:14];
        tipsLabel.textColor = DESCRIPTION_COLOR;
        tipsLabel.text = tips;
        [self.dataScrollView addSubview:tipsLabel];
        _totalHeight += tipsLabel.frame.size.height + padding;
        [tipsLabel release];
    }
    
//    UIView *separatorLineView = [[[UIView alloc]initWithFrame:CGRectMake(0, _totalHeight, 320, 2)] autorelease];
//    separatorLineView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"separator"]];
//    [self.dataScrollView addSubview:separatorLineView];
//    _totalHeight += separatorLineView.frame.size.height;
}

- (void)addCommentSectionView
{
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, _totalHeight, 320, 30)];
    UIImage *bgImage = [UIImage imageNamed:@"section-bar2"];
//    bgImage = [bgImage scaleToSize:CGSizeMake(320, 40)];
    bgView.backgroundColor = [UIColor colorWithPatternImage:bgImage];
    [_dataScrollView addSubview:bgView];
    [bgView release];

    float padding = 5;
    UILabel *commentLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, _totalHeight, 300, 30)];
    commentLabel.font = [UIFont systemFontOfSize:15];
    commentLabel.textColor = TITLE_COLOR;
    commentLabel.backgroundColor = [UIColor clearColor];        
    commentLabel.text = @"相关评论";
    _totalHeight += commentLabel.frame.size.height + padding;
    [_dataScrollView addSubview:commentLabel];
    [commentLabel release];
        
    _commentTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, _totalHeight, self.view.frame.size.width, 0)];
    _commentTableView.delegate = self;
    _commentTableView.dataSource = self;
    [_commentTableView setBackgroundColor:BG_COLOR];
    _commentTableView.bounces = NO;
    _commentTableView.scrollEnabled = NO;
    
    [_dataScrollView addSubview:_commentTableView];
}

- (void)addComment:(id)sender
{
    CommentViewController *controller = [[[CommentViewController alloc] init] autorelease];
    controller.item_id = _item._id;
    [self.navigationController pushViewController:controller animated:YES];
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
    slideImageView.defaultImage = @"photo-placeholder";
    
    [slideImageView.pageControl setPageIndicatorImageForCurrentPage:[UIImage strectchableImageName:@"point_pic3.png"] forNotCurrentPage:[UIImage strectchableImageName:@"point_pic4.png"]];
    [slideImageView setImages:imagePathList];
    [_dataScrollView addSubview:slideImageView];
    _totalHeight = slideImageView.frame.size.height;

    [imagePathList release];
    [slideImageView release];
}

#pragma mark -
#pragma mark TableView Delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger size;
    if ([_commentList count] > 0) {
        size = [_commentList count];
    } else {
        size = 0;
    }
    return size;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [CommentCell heightForCell];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CommentCell";
    
    CommentCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[CommentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    [cell setBackgroundColor:BG_COLOR];
    
    if ([_commentList count] > 0) {
        Comment *comment = [_commentList objectAtIndex:indexPath.row];
        [cell setComment:comment];
    }
    return cell;
}

#pragma mark -
#pragma mark - RKObjectLoaderDelegate

- (void)request:(RKRequest*)request didLoadResponse:(RKResponse*)response {
    NSLog(@"Response code: %d", [response statusCode]);
}

- (void)objectLoader:(RKObjectLoader *)objectLoader didFailWithError:(NSError *)error
{
    NSLog(@"Error: %@", [error localizedDescription]);
}

- (void)objectLoader:(RKObjectLoader *)objectLoader didLoadObjects:(NSArray *)objects
{
    [_commentList addObjectsFromArray:objects];
    NSLog(@"***Total comments count: %d", [_commentList count]);
    [_commentTableView reloadData];
    
    NSInteger size = [_commentList count];
    if (size == 0)
    {
//        _helpLabel = [[[UILabel alloc] initWithFrame:CGRectMake(20, _totalHeight, 300, 30)] autorelease];
//        _helpLabel.backgroundColor = [UIColor clearColor];
//        _helpLabel.hidden = NO;
//        NSString* text = @"暂无相关评论";
//        _helpLabel.numberOfLines = 0;
//        _helpLabel.textAlignment = UITextAlignmentCenter;
//        _helpLabel.text = text;
//        _helpLabel.font = [UIFont systemFontOfSize:14];
//        [_dataScrollView addSubview:_helpLabel];
//        _totalHeight += _helpLabel.frame.size.height;
        
    } else {
        [self.commentTableView setFrame:CGRectMake(0, _totalHeight, self.view.frame.size.width, size*[CommentCell heightForCell])];
        [_dataScrollView setContentSize:CGSizeMake(self.view.frame.size.width, _totalHeight)];
        _totalHeight += size*[CommentCell heightForCell];
    }
    
    _commentButton = [[UIButton alloc] initWithFrame:CGRectMake(125, _totalHeight+5, 80, 30)];
    [_commentButton setBackgroundImage:[UIImage imageNamed:@"favorites@2x"] forState:UIControlStateNormal];
    [_commentButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_commentButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [_commentButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 12, 0, 0)];
    [_commentButton setTitle:@"评论" forState:UIControlStateNormal];
    
    [_commentButton addTarget:self action:@selector(addComment:) forControlEvents:UIControlEventTouchUpInside];
    [_dataScrollView addSubview:_commentButton];
    [_dataScrollView setContentSize:CGSizeMake(self.view.frame.size.width, _totalHeight+_commentButton.frame.size.height+10)];
}

@end
