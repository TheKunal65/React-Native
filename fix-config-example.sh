#!/bin/bash

# Example script showing how to fix the git configuration for TheKunal65
# This demonstrates the solution to the GitHub activity tracking issue

echo "🔧 Fixing Git Configuration for GitHub Activity Tracking"
echo "======================================================="
echo

echo "🔍 Current Issue Analysis:"
echo "   Current Email: $(git config user.email)"
echo "   Current Name:  $(git config user.name)"
echo "   Repository Owner: TheKunal65"
echo

echo "📋 From git history, we found the user's email: kunalprajapat65@gmail.com"
echo

echo "⚙️  Applying the correct configuration..."

# Set the correct git configuration based on the repository owner and found email
git config user.name "TheKunal65"
git config user.email "kunalprajapat65@gmail.com"

echo "✅ Configuration updated!"
echo
echo "📋 New Configuration:"
echo "   Name:  $(git config user.name)"
echo "   Email: $(git config user.email)"
echo

echo "🎉 Future commits will now be properly attributed to your GitHub account!"
echo "   Make sure kunalprajapat65@gmail.com is verified in your GitHub settings."