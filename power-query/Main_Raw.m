let
    Source = Csv.Document(File.Contents(RawFolder & "Main.csv"), [Delimiter = ",", Columns = 25, Encoding = 65001, QuoteStyle = QuoteStyle.Csv]),
  #"Promoted headers" = Table.PromoteHeaders(Source, [PromoteAllScalars = true]),
  #"Changed column type" = Table.TransformColumnTypes(#"Promoted headers", {{"Reporting starts", type text}, {"Reporting ends", type text}, {"Campaign name", type text}, {"Campaign delivery", type text}, {"Attribution setting", type text}, {"Results", type text}, {"Result indicator", type text}, {"Reach", type text}, {"Frequency", type text}, {"Cost per results", type text}, {"Ad set budget", type text}, {"Ad set budget type", type text}, {"Amount spent (EGP)", type text}, {"Ends", type text}, {"Impressions", type text}, {"CPM (cost per 1,000 impressions) (EGP)", type text}, {"Link clicks", type text}, {"shop_clicks", type text}, {"CPC (cost per link click) (EGP)", type text}, {"CTR (link click-through rate)", type text}, {"Clicks (all)", type text}, {"CTR (all)", type text}, {"CPC (all) (EGP)", type text}, {"Landing page views", type text}, {"Cost per landing page view (EGP)", type text}})
in
    #"Changed column type"
