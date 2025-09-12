#!/bin/bash

# Git Configuration Verification Script
# This script checks if your git configuration is properly set up for GitHub activity tracking

echo "🔍 GitHub Activity Tracking - Configuration Check"
echo "================================================="
echo

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Check if git is available
if ! command -v git &> /dev/null; then
    echo -e "${RED}❌ Git is not installed.${NC}"
    exit 1
fi

# Get current git configuration
git_name=$(git config user.name)
git_email=$(git config user.email)
global_name=$(git config --global user.name 2>/dev/null)
global_email=$(git config --global user.email 2>/dev/null)

echo "📋 Current Git Configuration:"
echo "   Local Repository:"
echo "     Name:  ${git_name:-'Not set'}"
echo "     Email: ${git_email:-'Not set'}"
echo
echo "   Global Configuration:"
echo "     Name:  ${global_name:-'Not set'}"
echo "     Email: ${global_email:-'Not set'}"
echo

# Check configuration status
issues_found=0

# Check if name is set
if [ -z "$git_name" ] && [ -z "$global_name" ]; then
    echo -e "${RED}❌ No git user name configured${NC}"
    echo "   Fix: Run 'git config user.name \"Your Name\"'"
    issues_found=$((issues_found + 1))
elif [ -z "$git_name" ]; then
    echo -e "${YELLOW}⚠️  Using global git user name: $global_name${NC}"
else
    echo -e "${GREEN}✅ Git user name is configured${NC}"
fi

# Check if email is set
if [ -z "$git_email" ] && [ -z "$global_email" ]; then
    echo -e "${RED}❌ No git user email configured${NC}"
    echo "   Fix: Run 'git config user.email \"your.email@example.com\"'"
    issues_found=$((issues_found + 1))
elif [ -z "$git_email" ]; then
    echo -e "${YELLOW}⚠️  Using global git user email: $global_email${NC}"
    current_email="$global_email"
else
    echo -e "${GREEN}✅ Git user email is configured${NC}"
    current_email="$git_email"
fi

# Check for bot/system emails that won't contribute to GitHub activity
if [[ "$current_email" == *"@users.noreply.github.com" && "$current_email" =~ ^[0-9]+\+ ]]; then
    # This is a GitHub-generated email, which is fine
    echo -e "${GREEN}✅ Using GitHub noreply email${NC}"
elif [[ "$current_email" == *"noreply"* ]] || [[ "$current_email" == *"bot"* ]] || [[ "$current_email" == *"github.com"* ]]; then
    echo -e "${RED}❌ Email appears to be a bot/system email: $current_email${NC}"
    echo "   This may prevent commits from showing in your GitHub activity"
    echo "   Consider using your personal email or GitHub noreply email"
    issues_found=$((issues_found + 1))
fi

echo

# Check recent commits
echo "📊 Recent Commits Analysis:"
recent_commits=$(git log --oneline -5 --pretty=format:"%h - %an <%ae> - %s" 2>/dev/null)

if [ -z "$recent_commits" ]; then
    echo "   No commits found in this repository"
else
    echo "$recent_commits"
fi

echo
echo

# Provide recommendations
if [ $issues_found -eq 0 ]; then
    echo -e "${GREEN}🎉 Configuration looks good!${NC}"
    echo "   Your commits should appear in your GitHub activity chart."
else
    echo -e "${RED}⚠️  Found $issues_found configuration issue(s)${NC}"
    echo "   Run './setup-git-config.sh' to fix these issues."
fi

echo
echo "📚 Additional Tips:"
echo "   • Make sure your email is verified in GitHub settings"
echo "   • Ensure the email is set as primary or is a verified email"
echo "   • Private repository commits may not show in public activity"
echo "   • It may take up to 24 hours for activity to appear on GitHub"

exit $issues_found