# ORANPHOS Design QA

**Source visual truth**

- `docs/design-qa/source-unified-home-top.png`
- Source code: `oranphos_unified.html`

**Rendered implementation**

- `docs/design-qa/implementation-home-top.png`
- `docs/design-qa/comparison-home-side-by-side.png`
- Local route: `index.html`

**Normalization**

- Source viewport: 1440 × 1000 CSS px.
- Implementation viewport: 1440 × 1000 CSS px.
- Source pixels: 1440 × 1000.
- Implementation pixels: 1440 × 1000.
- Device scale factor: 1 for both source and implementation.
- State: Home route, top of page, desktop, reveal animation settled for 900 ms.
- The side-by-side comparison contains both equal-size screenshots in one comparison image.

## Findings

No actionable P0, P1 or P2 differences remain.

- Fonts and typography: Space Grotesk, Source Sans 3 and IBM Plex Mono load in both captures. Hero size, weight, line height, letter spacing and wrapping match the source. The expanded 8-item navigation uses the same body treatment at a slightly tighter horizontal density, which is intentional.
- Spacing and layout rhythm: Hero grid, image crop, specification chips, CTA spacing, stat rows, 10 px radii and shadow treatment match the source. The added WA control is intentionally outside the source layout and does not cover hero content.
- Colors and visual tokens: `--ink`, `--navy`, `--amber`, paper, soft background, borders and shadow values are the extracted source tokens. The requested `saturate(.93) contrast(1.05)` image treatment creates a small intentional image change.
- Image quality and asset fidelity: The robot-palletizer hero image was extracted from the source base64 payload, not recreated. All 21 unique payloads were preserved as JPEG assets; the requested 19 semantic names are present, with 2 extra source images retained.
- Copy and content: Home content is unchanged apart from standalone metadata, expanded navigation/footer and the requested fixed controls.
- Interaction states: navigation, MKP lot tabs, 60%-scroll fixed CTA, WA contact link and reveal animation were tested in Chrome. B09 updates assay to 99.1%, insolubles to 0.08% and chloride to 0.0012%.
- Responsiveness: Home, About, Technology, Resources, an article and a tool were checked at 390 × 844. Each reported 390 px document width with no page-level horizontal overflow. Tables retain scoped horizontal scrolling on mobile.
- Accessibility: semantic navigation, headings, article tables, alt text, focusable links and reduced-motion handling are present. The fixed CTA and WA control remain separated at mobile size.

## Comparison history

- Initial browser capture occurred before the 700 ms `.rv` reveal transition completed, so the implementation appeared dimmed. This was a capture-state mismatch, not a design defect.
- Both source and implementation were recaptured in the same Chrome tab, at the same 1440 × 1000 viewport and after a 900 ms stabilization wait.
- The stable side-by-side comparison shows the source and implementation hero at matching scale, crop, spacing, type hierarchy and token colors.

## Focused evidence

- Full-view comparison: `docs/design-qa/comparison-home-side-by-side.png`.
- Source hero detail: `docs/design-qa/source-unified-home-top.png`.
- Implementation hero detail: `docs/design-qa/implementation-home-top.png`.
- New-page desktop checks: `docs/design-qa/about-desktop.png`, `technology-desktop.png`, `resources-desktop.png`, `article-desktop.png`, `tool-desktop.png`.
- Responsive checks: `docs/design-qa/resources-mobile.png`, `fixed-cta-mobile.png`.
- A separate crop was not needed because the 1440 × 1000 source and implementation screenshots preserve readable navigation, hero type, CTA, image chips and stat rows at 1:1 density.

## Browser checks

- Primary navigation: Products → Resources route completed.
- MKP batch control: B09 button selected and all 3 displayed batch values updated.
- Fixed conversion bar: hidden at 46.1% scroll and shown at 65.5% scroll; WA bottom offset moved from 18 px to 90 px.
- Console errors: none recorded.
- Local-link validation: all 17 production HTML pages passed the filesystem link checker.

## Follow-up polish

- P3: Replace the 4 mismatched source certificate images with approved, current certificate scans.
- P3: Replace `[Name]` and the WhatsApp number placeholder when the client approves public contact details.

## Implementation checklist

- [x] Preserve extracted visual tokens and source imagery.
- [x] Keep original five page layouts intact after splitting.
- [x] Apply requested hover, reveal, image and fixed-CTA upgrades.
- [x] Verify desktop and 390 px mobile layouts.
- [x] Verify core links, batch switcher and browser console.

final result: passed
