@echo off
echo ========================================
echo Test Progress API - Magic English
echo ========================================
echo.

echo Step 1: Login to get token...
curl -X POST "http://localhost:8080/api/v1/auth/login" ^
  -H "Content-Type: application/json" ^
  -d "{\"email\":\"truong@gmail.com\",\"password\":\"123456\"}" > temp_login.json

echo.
echo.

for /f "tokens=2 delims=:" %%a in ('findstr /C:"\"access_token\"" temp_login.json') do (
  set TOKEN_RAW=%%a
)

:: Remove quotes and comma
set TOKEN=%TOKEN_RAW:"=%
set TOKEN=%TOKEN:,=%
set TOKEN=%TOKEN: =%

echo Token: %TOKEN%
echo.
echo.

echo Step 2: Test Vocabulary Breakdown API...
curl -X GET "http://localhost:8080/api/v1/vocabulary/breakdown" ^
  -H "Authorization: Bearer %TOKEN%"

echo.
echo.

echo Step 3: Test CEFR Distribution API...
curl -X GET "http://localhost:8080/api/v1/vocabulary/cefr-distribution" ^
  -H "Authorization: Bearer %TOKEN%"

echo.
echo.

echo Step 4: Test Total Vocabulary Count API...
curl -X GET "http://localhost:8080/api/v1/vocabulary/count" ^
  -H "Authorization: Bearer %TOKEN%"

echo.
echo.

echo Step 5: Check existing vocabularies...
curl -X GET "http://localhost:8080/api/v1/vocabulary?page=0&size=3" ^
  -H "Authorization: Bearer %TOKEN%"

echo.
echo.
echo ========================================
echo Test completed!
echo ========================================

del temp_login.json
pause
