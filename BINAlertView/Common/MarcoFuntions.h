//
//  MarcoFuntions.h
//  BINAlertView
//
//  Created by hsf on 2018/3/1.
//  Copyright © 2018年 hsf. All rights reserved.
//

#ifndef MarcoFuntions_h
#define MarcoFuntions_h

#ifdef DEBUG
#define DDLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#define DDLog(...)
#endif


#endif /* MarcoFuntions_h */
