# Changelog

## 1.2.0 - 2026-02-23

### Added
- Added support for all Lean minor versions from [v4.19.0] through [v4.28.0].

## [1.1.0] - 2026-02-23

### Added
- This CHANGELOG file.
- Added an entry to the JSON file recording the compatible Lean version.
- Added imports for all files to the root file to ensure CI works.

### Fixed
- **X-11**: Fixed reversed order of parameters in `MvPolynomial`.
- **X-77**: Added missing Noetherian condition.
- **X-86**: Fixed reversed order of parameters in `MvPolynomial`.

### Changed
- **X-54**: Updated the informal statement and comments to align with the formal statement. The formal statement is unaffected.
- Added a unique namespace to each problem to avoid conflicts from repeated definitions in CI.
- Corrected minor formatting issues in comments and standardized all comments to use `/-- ... -/`.

## [1.0.1] - 2025-11-22

### Added
- The JSON file now contains an entry for each new declaration introduced in every benchmark problem.

### Fixed
- Fixed shifted domain tags in the JSON file.
- Fixed sunburst chart for domain statistics.

## [1.0.0] - 2025-08-26

### Added
- First release of 100 FATE-H benchmark questions.
- A PDF file containing both natural language and formalization for human reading.
- A JSON file for machine reading.
- A sunburst chart for domain statistics.

[v4.28.0]: https://github.com/frenzymath/FATE-X/tree/v4.28.0
[v4.19.0]: https://github.com/frenzymath/FATE-X/tree/v4.19.0
[1.1.0]: https://github.com/frenzymath/FATE-X/tree/v4.19.0
[1.0.1]: https://github.com/frenzymath/FATE-X/tree/e054761e5d493806a13db4c5a8cbfc4d26f62624
[1.0.0]: https://github.com/frenzymath/FATE-X/tree/initial-release
