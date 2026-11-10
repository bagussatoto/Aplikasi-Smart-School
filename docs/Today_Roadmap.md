# Today's Roadmap for Aplikasi Smart School

## Objective
Set up the development environment and resolve critical configuration issues so the application can run locally today.

## Tasks (in order)
1. **Install PHP 5.6**
   - Use Chocolatey: `choco install php --version=5.6.40`
   - Verify with `php -v`.
2. **Install ionCube Loader for PHP 5.6**
   - Download the appropriate loader from the ionCube website.
   - Add the loader line to `php.ini` and restart the web server.
3. **Install MySQL/MariaDB**
   - Create the `elearning` database.
   - Import the provided dump: `mysql -u root -p elearning < db/bukuinduk.sql`.
4. **Enable required PHP extensions**
   - Ensure `mysqli`, `mbstring`, `gd`, `openssl` are enabled in `php.ini`.
5. **Create a writable session directory**
   - `New-Item -ItemType Directory -Path C:\temp\ci_sessions`
   - Set `$config['sess_save_path'] = 'C:\temp\ci_sessions';` in `application/config/config.php`.
6. **Generate and set an encryption key**
   - Run in PowerShell: `$key = -join ((65..90) + (97..122) | Get-Random -Count 32 | % {[char]$_});`
   - Add `$config['encryption_key'] = '$key';` to `application/config/config.php`.
7. **Fix PDF generator library path**
   - Edit `application/libraries/Pdfgenerator.php` to load Dompdf from the existing folder:
     ```php
     require_once(APPPATH . 'third_party/dompdf/autoload.inc.php');
     ```
8. **Remove unused `log_helper`**
   - Delete `log_helper` entry from `$autoload['helper']` in `application/config/autoload.php` (or implement needed functions).
9. **Verify web server configuration**
   - Ensure Apache/IIS is running with URL‑Rewrite enabled.
   - Confirm the site serves `index.php` without 500 errors.
10. **Test the application**
    - Open the homepage in a browser.
    - Log in with default credentials (`admin/admin`).
    - Generate a sample PDF to confirm the PDF library works.
11. **(Optional) Convert tables to InnoDB and add foreign keys**
    - Run a script later to migrate all tables to InnoDB and define proper relationships.

## Notes
- All commands are PowerShell examples for a Windows development environment.
- Steps 1–4 are prerequisite installations; steps 5–8 are configuration fixes identified during analysis.
- After completing these tasks, the application should be runnable locally, and you can proceed with further development or data migration.

