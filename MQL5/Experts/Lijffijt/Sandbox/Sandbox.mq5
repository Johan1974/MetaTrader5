//+------------------------------------------------------------------+
//|                                                      Sandbox.mq5 |
//|                                  Copyright 2022, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2022, MetaQuotes Ltd."
#property link      "https://www.mql5.com"
#property version   "1.00"
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
//---
   
//---
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
//---
   
  }
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
  {
//---


      Print("New Bar");
      
      if (NewBar()) {
      
         datetime THISTIME    = iTime  (Symbol(),PERIOD_M5, 1);   
         double   THISOPEN    = iOpen  (_Symbol, PERIOD_M5, 1);
         double   THISHIGH    = iHigh  (_Symbol, PERIOD_M5, 1);
         double   THISLOW     = iLow   (_Symbol, PERIOD_M5, 1);
         double   THISCLOSE   = iClose (_Symbol, PERIOD_M5, 1);
         
         datetime PREVTIME    = iTime  (Symbol(),PERIOD_M5, 2);   
         double   PREVOPEN    = iOpen  (_Symbol, PERIOD_M5, 2);
         double   PREVHIGH    = iHigh  (_Symbol, PERIOD_M5, 2);
         double   PREVLOW     = iLow   (_Symbol, PERIOD_M5, 2);
         double   PREVCLOSE   = iClose (_Symbol, PERIOD_M5, 2);
      
      
      
      
         //--- Set the line drawing 
         PlotIndexSetInteger(0,PLOT_DRAW_TYPE,DRAW_LINE); 
         //--- Set the style line 
         PlotIndexSetInteger(0,PLOT_LINE_STYLE,STYLE_DOT); 
         //--- Set line color 
         PlotIndexSetInteger(0,PLOT_LINE_COLOR,clrRed); 
         //--- Set line thickness 
         PlotIndexSetInteger(0,PLOT_LINE_WIDTH,1); 
         PlotIndexSetInteger(0,PLOT_ARROW_SHIFT,0);
      
   }      
      //if  (PREVCLOSE == THISOPEN){
       
     //     }
         
   
   
  }
  
 bool NewBar() {
 
   static datetime previous_time = 0;
   datetime currenttime = iTime(_Symbol, PERIOD_M5, 0);
   if (previous_time != currenttime) {
      previous_time = currenttime; 
      return true;
   }  
  return false;    
  }
  
  
  
  
//+------------------------------------------------------------------+
