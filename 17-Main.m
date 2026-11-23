let
    Source = Main_Raw,
    Typed = Table.TransformColumns(Source, {{"Results", each if _ = null or _ = "" then null else Number.FromText(_, "en-US"), type number},
        {"Reach", each if _ = null or _ = "" then null else Number.FromText(_, "en-US"), type number},
        {"Frequency", each if _ = null or _ = "" then null else Number.FromText(_, "en-US"), type number},
        {"Cost per results", each if _ = null or _ = "" then null else Number.FromText(_, "en-US"), type number},
        {"Amount spent (EGP)", each if _ = null or _ = "" then null else Number.FromText(_, "en-US"), type number},
        {"Impressions", each if _ = null or _ = "" then null else Number.FromText(_, "en-US"), type number},
        {"CPM (cost per 1,000 impressions) (EGP)", each if _ = null or _ = "" then null else Number.FromText(_, "en-US"), type number},
        {"Link clicks", each if _ = null or _ = "" then null else Number.FromText(_, "en-US"), type number},
        {"CPC (cost per link click) (EGP)", each if _ = null or _ = "" then null else Number.FromText(_, "en-US"), type number},
        {"CTR (link click-through rate)", each if _ = null or _ = "" then null else Number.FromText(_, "en-US"), type number},
        {"Clicks (all)", each if _ = null or _ = "" then null else Number.FromText(_, "en-US"), type number},
        {"CTR (all)", each if _ = null or _ = "" then null else Number.FromText(_, "en-US"), type number},
        {"CPC (all) (EGP)", each if _ = null or _ = "" then null else Number.FromText(_, "en-US"), type number},
        {"Landing page views", each if _ = null or _ = "" then null else Number.FromText(_, "en-US"), type number},
        {"Cost per landing page view (EGP)", each if _ = null or _ = "" then null else Number.FromText(_, "en-US"), type number},
        {"Reporting starts", each Date.FromText(_, [Format="M/d/yyyy", Culture="en-US"]), type date},
        {"Reporting ends", each Date.FromText(_, [Format="M/d/yyyy", Culture="en-US"]), type date}}),
    Family = Table.TransformColumnTypes(Table.AddColumn(Typed, "Campaign Family", each if Text.StartsWith([Campaign name], "Sales") then "Sales" else if Text.StartsWith([Campaign name], "Conversion") then "Conversion" else if Text.StartsWith([Campaign name], "Catalogue") or Text.StartsWith([Campaign name], "Catalouge") then "Catalogue" else if Text.StartsWith([Campaign name], "Easyorders") then "Easyorders" else if Text.StartsWith([Campaign name], "Awar") then "Awareness" 
else "Other"), {{"Campaign Family", type text}}),
    Budget = Table.TransformColumnTypes(Table.AddColumn(Family, "Budget Numeric", each if [Ad set budget] = "Using ad set budget" or [Ad set budget] = null then 0 else Number.FromText([Ad set budget], "en-US")), {{"Budget Numeric", type number}}),
  #"Choose columns" = Table.SelectColumns(Budget, {"Campaign name", "Attribution setting", "Results", "Result indicator", "Reach", "Frequency", "Amount spent (EGP)", "Impressions", "Link clicks", "Clicks (all)", "Landing page views", "Campaign Family", "Budget Numeric"}),
  #"Filtered rows" = Table.SelectRows(#"Choose columns", each ([#"Amount spent (EGP)"] <> 0)),
  #"Reordered columns" = Table.ReorderColumns(#"Filtered rows", {"Campaign name", "Campaign Family", "Attribution setting", "Results", "Result indicator", "Reach", "Frequency", "Amount spent (EGP)", "Impressions", "Link clicks", "Clicks (all)", "Landing page views", "Budget Numeric"})
in
    #"Reordered columns"