@echo off
echo ============================================================
echo AgentsVille Trip Planner - Push to GitHub
echo ============================================================
echo.

echo This script will help you push your project to GitHub
echo.
echo Prerequisites:
echo 1. Git must be installed (https://git-scm.com/download/win)
echo 2. You must have a GitHub account
echo 3. You must create a repository on GitHub first
echo.
pause

echo.
echo Step 1: Configuring Git (if first time)
echo --------------------------------------------------------
set /p git_name="Enter your name: "
set /p git_email="Enter your email: "

git config --global user.name "%git_name%"
git config --global user.email "%git_email%"

echo Done!
echo.

echo Step 2: Enter your GitHub repository URL
echo --------------------------------------------------------
echo Example: https://github.com/YOUR_USERNAME/agentsville-trip-planner.git
echo.
set /p repo_url="Repository URL: "

echo.
echo Step 3: Initializing Git and pushing to GitHub
echo --------------------------------------------------------

REM Check if .git exists
if exist ".git" (
    echo Git repository already initialized
) else (
    echo Initializing Git repository...
    git init
)

echo.
echo Renaming README_GITHUB.md to README.md...
if exist "README_GITHUB.md" (
    move /Y "README_GITHUB.md" "README.md"
)

echo.
echo Adding all files...
git add .

echo.
echo Creating commit...
git commit -m "Initial commit: AgentsVille Trip Planner project"

echo.
echo Adding remote origin...
git remote remove origin 2>nul
git remote add origin %repo_url%

echo.
echo Pushing to GitHub...
git branch -M main
git push -u origin main

if %errorlevel% equ 0 (
    echo.
    echo ============================================================
    echo SUCCESS! Your project is now on GitHub!
    echo ============================================================
    echo.
    echo Repository URL: %repo_url%
    echo.
    echo Next steps:
    echo 1. Visit your repository on GitHub
    echo 2. Add topics: python, jupyter-notebook, openai, llm, ai
    echo 3. Edit the description if needed
    echo 4. Share your project!
    echo ============================================================
) else (
    echo.
    echo ============================================================
    echo ERROR: Failed to push to GitHub
    echo ============================================================
    echo.
    echo Common issues:
    echo 1. Make sure you created the repository on GitHub first
    echo 2. Check your repository URL is correct
    echo 3. You may need a Personal Access Token instead of password
    echo    Visit: https://github.com/settings/tokens
    echo.
    echo For detailed instructions, see: GIT_SETUP_GUIDE.md
    echo ============================================================
)

echo.
pause
