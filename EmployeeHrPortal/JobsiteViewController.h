//
//  JobsiteViewController.h
//  EmployeeHrPortal
//
//  Created by GMSIndia1 on 9/5/13.
//  Copyright (c) 2013 GMSIndia1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "jobsite.h"
#import <QuartzCore/QuartzCore.h>
#import "BasicdetailsViewController.h"
#import "EducationViewController.h"
@interface JobsiteViewController : UIViewController<UITabBarDelegate,UITextFieldDelegate,UIPickerViewDataSource,UIPickerViewDelegate>
{
    BOOL buttonclicked;
    NSInteger Poptype;
    BOOL recordResults;
    NSInteger selectedcell;
    // NSInteger Applicantid;
    NSInteger basicPlus;
    NSInteger ncer;
    NSInteger webtype;
    NSInteger skillindex;
    NSInteger reldint;
    NSIndexPath*path;
    NSInteger newcell;
    NSString* selectedjobsite;
    NSString*skillstring,*skillid;
    NSInteger craftindex;
    NSInteger craftclckd,skillclckd;
  
    
}
/*for squlteDB*/

@property(strong,nonatomic) NSString *docsDir;
@property(strong,nonatomic) NSArray *dirPaths;
@property(nonatomic,readwrite) sqlite3*newEmplyhrListDB;
@property (strong, nonatomic) NSString *databasePath;
@property (strong, nonatomic) NSString *Availablityresult;
@property (strong, nonatomic)NSMutableArray *sqliteArray;
@property(strong,nonatomic)NSString *sqlitessn;


@property(readwrite)  NSInteger Applicantid;
@property (strong, nonatomic)NSString*Drugjobsiteid;
//@property(strong,nonatomic)ViewController*viewCntrl;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollview;
@property(strong,nonatomic)BasicdetailsViewController*basicVCtrl;
@property(strong,nonatomic)EducationViewController*educatnVCtrl;

//@property(strong,nonatomic)EmployeeViewController*employeeVCtrl;
//@property(strong,nonatomic)RaceViewController* raceVCtrl;
//@property(strong,nonatomic)NewMedicalViewController*newmedVCtrl;
//@property(strong,nonatomic)CourseDrugViewController*drugVctrl;
@property (strong, nonatomic) IBOutlet UIButton *clickedbtnlbl;
@property (strong, nonatomic) IBOutlet UITableView *listtable;
@property (strong, nonatomic) IBOutlet UITableView *selectedtable;
@property (strong, nonatomic) IBOutlet UITableViewCell *listtablecell;
@property (strong, nonatomic) IBOutlet UILabel *jobnamelbl;
@property(strong,nonatomic)IBOutlet UITextField *otherdesc;
@property (strong, nonatomic)NSString*selectedrow;

@property(strong,nonatomic)NSMutableArray *monthArray;
@property(strong,nonatomic)NSMutableArray *monthdictArray;
@property(strong,nonatomic)NSMutableDictionary *monthDictionary;
@property(strong,nonatomic)NSMutableDictionary *remonthDictionary;
@property(strong,nonatomic)NSMutableDictionary *rejobiddict;
@property(strong,nonatomic)NSMutableArray *yearArray;

@property (strong, nonatomic) IBOutlet UIButton *monthBtn;
@property (strong, nonatomic) IBOutlet UIButton *yearBtn;
@property (strong, nonatomic) IBOutlet UIButton *skillbtnlbl;

@property(strong,nonatomic)UIPopoverController *popOverController1;
@property(strong,nonatomic)UITableView *popOverTableView;

@property (strong, nonatomic) IBOutlet UIButton *craftbtnlbl;

@property (strong, nonatomic)jobsite*jobsite;
@property(strong,nonatomic)NSString *nw;
@property(strong,nonatomic)NSString *unitstring;
/*Xmlparser*/
@property(strong,nonatomic)NSXMLParser *xmlParser;
@property(strong,nonatomic)NSMutableString *soapResults;
@property(strong,nonatomic)NSMutableData *webData;
/*Arrays*/
@property(strong,nonatomic)NSMutableArray*jobsiteArray;
@property(strong,nonatomic)NSMutableArray *skillsArray;
@property(strong,nonatomic)NSMutableArray *craftsArray;
@property(strong,nonatomic)NSMutableDictionary*skilldict;
@property(strong,nonatomic)NSMutableArray *jobsitemodelarray;
@property(strong,nonatomic)NSMutableDictionary *jobiddict;
@property(strong,nonatomic)NSMutableDictionary *craftdict;
@property(strong,nonatomic)NSMutableDictionary *craftArraydict;
@property(strong,nonatomic)NSMutableDictionary *skillArraydict;
@property (strong, nonatomic) IBOutlet UITabBar *tabbar;
@property (strong, nonatomic) IBOutlet UITabBarItem *basicbtn;



@property(strong,nonatomic)NSString*creftid;
@property(strong,nonatomic)IBOutlet UISegmentedControl *basicPlussegment;
@property(strong,nonatomic)IBOutlet UISegmentedControl *ncerSegment;


//- (IBAction)employeebtn:(id)sender;

- (IBAction)continuebtn:(id)sender;
//- (IBAction)edubtn:(id)sender;
- (IBAction)medicalbtn:(id)sender;
//- (IBAction)basicbtn:(id)sender;
- (IBAction)clickbtn:(id)sender;
- (IBAction)SelectMonth:(id)sender;
- (IBAction)SelectYear:(id)sender;
- (IBAction)skillbtn:(id)sender;
- (IBAction)craftbtn:(id)sender;

//- (IBAction)race:(id)sender;
//- (IBAction)drugbtn:(id)sender;
-(IBAction)CancelAction:(id)sender;

- (IBAction)basicsegnt:(id)sender;

/*iphoneOutlets&Connections*/
@property (strong, nonatomic) IBOutlet UIScrollView *scroll_iphone;

@property (strong, nonatomic) IBOutlet UISegmentedControl *saftysegment_iphone;
@property (strong, nonatomic) IBOutlet UITextField *expirydatetxtfld_iphone;
@property (strong, nonatomic) IBOutlet UITableView *jobsitetable_iphone;
@property (strong, nonatomic) IBOutlet UIButton *checkbtnlbl_iphone;
@property (strong, nonatomic) IBOutlet UITextField *skilltextflield_iphone;
@property (strong, nonatomic) IBOutlet UITextField *crafttxtflield_iphone;
@property (strong, nonatomic) IBOutlet UISegmentedControl *nccersegment_iphone;
@property (strong, nonatomic) IBOutlet UITextField *Othrtraing_iphone;
@property (strong, nonatomic) IBOutlet UIDatePicker *datepicker_iphone;
- (IBAction)checkbtn_iphone:(id)sender;
- (IBAction)updatebtn_iphone:(id)sender;
-(IBAction)cancelaction_iphone:(id)sender;

@property (strong, nonatomic) IBOutlet UIPickerView *datapicker1;
-(IBAction)returnkey:(id)sender;
@property (strong, nonatomic) IBOutlet UIPickerView *datapicker2;

@end
