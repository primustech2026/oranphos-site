# ORANPHOS Content Sources and Data Status

This register separates manufacturer-supplied facts, public technical references, calculation outputs and illustrative placeholders. “Manufacturer-supplied” means the value came from the project brief or the source HTML; it is not independently verified.

## 1. Manufacturer-supplied company and commercial data

| Data used in copy | Value | Source category | Approval status |
|---|---:|---|---|
| Plant start / predecessor | 2009; Baoji Fenghui; Northwest China phosphate R&D/production claim | Manufacturer brief | Verify against business registration, plant records and approved company history |
| Capacity expansion | Capacity doubled in 2015 | Manufacturer brief | Verify against production/permit records |
| First exports | 2017 | Manufacturer brief | Verify against customs or shipment records |
| Reorganization investment | RMB 300 million in 2019 | Manufacturer brief | Verify against investment and legal records |
| Thermal acid line | 20,000 t/y; commissioned 2021; DCS/SIS/heat recovery | Manufacturer brief and source HTML | Verify against equipment, permit and commissioning records |
| Campus | 82 mu; Fengxiang, Baoji, Shaanxi | Manufacturer brief | Verify legal address and land record |
| Built area | 24,500 m² production; 5,000 m² R&D/office | Manufacturer brief | Verify construction/asset records |
| Product scope | 6 series; 20+ products | Manufacturer brief | Confirm current commercial catalogue |
| Salt capacity | 50,000 t/y across 4 lines | Manufacturer brief and source HTML | Confirm permitted and current operating capacity |
| MKP typical quality | ≥99%; 0.07% insolubles; 0.0014% chloride | Manufacturer brief and source HTML | Replace “typical” with live 10-lot evidence before production |
| Product range | MKP, DKP, UP 17-44-0, thermal H₃PO₄, TSP, DSP | Manufacturer brief | Confirm grade-specific specifications |
| Certifications | ISO 9001/14001/45001, MUI, Malaysia Halal, Star-K Kosher | Manufacturer brief | Verify holder, scope and expiry; replace source images |
| IP and credit | 15 patents; Shaanxi AAA | Manufacturer brief | Verify current certificates and approved wording |
| Export packing | 25 kg PE-lined bags; 40 bags/pallet; 1,000 bags/FCL = 25 t | Manufacturer brief | Confirm by destination, pallet type and container payload |
| Shipping | HS 2835.24; FOB Shanghai/Qingdao; 10–14 days | Manufacturer brief | Broker and sales confirmation required per shipment |
| Payment | 30/70 T/T against B/L copy | Manufacturer brief | Commercial-policy approval required |

## 2. Extracted source material

| Material | Source | Use |
|---|---|---|
| Original five-page copy, design tokens and layout | `oranphos_unified.html` in `primustech2026/oranphos-site` | Preserved in the split Home, MKP, Products, Quality and Contact pages |
| 21 unique embedded JPEGs | Base64 payloads in `oranphos_unified.html` | Extracted to `assets/img/`; 19 requested names plus `process-vessels.jpg` and `crystal-wide.jpg` |
| B01–B10 quality chart and COA cards | `oranphos_unified.html` | Preserved as illustrative content; not a live production record |
| Certificate-card imagery | `oranphos_unified.html` | Preserved for visual fidelity despite source image/label mismatch; replacement required |

## 3. Public agronomy and engineering references

