xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://TargetNamespace.com/ForexSync";
(:: import schema at "ForexSyncCSV.xsd" ::)
declare namespace ns2="http://xmlns.oracle.com/pcbpel/adapter/db/top/ForexSyncBS";
(:: import schema at "ForexSyncSchema.xsd" ::)

declare variable $source as element() (:: schema-element(ns1:ForexRateList) ::) external;

declare function local:func($source as element() (:: schema-element(ns1:ForexRateList) ::)) as element() (:: schema-element(ns2:ForexrateCollection) ::) {
    <ns2:ForexrateCollection>
        {
            for $ForexRate in $source/ns1:ForexRate
            return 
            <ns2:Forexrate>
              <ns2:currencyCode>{fn:data($ForexRate/ns1:QuoteName)}</ns2:currencyCode>
              <ns2:dailyDate>{fn:data($ForexRate/ns1:Date)}</ns2:dailyDate>
              <ns2:pointValue>10</ns2:pointValue>
              <ns2:baseCurrencyCode>IDR</ns2:baseCurrencyCode>
              <ns2:txBuyRate></ns2:txBuyRate>
              <ns2:txMidRate></ns2:txMidRate>
              <ns2:txSellRate></ns2:txSellRate>
              <ns2:ukaBuyRate></ns2:ukaBuyRate>
              <ns2:ukaMidRate></ns2:ukaMidRate>
              <ns2:ukaSellRate></ns2:ukaSellRate>
              <ns2:balanceRate></ns2:balanceRate>
              <ns2:pairCurrencyCode></ns2:pairCurrencyCode>
              <ns2:pairRate></ns2:pairRate>
              <ns2:avcAmount></ns2:avcAmount>
              <ns2:specialBuyRate></ns2:specialBuyRate>
              <ns2:specialMidRate></ns2:specialMidRate>
              <ns2:specialSellRate></ns2:specialSellRate>
            </ns2:Forexrate>
        }</ns2:ForexrateCollection>
};

local:func($source)
