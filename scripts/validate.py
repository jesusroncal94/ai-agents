"""Static checks for the agent and command definitions, run by scripts/check.sh in Docker."""
import json
import re
import subprocess
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
PLATFORM = ROOT / "platforms" / "claude"
problems = []


def frontmatter(path):
    match = re.match(r"^---\n(.*?)\n---\n", path.read_text(encoding="utf-8"), re.DOTALL)
    if not match:
        return None
    fields = {}
    for line in match.group(1).splitlines():
        key, separator, value = line.partition(":")
        if separator and not line.startswith((" ", "-")):
            fields[key.strip()] = value.strip()
    return fields


agents = sorted((PLATFORM / "agents").glob("*.md"))
for path in agents:
    fields = frontmatter(path)
    if fields is None:
        problems.append(f"{path.relative_to(ROOT)}: missing frontmatter")
        continue
    for key in ("name", "description", "model"):
        if not fields.get(key):
            problems.append(f"{path.relative_to(ROOT)}: frontmatter lacks '{key}'")
    if fields.get("name") != path.stem:
        problems.append(f"{path.relative_to(ROOT)}: name does not match the file name")

for path in sorted((PLATFORM / "commands").glob("*.md")):
    if "$ARGUMENTS" not in path.read_text(encoding="utf-8").splitlines()[0]:
        problems.append(f"{path.relative_to(ROOT)}: first line does not take $ARGUMENTS")

for path in (PLATFORM / "settings.json", ROOT / ".claude" / "settings.json"):
    try:
        settings = json.loads(path.read_text(encoding="utf-8"))
    except (OSError, ValueError) as error:
        problems.append(f"{path.relative_to(ROOT)}: {error}")
        continue
    known = {path.stem for path in agents}
    for entry in settings.get("permissions", {}).get("allow", []):
        match = re.fullmatch(r"Task\((.+)\)", entry)
        if match and match.group(1) not in known:
            problems.append(f"{path.relative_to(ROOT)}: {entry} names no agent")

for path in sorted(ROOT.glob("scripts/*.sh")) + sorted(ROOT.glob(".claude/hooks/*.sh")):
    if subprocess.run(["bash", "-n", str(path)]).returncode:
        problems.append(f"{path.relative_to(ROOT)}: shell syntax error")

for problem in problems:
    print(f"FAIL {problem}")
print(f"{len(agents)} agents checked, {len(problems)} problems")
sys.exit(1 if problems else 0)
