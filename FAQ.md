# GitHub Account Migration FAQ

This FAQ covers common issues, best practices, and lessons learned when migrating repositories from an old GitHub account to a new one while preserving commit history and contribution tracking.

---

## 1. Can I transfer all commits to a new account?

- **Yes, commits are preserved in the repository.**
- **But:** GitHub links commits to accounts via **verified emails**.
- Only commits authored with an email **currently verified on the new account** will appear in the contribution graph.
- Commits using `@users.noreply.github.com` or emails removed from the old account may **never appear retroactively**.

---

## 2. Recommended Migration Steps (Safe Method)

1. **Mirror clone the old repository:**
    ```bash
    git clone --mirror https://OLD_USER:OLD_TOKEN@github.com/OLD_USER/REPO.git
    ```
2. **Push to the new account:**
    ```bash
    git push --mirror git@github.com:NEW_USER/REPO.git
    ```
3. **Check commit emails:**
    ```bash
    git log --all --format='%ae' | sort -u
    ```
4. **Add old emails used in commits to the new account** before removing them from the old account.
5. **Remove old emails from the old account** only after step 4.
6. Verify commits appear under the new account profile.
7. Delete the old account only after verification (optional).

⚠️ Removing emails too early will orphan commits, which **cannot be re-associated later**.

---

## 3. Handling `@users.noreply.github.com` commits

- Permanently linked to the old account.
- **Cannot transfer** to a new account without rewriting history (advanced, risky).
- Safe option: leave them in the repo; code remains intact.

---

## 4. Commits with Gmail or real emails

- Only commits with an email **verified on the new account** appear in the contribution graph.
- If they do not appear:
  - Verify the email matches exactly.
  - Ensure the branch with commits is pushed to GitHub.
  - Check profile settings for private contributions.

---

## 5. Common Issues & Lessons Learned

| Issue                                     | Cause                                              | Fix / Note                                                  |
|-------------------------------------------|----------------------------------------------------|-------------------------------------------------------------|
| Gmail commits not showing                 | Old email removed too early or branch not pushed   | Confirm branch exists and email verified                    |
| Noreply commits missing                   | Cannot verify noreply on new account               | History is safe; contribution graph won’t show              |
| Contribution graph not updating           | Private contributions disabled / cached            | Enable in profile settings                                  |
| Migration warning “you will lose access”  | Removing old email before adding to new            | Always add email to new account first, then remove from old |

---

## 6. Checking Orphaned Commits Locally

```bash
git log --all --format='%h %ae %ad %s' --date=short \
  --invert-grep --grep="YOUR_VERIFIED_EMAIL"
```

## 7. Rewriting History (Advanced)

- Only for **personal repositories**.
- Tool: `git filter-repo`.
- Purpose: change commit emails to your new account so contributions appear.
- ⚠️ Rewrites commit hashes; may break forks or PRs.

Example:

```bash
git clone --mirror git@github.com:NEW_USER/REPO.git
cd REPO.git

git filter-repo --email-callback '
def callback(email):
    if email == b"OLD_EMAIL@domain.com":
        return b"NEW_EMAIL@domain.com"
    return email
'
git push --force --mirror
```
