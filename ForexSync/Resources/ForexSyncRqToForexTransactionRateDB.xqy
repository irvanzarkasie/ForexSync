xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://TargetNamespace.com/ForexSync";
(:: import schema at "ForexSyncCSV.xsd" ::)
declare namespace ns2="http://xmlns.oracle.com/pcbpel/adapter/db/top/ForexSyncBS";
(:: import schema at "ForexSyncBS_table.xsd" ::)

declare variable $source as element() (:: schema-element(ns1:ForexRateList) ::) external;

declare function local:func($source as element() (:: schema-element(ns1:ForexRateList) ::)) as element() (:: schema-element(ns2:ForexrateCollection) ::) {
    <ns2:ForexrateCollection>
        {
            for $ForexRate in $source/ns1:ForexRate
            return 
            <ns2:Forexrate>
              <ns2:currencyCode>{fn:data($ForexRate/ns1:QuoteName)}</ns2:currencyCode>
              <ns2:dailyDate>
                {
                  fn:concat(
                    fn:substring($ForexRate/ns1:Date, 1, 4),"-",
                    fn:substring($ForexRate/ns1:Date, 5, 2),"-",
                    fn:substring($ForexRate/ns1:Date, 7, 2)
                  )
                }
              </ns2:dailyDate>
              <ns2:pointValue>10</ns2:pointValue>
              <ns2:baseCurrencyCode>IDR</ns2:baseCurrencyCode>
              <ns2:txBuyRate>
              {
                if (data($ForexRate/ns1:High) ne "") then fn:number($ForexRate/ns1:High)
                else ""
              }
              </ns2:txBuyRate>
              <ns2:txMidRate>
              {
                if (data($ForexRate/ns1:High) ne "" and data($ForexRate/ns1:Low) ne "") then (fn:number($ForexRate/ns1:High) + fn:number($ForexRate/ns1:Low)) div 2
                else ""
              }
              </ns2:txMidRate>
              <ns2:txSellRate>
              {
                if (data($ForexRate/ns1:Low) ne "") then fn:number($ForexRate/ns1:Low)
                else ""
              }
              </ns2:txSellRate>
              <ns2:pairCurrencyCode>{fn:data($ForexRate/ns1:QuoteName)}</ns2:pairCurrencyCode>
            </ns2:Forexrate>
        }</ns2:ForexrateCollection>
};

local:func($source)
