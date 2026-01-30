#!/bin/bash
# Install Claude Code agents and commands to a target project

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(dirname "$SCRIPT_DIR")"
CLAUDE_DIR="$REPO_ROOT/platforms/claude"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

usage() {
    echo "Usage: $0 <target-project-path> [options]"
    echo ""
    echo "Options:"
    echo "  --force    Overwrite existing .claude directory"
    echo "  --dry-run  Show what would be copied without copying"
    echo "  --help     Show this help message"
    echo ""
    echo "Example:"
    echo "  $0 /path/to/my/project"
    echo "  $0 /path/to/my/project --force"
}

if [ $# -lt 1 ] || [ "$1" == "--help" ]; then
    usage
    exit 0
fi

TARGET_PATH="$1"
FORCE=false
DRY_RUN=false

# Parse options
shift
while [ $# -gt 0 ]; do
    case "$1" in
        --force)
            FORCE=true
            ;;
        --dry-run)
            DRY_RUN=true
            ;;
        *)
            echo -e "${RED}Unknown option: $1${NC}"
            usage
            exit 1
            ;;
    esac
    shift
done

# Validate target path
if [ ! -d "$TARGET_PATH" ]; then
    echo -e "${RED}Error: Target path does not exist: $TARGET_PATH${NC}"
    exit 1
fi

TARGET_CLAUDE="$TARGET_PATH/.claude"

# Check if .claude already exists
if [ -d "$TARGET_CLAUDE" ] && [ "$FORCE" != true ]; then
    echo -e "${YELLOW}Warning: $TARGET_CLAUDE already exists.${NC}"
    echo "Use --force to overwrite or backup manually."
    exit 1
fi

# Validate source exists
if [ ! -d "$CLAUDE_DIR" ]; then
    echo -e "${RED}Error: Claude platform directory not found: $CLAUDE_DIR${NC}"
    exit 1
fi

echo "Installing Claude Code configuration..."
echo "  Source: $CLAUDE_DIR"
echo "  Target: $TARGET_CLAUDE"
echo ""

if [ "$DRY_RUN" == true ]; then
    echo -e "${YELLOW}Dry run - would copy:${NC}"
    find "$CLAUDE_DIR" -type f | while read file; do
        rel_path="${file#$CLAUDE_DIR/}"
        echo "  $rel_path"
    done
    echo ""
    echo -e "${YELLOW}No files were copied (dry run).${NC}"
    exit 0
fi

# Create target directory
mkdir -p "$TARGET_CLAUDE"

# Copy files
cp -r "$CLAUDE_DIR/agents" "$TARGET_CLAUDE/"
cp -r "$CLAUDE_DIR/commands" "$TARGET_CLAUDE/"
cp "$CLAUDE_DIR/settings.json" "$TARGET_CLAUDE/"

# Copy README if it doesn't exist or force is set
if [ ! -f "$TARGET_CLAUDE/README.md" ] || [ "$FORCE" == true ]; then
    cp "$CLAUDE_DIR/README.md" "$TARGET_CLAUDE/"
fi

echo -e "${GREEN}Installation complete!${NC}"
echo ""
echo "Installed components:"
echo "  - $(ls -1 $TARGET_CLAUDE/agents/*.md 2>/dev/null | wc -l) agents"
echo "  - $(ls -1 $TARGET_CLAUDE/commands/*.md 2>/dev/null | wc -l) commands"
echo "  - settings.json"
echo ""
echo "Next steps:"
echo "  1. Review and customize settings.json for your project"
echo "  2. Start using commands: /analyze-feature, /implement-backend, etc."
echo ""
echo "Documentation: https://docs.anthropic.com/en/docs/claude-code/sub-agents"
