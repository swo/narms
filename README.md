- Downloaded from [NARMS Now](https://wwwn.cdc.gov/narmsnow/) website on 24 August 2017
- Cleaned up slightly into a tsv

I reshaped the original, wide table into a tidy, narrow table. Each isolate has multiple records. Each records shows something about antibiotic susceptibility testing. The original table had columns like "AZM Equiv", "AZM Rslt", etc. This table has these tidied into three columns:

- `drug` is "AZM"
- `metric` is "Equiv" or "Rslt"
- `measure` is the value in the cell
