#!/bin/bash

# Git Configuration Setup Script for GitHub Activity Tracking
# This script helps ensure your commits show up in your GitHub activity chart and streak

echo "🔧 Git Configuration Setup for GitHub Activity Tracking"
echo "======================================================="
echo

# Check if git is available
if ! command -v git &> /dev/null; then
    echo "❌ Git is not installed. Please install Git first."
    exit 1
fi

echo "📋 Current Git Configuration:"
echo "Name: $(git config user.name || echo 'Not set')"
echo "Email: $(git config user.email || echo 'Not set')"
echo

# Function to validate email format
validate_email() {
    if [[ $1 =~ ^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$ ]]; then
        return 0
    else
        return 1
    fi
}

# Get user's GitHub username
echo "🔍 Please enter your GitHub username:"
read -p "GitHub username: " github_username

if [ -z "$github_username" ]; then
    echo "❌ GitHub username cannot be empty."
    exit 1
fi

# Get user's name for git config
echo
echo "👤 Please enter your full name (as you want it to appear in commits):"
read -p "Full name: " user_name

if [ -z "$user_name" ]; then
    echo "❌ Name cannot be empty."
    exit 1
fi

# Get user's email
echo
echo "📧 Please enter your email address:"
echo "   💡 This should be the primary email associated with your GitHub account"
echo "   💡 You can also use your GitHub noreply email: ${github_username}@users.noreply.github.com"
read -p "Email: " user_email

if [ -z "$user_email" ]; then
    echo "❌ Email cannot be empty."
    exit 1
fi

if ! validate_email "$user_email"; then
    echo "❌ Invalid email format."
    exit 1
fi

# Ask for confirmation
echo
echo "📝 Configuration Summary:"
echo "Name: $user_name"
echo "Email: $user_email"
echo "GitHub Username: $github_username"
echo

read -p "❓ Do you want to apply this configuration? (y/N): " confirm

if [[ ! $confirm =~ ^[Yy]$ ]]; then
    echo "❌ Configuration cancelled."
    exit 0
fi

# Apply git configuration
echo
echo "⚙️  Applying Git configuration..."

# Set git config locally for this repository
git config user.name "$user_name"
git config user.email "$user_email"

# Verify configuration
echo
echo "✅ Git configuration updated successfully!"
echo "📋 New Configuration:"
echo "Name: $(git config user.name)"
echo "Email: $(git config user.email)"
echo

# Provide additional guidance
echo "📚 Important Notes:"
echo "   ✓ This configuration is set for this repository only"
echo "   ✓ To set globally for all repositories, run:"
echo "     git config --global user.name \"$user_name\""
echo "     git config --global user.email \"$user_email\""
echo
echo "   ✓ Make sure your email is verified in your GitHub account settings"
echo "   ✓ The email should be set as your primary email or be a verified email"
echo "   ✓ Future commits will now be associated with your GitHub account"
echo
echo "🎉 You're all set! Your future commits should now appear in your GitHub activity."