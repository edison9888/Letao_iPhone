//
//  GlobalConstants.h
//  Letao
//
//  Created by Kaibin on 13-2-13.
//  Copyright (c) 2013年 Kaibin. All rights reserved.
//

#ifndef Letao_GlobalConstants_h
#define Letao_GlobalConstants_h

#define RELEASE_SAFELY(__POINTER) { [__POINTER release]; __POINTER = nil; }

#define SERVER_URL  @"http://127.0.0.1:5000/api"
//#define SERVER_URL  @"http://42.96.134.32:8080/api"

#define DUREX_IMAGE_BASE_URL @"http://www.durex.com.cn"
#define CONDOM_BRAND_IMAGE_URL_PREFIX @"http://42.96.134.32/condom_brand_images/"

#define METHOD_ITEM @"item"

#define PARA_BRAND_ID   @"brand_id"

#define SINA_WEIBO_APP_KEY       @"617036183"
#define SINA_WEIBO_APP_SECRET    @"7079419c3608a680c4ad056b1cae9f6c"
#define kAppRedirectURI     @"http://"

#define WEIXIN_APP_KEY  @"wxcf2ade6cb40cd0b5"
#define UMENG_KEY @"51616d0a56240bd604004389"

#endif