| Topic | Public source | How it informed the copy |
|---|---|---|
| Calcium + phosphate precipitation and emitter clogging | [UF/IFAS: How to Reduce Clogging Problems in Fertigation](https://ask.ifas.ufl.edu/publication/HS1202) | Supports the no-mix rule, precipitation mechanism and jar-test recommendation |
| Two-stock system and calcium/phosphate separation | [UF/IFAS Greenhouse Vegetable Production Handbook, Vol. 3](https://ask.ifas.ufl.edu/publication/CV265) | Supports separate calcium and phosphate/sulfate stock tanks |
| Dilution ratios and A/B stock practice | [Penn State Extension: Hydroponics Systems—Nutrient Solution Programs and Recipes](https://extension.psu.edu/hydroponics-systems-nutrient-solution-programs-and-recipes) | Supports 50×/100×/200× concentrate context and separate injection |
| Injector configuration and precipitate chemistry | [University of Georgia Extension: Fertilizer Injectors](https://extension.uga.edu/publications/detail.html?number=B1237) | Supports dual heads, calcium-phosphate and calcium-sulfate incompatibility |
| Overnight jar-test concept | [UC Agriculture and Natural Resources: Maintenance of Microirrigation Systems](https://ucanr.edu/site/maintenance-microirrigation-systems/prevention-and-mitigation) | Supports using actual irrigation water and inspecting for cloud or sediment |
| Greenhouse fertilizer calculations and 0-52-34 conversion | [FAO: Good Agricultural Practices for Greenhouse Vegetable Crops](https://www.fao.org/3/i3284e/i3284e.pdf) | Supports P₂O₅/K₂O conversion logic and injector-based formulation context |
| GHS SDS purpose and structure | [UNECE: About the GHS](https://unece.org/about-ghs) and [GHS Rev. 11](https://unece.org/transport/dangerous-goods/ghs-rev11-2025) | Supports requesting a current GHS-format SDS in the import checklist |

## 4. Manufacturer-brochure / public chemical-reference values

| Data | Value used | Source status |
|---|---:|---|
| MKP solubility curve | 14.8 / 18.3 / 22.6 / 25.0 / 33.5 / 50.2 / 70.4 g per 100 g water at 0 / 10 / 20 / 25 / 40 / 60 / 80°C | Values supplied in the project brief and commonly published in fertilizer/chemical product literature; verify against the approved ORANPHOS TDS |
| DKP solubility | 168 g/100 g water at 20°C | Project brief / manufacturer-brochure reference; verify grade and basis |
| Urea phosphate solubility | 370 g/100 g water at 20°C | Project brief / manufacturer-brochure reference; verify grade and basis |
| Foliar concentration ranges | Vegetables 0.5–1.0%; fruit trees 1.0–2.0%; field crops 1.5–2.0%; caution above 2.5% | Project brief / public agronomy and manufacturer guidance; illustrative, crop-specific verification required |
| Tomato stage rates | 150–800 g MKP per 1,000 L by 5 stages | Project brief / manufacturer agronomy-program style reference; not a universal prescription |
| Practical B-tank ceiling | 15–20 kg MKP per 100 L | Project brief and solubility safety-margin calculation; verify at actual minimum temperature and full recipe |
| Nutrient conversion | 1 g/L MKP ≈ 0.52 g/L P₂O₅ + 0.34 g/L K₂O | Direct calculation from 0-52-34 declared analysis |

## 5. Direct calculations

| Calculation | Working | Status |
|---|---|---|
| Insoluble mass at 0.07% | 300 kg × 0.0007 = 0.210 kg = 210 g | Arithmetic derived from manufacturer typical value |
| Insoluble mass at 0.10% | 300 kg × 0.0010 = 0.300 kg = 300 g | Arithmetic derived from illustrative purchasing ceiling |
| Difference | 300 g − 210 g = 90 g | Arithmetic |
| Relative reduction | 90 g ÷ 300 g = 30% | Arithmetic against the 0.10% reference |
| 1.0% foliar solution | 1 kg per 100 L final solution; 5 kg per 500 L | Arithmetic |
| Mixed-container basis | 1,000 × 25 kg = 25,000 kg = 25 t | Arithmetic; verify legal payload and pallet plan |

## 6. Illustrative or placeholder content

- B01–B10 lot values and 2026 dates are illustrative placeholders inherited from the source HTML.
- Names shown as `[Name]` are placeholders.
- The WhatsApp number shown as `+86 ··· ···· ····` is a placeholder.
- Commodity comparison bands in `technology.html` are purchasing illustrations, not a universal specification.
- Relative price positions for MKP, DKP and urea phosphate are qualitative market placeholders; use current quotes for purchase decisions.
- About-page grey image blocks intentionally mark missing current certificates or approved corporate imagery.
- Foliar and fertigation rates are starting ranges for discussion, not crop prescriptions. Every article carries the required agronomist-verification disclaimer.
