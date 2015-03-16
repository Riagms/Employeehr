//
//  RaceViewController.h
//  EmployeePortal
//
//  Created by GMSIndia1 on 7/26/13.
//  Copyright (c) 2013 GMSIndia1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Ethicity.h"
#import "SecondRaceViewController.h"
#import "racemdl.h"
#import "UserDetails.h"
#import "sqlite3.h"
@interface RaceViewController : UIViewController<UIPickerViewDelegate,UIPickerViewDataSource,UITextFieldDelegate>
{
    BOOL recordResults;
    BOOL buttonclicked;
        

}

/*For Sqlite Database*/
@property(strong,nonatomic) NSString *docsDir;
@property(strong,nonatomic) NSArray *dirPaths;
@property(nonatomic,readwrite) sqlite3*newEmplyhrListDB;
@property (strong, nonatomic) NSString *databasePath;
@property (strong, nonatomic) NSString *Availablityresult;
@property(strong,nonatomic)NSString *sqlitessn;
@property(strong,nonatomic)NSMutableArray *sqliteArray;
@property(strong,nonatomic)UserDetails*userdetails;



@property (strong, nonatomic) IBOutlet UIScrollView *scrollview;
@property(strong,nonatomic)racemdl *racemdl;
@property(strong,nonatomic)Ethicity *ethmdl;
@property(readwrite)NSInteger applicantId;
@property(strong,nonatomic)NSXMLParser *xmlParser;
@property(strong,nonatomic)NSMutableString *soapResults;
@property(strong,nonatomic)NSMutableData *webData;
@property(strong,nonatomic)SecondRaceViewController*secondVCtrl;

@property(strong,nonatomic)IBOutlet UISegmentedControl *isconvictSegment;
@property(strong,nonatomic)IBOutlet UITextField *convictExplanationText;
@property(strong,nonatomic)IBOutlet UITextField *twicnumberText;
@property(strong,nonatomic)IBOutlet UISegmentedControl *agelimitsegment;
@property(strong,nonatomic)IBOutlet UISegmentedControl *legalsrightssegment;
@property(strong,nonatomic)IBOutlet UISegmentedControl *workovertimesegment;
@property(strong,nonatomic)IBOutlet UISegmentedControl *workedearliersegment;
@property(strong,nonatomic)IBOutlet UITextField *workedperiodText;
@property(strong,nonatomic)IBOutlet UISegmentedControl *workoutoftownSegment;

@property(strong,nonatomic)IBOutlet UITextField *refferedagencyText;
@property(strong,nonatomic)IBOutlet UISegmentedControl *IsProtectedVeteransegment;
@property(strong,nonatomic)IBOutlet UISegmentedControl *isdisableSegment;
@property(strong,nonatomic)IBOutlet UISegmentedControl *IsVietnamEraSegment;
@property(strong,nonatomic)IBOutlet UISegmentedControl *IsActiveReservistSegment;
@property(strong,nonatomic)IBOutlet UISegmentedControl *IsDisabledVeteranSegment;
@property(strong,nonatomic)IBOutlet UISegmentedControl *IsSeperatedVeteranSegment;

-(IBAction)submitAction:(id)sender;

//segmentvalues

@property(readwrite)NSInteger isconvictvalue;
@property(readwrite)NSInteger agelimitvalue;
@property(readwrite)NSInteger legalrightsvalue;
@property(readwrite)NSInteger workedovertimevalue;
@property(readwrite)NSInteger workedearliervalue;
@property(readwrite)NSInteger workoutoftownvalue;
@property(readwrite)NSInteger IsProtectedVeteranValue;
@property(readwrite)NSInteger IsDisablevalue;
@property(readwrite)NSInteger IsVietnamEravalue;
@property(readwrite)NSInteger IsActiveReservistvalue;
@property(readwrite)NSInteger IsDisabledVeteranvalue;
@property(readwrite)NSInteger IsSeperatedVeteranvalue;
@property(strong,nonatomic)NSString *reffer;
@property(strong,nonatomic)UIPopoverController *popOverController1;
@property(strong,nonatomic)UITableView *popOverTableView;


@property(strong,nonatomic)IBOutlet UIButton *refferbtn;


-(IBAction)selectreffer:(id)sender;

//array

@property(strong,nonatomic)NSMutableArray *refferArray;
- (IBAction)nextbtn:(id)sender;


//iphone
@property(strong,nonatomic)IBOutlet UIScrollView *scroll_iphone;
@property(strong,nonatomic)IBOutlet UIPickerView *refferpicker_iphone;
@property(strong,nonatomic)NSMutableArray *refferArray_iphone;
@property(strong,nonatomic)IBOutlet UIButton *reffertext_iphone;

@property(strong,nonatomic)IBOutlet UISegmentedControl *isconvictSegment_iphone;
@property(strong,nonatomic)IBOutlet UITextField *convictExplanationText_iphone;
@property(strong,nonatomic)IBOutlet UITextField *twicnumberText_iphone;
@property(strong,nonatomic)IBOutlet UISegmentedControl *agelimitsegment_iphone;
@property(strong,nonatomic)IBOutlet UISegmentedControl *legalsrightssegment_iphone;
@property(strong,nonatomic)IBOutlet UISegmentedControl *workovertimesegment_iphone;
@property(strong,nonatomic)IBOutlet UISegmentedControl *workedearliersegment_iphone;
@property(strong,nonatomic)IBOutlet UITextField *workedperiodText_iphone;
@property(strong,nonatomic)IBOutlet UISegmentedControl *workoutoftownSegment_iphone;
@property(strong,nonatomic)IBOutlet UITextField *refferedagencyText_iphone;
- (IBAction)refferselect:(id)sender;
-(IBAction)textfieldshouldreturn:(id)sender;

- (IBAction)convictedsegmt:(id)sender;
- (IBAction)cmpnysgmnt:(id)sender;


@end
