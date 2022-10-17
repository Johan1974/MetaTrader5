#include <Trade/Trade.mqh> 

//+------------------------------------------------------------------+
//|                                                       Winner.mq5 |
//|                                  Copyright 2022, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+

#property copyright "Copyright 2022, MetaQuotes Ltd."
#property link      "https://www.mql5.com"
#property version   "1.00"

double Lots       =  0.01;
double LotFactor  =  2;

int TpPoints   =  100;
int SlPoints   =  100;
int Magic      =  123;           
CTrade trade;
bool isTradeAllowed = true;

//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
//---
    trade.SetExpertMagicNumber(Magic);
    
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

   //if ( isTradeAllowed) 
   if (PositionsTotal() == 0) 
   {
      Print("50 Trade Allowed");
      double ask = SymbolInfoDouble(_Symbol, SYMBOL_ASK);
      double tp = ask + TpPoints * _Point;
      double sl = ask - SlPoints * _Point;
      
      ask = NormalizeDouble(ask, _Digits);
      tp = NormalizeDouble(tp, _Digits);
      sl = NormalizeDouble(sl, _Digits);
             
      if (trade.Buy(Lots, _Symbol, ask, sl, tp)){
         isTradeAllowed = false;        
      }
   }
 }
  
 
  
 void  OnTradeTransaction( 
   const MqlTradeTransaction&    trans,     // trade transaction structure 
   const MqlTradeRequest&        request,   // request structure 
   const MqlTradeResult&         result     // response structure 
   )
   {  
      
       
      if (trans.type == TRADE_TRANSACTION_DEAL_ADD){
         CDealInfo deal;
         deal.Ticket(trans.deal);
         HistorySelect(TimeCurrent()-PeriodSeconds(PERIOD_D1),TimeCurrent()+10) ;
         if (deal.Magic() == Magic && deal.Symbol() == _Symbol){
            if (deal.Entry() == DEAL_ENTRY_OUT ){
            Print(__FUNCTION__, " > Closed Position # ", trans.position  );
               if (deal.Profit() > 0 ){
                  isTradeAllowed = true;
               }else{  
                  if (deal.DealType() == DEAL_TYPE_BUY){
                     double lots = deal.Volume() * LotFactor;
                     lots = NormalizeDouble(lots, 2);
                     
                     double ask = SymbolInfoDouble(_Symbol, SYMBOL_ASK);
                     double tp = ask + TpPoints * _Point;
                     double sl = ask - SlPoints * _Point;
                     
                     ask = NormalizeDouble(ask, _Digits);
                     tp = NormalizeDouble(tp, _Digits);
                     sl = NormalizeDouble(sl, _Digits);
                           
                     trade.Buy(lots, _Symbol, ask, sl, tp);
                     
                     
                  }else if (deal.DealType() == DEAL_TYPE_SELL){
                     Print("DealTypeSell" );
                     double lots = deal.Volume() * LotFactor;
                     lots = NormalizeDouble(lots, 2);
                     
                     double bid = SymbolInfoDouble(_Symbol, SYMBOL_BID);
                     double tp = bid - TpPoints * _Point;
                     double sl = bid + SlPoints * _Point;
                     
                     bid = NormalizeDouble(bid, _Digits);
                     tp = NormalizeDouble(tp, _Digits);
                     sl = NormalizeDouble(sl, _Digits);
                           
                     trade.Sell(lots, _Symbol, bid, sl, tp);
                  }   
              }    
                  
            }
         }
      }
   }
//+------------------------------------------------------------------+
