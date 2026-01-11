# GitHub Repository Migration Script

A bash script to migrate GitHub repositories from one account to another while preserving complete commit history. This is particularly useful when migrating your GitHub profile and want to maintain your contribution graph.

## 🎯 What This Script Does

- ✅ Clones the entire repository history (including all branches and tags) from your old GitHub account
- ✅ Pushes everything to your new GitHub account
- ✅ Shows you which email addresses are associated with commits
- ✅ Provides step-by-step guidance for completing the migration
- ✅ Preserves your contribution graph by migrating commit history

## 📋 Prerequisites

Before using this script, make sure you have:

1. **Git installed** on your system
2. **SSH key configured** for your new GitHub account
3. **GitHub Personal Access Token** for your old account (with `repo` permissions)
4. **Both repositories created**:
   - The repository exists in your old account
   - An empty repository exists in your new account

## 🔑 Getting a GitHub Personal Access Token

1. Go to your **old GitHub account** → Settings → Developer settings → Personal access tokens → Tokens (classic)
2. Click "Generate new token (classic)"
3. Give it a descriptive name (e.g., "Repository Migration")
4. Select the `repo` scope (full control of private repositories)
5. Click "Generate token"
6. **Copy the token immediately** (you won't be able to see it again!)

## 🚀 How to Use

### Step 1: Download the Script

```bash
git clone https://github.com/YOUR_USERNAME/github-profile-migrator.git
cd github-profile-migrator
```

Or download the script files directly.

**Available scripts:**
- `migrate_repo.sh` - Non-interactive version (only asks for initial confirmation)
- `migrate_repo_interactive.sh` - Fully interactive version (asks for confirmation at each step)

### Step 2: Make the Script Executable

After cloning or downloading, you need to give execute permissions to the script:

```bash
chmod +x migrate_repo.sh
```

Or if using the interactive version:

```bash
chmod +x migrate_repo_interactive.sh
```

### Step 3: Edit the Configuration

Open the script file (`migrate_repo.sh` or `migrate_repo_interactive.sh`) in your favorite editor and fill in the configuration section at the top:

```bash
# ===== CONFIG =====
OLD_USER="your-old-username"      # Your old GitHub username
NEW_USER="your-new-username"        # Your new GitHub username
REPO_NAME="repository-name"         # Name of the repository to migrate
SOURCE_GITHUB_TOKEN="ghp_your_token_here" # Your GitHub Personal Access Token
# ==================
```

**Example:**
```bash
OLD_USER="oldaccount"
NEW_USER="newaccount"
REPO_NAME="my-awesome-project"
SOURCE_GITHUB_TOKEN="ghp_some-token-generated"
```

### Step 4: Prepare Your New Repository

1. Log in to your **new GitHub account**
2. Create a new repository with the same name (or the name you want)
3. **Do NOT initialize it** with a README, .gitignore, or license (keep it empty)
4. Make sure your SSH key is added to your new GitHub account

### Step 5: Run the Script

**For non-interactive version:**
```bash
./migrate_repo.sh
```

**For interactive version:**
```bash
./migrate_repo_interactive.sh
```

The script will:
1. Show you the configuration and ask for confirmation (non-interactive version only asks once)
2. Check if both repositories exist and are accessible
3. Clone the repository with full history
4. Show you the email addresses used in commits
5. Push everything to your new repository

The interactive version will ask for confirmation at each step, while the non-interactive version proceeds automatically after the initial confirmation.

## 📧 Important: Email Migration

After the repository migration, you **must** migrate the email addresses associated with your commits:

### Why This Matters

GitHub uses email addresses in commits to attribute contributions to your profile. If the email addresses aren't verified on your new account, those commits won't show up in your contribution graph.

### Steps to Complete Email Migration

1. **Note the email addresses** shown by the script during migration
2. **Remove emails from old account**:
   - Go to old account → Settings → Emails
   - Remove the email addresses that were used in commits
3. **Add emails to new account**:
   - Go to new account → Settings → Emails
   - Add the same email addresses
   - **Verify them** (check your inbox for verification emails)
4. **Wait a few minutes** for GitHub to update your contribution graph
5. **Verify** that your commits appear on your new profile

### ⚠️ Important Notes

- Only delete your old account **after** verifying that commits appear on your new profile
- This process can take a few minutes to a few hours for GitHub to update
- If you have multiple repositories, you'll need to run this script for each one

## 🔒 Security Best Practices

- **Never commit your GitHub token** to version control
- **Delete the token** after migration is complete
- **Use tokens with minimal permissions** (only `repo` scope needed)
- **Revoke the token** in your old account's settings after use

## 🐛 Troubleshooting

### "OLD repository does NOT exist or token has no access"
- Verify the repository name is correct
- Check that your token has `repo` permissions
- Ensure the token hasn't expired

### "NEW repository does NOT exist OR SSH key not configured"
- Make sure you've created the repository in your new account
- Verify your SSH key is added to your new GitHub account
- Test SSH connection: `ssh -T git@github.com`

### "Permission denied" errors
- Check that your SSH key is properly configured
- Verify the repository name matches exactly
- Ensure you have write access to the new repository

### Commits not showing on profile
- Make sure you've added and verified the email addresses on your new account
- Wait a few hours for GitHub to update
- Check that the email addresses match exactly (case-sensitive)

## 📝 Example Workflow

```bash
# 1. Clone the repository
git clone https://github.com/YOUR_USERNAME/github-profile-migrator.git
cd github-profile-migrator

# 2. Make the script executable
chmod +x migrate_repo.sh

# 3. Configure the script
vim migrate_repo.sh
# Edit OLD_USER, NEW_USER, REPO_NAME, SOURCE_GITHUB_TOKEN

# 4. Run the migration
./migrate_repo.sh

# 5. Follow the prompt (non-interactive version):
# - Confirm settings: y
# Then it proceeds automatically

# For interactive version (migrate_repo_interactive.sh):
# - Confirm settings: y
# - Proceed with migration: y
# - Clone repository: y
# - Push to new account: y

# 6. Complete email migration (see instructions above)
```

## 🤝 Contributing

Contributions are welcome! Feel free to:
- Report bugs
- Suggest improvements
- Submit pull requests

## 📄 License

This script is provided as-is for public use. Use at your own risk.

## ⚠️ Disclaimer

This script migrates repositories and commit history. Always:
- Test on a non-critical repository first
- Keep backups of important repositories
- Verify the migration before deleting your old account
- Understand that you're responsible for your own data

## 🙏 Acknowledgments

Created to help developers migrate their GitHub profiles while preserving their contribution history.

---

**Made with ❤️ and some time invested for the GitHub community**
