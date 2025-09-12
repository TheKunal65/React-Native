# GitHub Activity Tracking Guide

## Why Your Commits Aren't Showing in GitHub Activity

If your commits to this React Native repository aren't appearing in your GitHub streak and activity chart, it's likely due to git configuration issues. Here's how to fix it:

## Common Issues

### 1. Incorrect Git User Configuration
Your git user email must match a verified email in your GitHub account.

### 2. Bot/System Email Addresses
Emails like `copilot@users.noreply.github.com` or other bot emails won't contribute to your personal activity.

### 3. Unverified Email Address
GitHub only counts commits from verified email addresses.

## Quick Fix

### Option 1: Use the Automated Setup Script
```bash
./setup-git-config.sh
```

### Option 2: Manual Configuration
```bash
# Set your name and email for this repository
git config user.name "Your Name"
git config user.email "your.email@example.com"

# Or set globally for all repositories
git config --global user.name "Your Name"
git config --global user.email "your.email@example.com"
```

### Option 3: Use GitHub Noreply Email
If you prefer to keep your email private:
```bash
git config user.email "yourusername@users.noreply.github.com"
```
Replace `yourusername` with your actual GitHub username.

## Verification

Check your configuration:
```bash
./check-git-config.sh
```

Or manually:
```bash
git config user.name
git config user.email
```

## Important Notes

1. **Email Verification**: Make sure your email is verified in [GitHub Settings](https://github.com/settings/emails)

2. **Primary Email**: The email should be set as your primary email or be in your list of verified emails

3. **Private Repositories**: Commits to private repos might not show in public activity depending on your privacy settings

4. **Timing**: It may take up to 24 hours for activity to appear on GitHub

5. **Fork vs Original**: If this is a fork, commits might not count towards your activity unless the fork has diverged significantly

## Troubleshooting

### Check Your GitHub Email Settings
1. Go to [GitHub Settings > Emails](https://github.com/settings/emails)
2. Verify your email address is listed and verified
3. Consider adding the email you're using for git commits

### Check Repository Visibility
- Public repository commits always count
- Private repository commits count if you've enabled "Include private contributions" in your [profile settings](https://github.com/settings/profile)

### Check Commit Authorship
```bash
git log --pretty=format:"%h - %an <%ae> - %s" -5
```
Make sure the author email matches your GitHub account.

## Future Commits

After fixing your git configuration, all future commits will be properly attributed to your GitHub account and should appear in your activity chart and contribute to your streak.

## Past Commits

Unfortunately, past commits with incorrect email addresses won't retroactively appear in your GitHub activity. You would need to rewrite git history, which is not recommended for shared repositories.

---

For more information, see [GitHub's official documentation on commit attribution](https://docs.github.com/en/account-and-profile/setting-up-and-managing-your-github-profile/managing-contribution-settings-on-your-profile/why-are-my-contributions-not-showing-up-on-my-profile).