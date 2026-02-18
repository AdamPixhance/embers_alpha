# Embers

Embers is a local-first habits tracker for people who want a simple daily flow:

1. Toggle what you did.
2. Click **Complete Day**.
3. Lock the day and move on.

It stores data on your machine, supports historical editing, tracks streaks, and shows badge-based performance grids over time.

## Key Features

- ✅ **Daily checklist workflow**: Click what you did, complete the day, lock it
- ✅ **Day locking**: Completed days are immutable (unless explicitly unlocked for corrections)
- ✅ **Temporal habits**: Habits can have active/inactive date windows so old habits don't appear in historical dates
- ✅ **Habit scoring**: Positive (`must`, `good`, `great`) and negative (`bad`, `killer`, `must_avoid`) habits in one score
- ✅ **Streaks**: Per-habit streaks (2+ days) and overall tracking streak (consecutive completed days)
- ✅ **Badges**: Mutually exclusive daily badges (Bronze/Silver/Gold/Diamond for positive, Bad/Worse/Really Bad for negative)
- ✅ **Analytics**: Weekly, monthly, and yearly badge grids to visualize performance over time
- ✅ **Local-first**: All data stays on your computer. No cloud, no accounts, no tracking

## Why this app exists

Most habit apps are either too heavy or too generic. Embers is designed for a focused personal workflow that respects your privacy and doesn't get in the way of your habit building.

## Tech stack

- Python 3.12+ (tested with 3.12.0)
- NiceGUI 2.24+ (web UI)
- SQLite (local database)
- OpenPyXL (Excel habit configuration)

## Project structure

- `app.py` — main application (1800+ lines, includes all UI, database, and logic)
- `styles.css` — NiceGUI component styling
- `requirements.txt` — Python dependencies
- `Embers.bat` — Windows launcher (portable, no hardcoded Python paths)
- `data/Habits.xlsx` — habit definitions (source of truth, opened at startup)
- `data/habits.db` — SQLite database (auto-created, stores all tracking data)
- `backups/` — yearly Excel export backups (auto-saved on app close)
- `scripts/` — build automation (PyInstaller and Inno Setup)

## Quick Start (Developers)

1. Install Python 3.12 or newer
2. Clone and set up:
   ```bash
   git clone https://github.com/AdamPixhance/embers.git
   cd embers
   python -m venv .venv
   source .venv/bin/activate  # or `.venv\Scripts\activate` on Windows
   pip install -r requirements.txt
   ```
3. Run: `python app.py`
4. Open http://localhost:8080

**On Windows**, you can also just run `Embers.bat` from the command line.

## Packaging for Distribution

### ⭐ Pre-built Portable Version (Ready to Share NOW!)

A standalone executable is already built and ready to share:
- **Location**: `dist/Embers/Embers.exe`
- **What's included**: All dependencies bundled, no Python installation needed
- **To share**: Zip the entire `dist/Embers/` folder and share as `Embers-Portable.zip`
- **For users**: Extract zip, double-click `Embers.exe`, read `START_HERE.txt`

**This is the easiest distribution method. No additional steps required. Users just download and run.**

### Building from Source (Optional, Developers Only)

If you want to rebuild or customize the executable:

**1) Rebuild standalone app folder** (if you modified the code)
```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\build_exe.ps1 -Clean
```
Output: `dist/Embers/` (includes Embers.exe, styles.css, bundled dependencies, data folder, and templates)

**2) Build Setup.exe installer** (optional, for professional Windows distribution)

⚠️ **Requires Inno Setup 6 to be installed on your machine.** This is entirely optional.

If you have Inno Setup 6 installed:
```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\build_installer.ps1
```
Output: `dist-installer/Embers-Setup-<version>.exe` (one-click Windows installer)
## Habits template (`data/Habits.xlsx`)

Use sheet `habits`. Keep `habit_id` stable once created.

Required columns:

- `habit_id`
- `name`
- `category` (`must`, `good`, `great`, `bad`, `killer`, `must_avoid`)
- `type` (`check` or `number`)
- `schedule` (`daily`, `weekdays`, `weekends`, or `mon,wed,fri` style)
- `active` (`0` or `1`)

Optional columns:

- `weight_override`
- `target`
- `label`
- `notes`
- `active_from` (`YYYY-MM-DD`)
- `inactive_from` (`YYYY-MM-DD`, exclusive end date)

## Daily workflow

1. Open today.
2. Toggle habits.
3. Click **Complete Day** to create a final snapshot and lock the day.
4. If needed, click **Unlock Day** to correct mistakes.

If you leave a previous day open, Embers prompts you on next launch to finalize it or continue editing it first.

## Scoring, streaks, and badges

- Per-habit streaks appear after 2+ consecutive completions.
- Overall tracking streak counts only consecutive **completed** days.
- Day badges are mutually exclusive and based on completed-day performance:
	- Positive: Bronze, Silver, Gold, Diamond
	- Negative: Bad, Worse, Really Bad
- Weekly/monthly/yearly badge grids visualize performance over time.

## Distribution Options

### 🟢 Recommended: Portable Folder (Best for Friends & Family)

**Already ready in `dist/Embers/`** — No additional work needed!

1. Zip the entire `dist/Embers/` folder → `Embers-Portable.zip`
2. Share the zip file with friends/family via email, cloud storage, or GitHub Releases
3. **They**: Extract, double-click `Embers.exe`, and read `START_HERE.txt`

**Requirements for users**: Nothing! No Python, no installation, no tech knowledge.

**Advantages**: 
- Simple — just download and run
- Instant — no installation wizard
- Portable — works on any Windows machine
- No admin privileges needed

### 🔵 Alternative: Setup Installer (Professional Windows Distribution)

⚠️ **Requires Inno Setup 6 installed on your development machine.** Skip this unless you need a traditional Windows installer.

If you want to build a Setup.exe for one-click installation:
1. Install [Inno Setup 6](https://www.jrsoftware.org/isdl.php) on your machine
2. Run `powershell -ExecutionPolicy Bypass -File .\scripts\build_installer.ps1`
3. Get `Embers-Setup-<date>.exe` from `dist-installer/`
4. Share the Setup.exe file—users can install with one click

### 🟣 Source Code Distribution (For Developers)

Share the GitHub repository. Developers can clone and run from source with Python installed.

---

## Quick Deploy for Friends & Family

**This is all you need to do:**

```powershell
# Create a shareable zip of the portable version
Compress-Archive -Path "dist\Embers" -DestinationPath "Embers-Portable.zip"
```

Then:
- Upload `Embers-Portable.zip` to [GitHub Releases](https://github.com/AdamPixhance/embers/releases)
- Or share directly via Google Drive, OneDrive, email, etc.
- They extract and double-click `Embers.exe`

Done! 🎉

## Privacy

All data stays local in this folder. No cloud sync, no external account, no telemetry.

## License

Licensed under the MIT License. See [LICENSE](LICENSE) for details.
