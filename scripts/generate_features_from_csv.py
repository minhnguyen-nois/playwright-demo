"""
Generate Gherkin .feature files from the AgentsIQ CSV file.

Focus columns:
- D: Feature
- E: Background
- F: Scenario
- G: Descriptions (gherkin steps)

The script groups scenarios by Feature and writes one .feature file per
feature into features/generated/.
"""

from __future__ import annotations

import csv
import re
from pathlib import Path
from typing import Dict, List, Optional, Tuple


CSV_PATH = Path(r"C:\Users\MinhNguyenThanh\Downloads\AgentsIQ - Test Case - Gherkin syntax(WI or Feature No.csv")
OUTPUT_DIR = Path("features/generated")


def slugify(name: str) -> str:
    """Convert a feature name to a filesystem-friendly slug."""
    slug = re.sub(r"[^a-zA-Z0-9]+", "-", name.strip().lower())
    slug = re.sub(r"-{2,}", "-", slug).strip("-")
    return slug or "feature"


def find_header(reader: csv.reader) -> Tuple[List[str], int, int, int, int]:
    """
    Locate the header row that contains the Feature/Background/Scenario/Descriptions
    columns and return the header plus their indexes.
    """
    for row in reader:
        if any(cell.strip() == "Feature" for cell in row):
            feature_idx = row.index("Feature")
            background_idx = row.index("Background")
            scenario_idx = row.index("Scenario")
            description_idx = row.index("Descriptions")
            return row, feature_idx, background_idx, scenario_idx, description_idx
    raise ValueError("Could not find header row with Feature/Background/Scenario/Descriptions columns.")


def parse_background(raw: str) -> Optional[Tuple[Optional[str], List[str]]]:
    """Normalize background text into optional title and a list of steps."""
    if not raw:
        return None
    lines = [ln.strip() for ln in raw.replace("\r", "\n").splitlines() if ln.strip()]
    if not lines:
        return None
    title: Optional[str] = None
    first = lines[0]
    if first.lower().startswith("background:"):
        title = first[len("background:") :].strip() or None
        lines = lines[1:]
    return title, lines


def normalize_steps(text: str) -> List[str]:
    """Split multiline step text and trim blank lines."""
    if not text:
        return []
    return [ln.strip() for ln in text.replace("\r", "\n").splitlines() if ln.strip()]


def main() -> None:
    OUTPUT_DIR.mkdir(parents=True, exist_ok=True)

    # Some cells contain non-UTF8 bytes; fall back to cp1252 and replace errors.
    with CSV_PATH.open(newline="", encoding="utf-8-sig", errors="replace") as f:
        reader = csv.reader(f)
        header, feature_idx, background_idx, scenario_idx, description_idx = find_header(reader)

        features: Dict[str, Dict[str, object]] = {}
        current_feature: Optional[str] = None

        for row in reader:
            # Skip rows that don't have the needed columns
            if len(row) <= max(feature_idx, background_idx, scenario_idx, description_idx):
                continue

            feature_val = row[feature_idx].strip()
            if feature_val:
                current_feature = feature_val
            if not current_feature:
                continue

            background_val = row[background_idx].strip()
            scenario_val = row[scenario_idx].strip()
            description_val = row[description_idx]

            # Skip rows without a scenario and without steps
            if not scenario_val and not description_val.strip():
                continue

            feature_entry = features.setdefault(
                current_feature,
                {"background_raw": None, "scenarios": []},
            )

            # Only keep the first background encountered for a feature
            if background_val and not feature_entry["background_raw"]:
                feature_entry["background_raw"] = background_val

            feature_entry["scenarios"].append(
                {
                    "name": scenario_val or "Scenario",
                    "steps": description_val,
                }
            )

    for feature_name, data in features.items():
        slug = slugify(feature_name)
        outfile = OUTPUT_DIR / f"{slug}.feature"

        lines: List[str] = [f"Feature: {feature_name}", ""]

        background = parse_background(data["background_raw"]) if data["background_raw"] else None
        if background:
            bg_title, bg_steps = background
            bg_header = f"Background: {bg_title}" if bg_title else "Background:"
            lines.append(bg_header)
            for step in bg_steps:
                lines.append(f"  {step}")
            lines.append("")  # blank line after background

        for scenario in data["scenarios"]:
            scenario_name = scenario["name"] or "Scenario"
            lines.append(f"Scenario: {scenario_name}")
            steps = normalize_steps(scenario["steps"])
            if not steps:
                lines.append("  # No steps provided")
            else:
                for step in steps:
                    lines.append(f"  {step}")
            lines.append("")  # blank line between scenarios

        outfile.write_text("\n".join(lines).strip() + "\n", encoding="utf-8")
        print(f"Wrote {outfile}")


if __name__ == "__main__":
    main()

