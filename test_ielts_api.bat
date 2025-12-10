@echo off
echo ========================================
echo IELTS Test API - Testing Script
echo ========================================
echo.

REM Set your access token here (get from login)
set TOKEN=YOUR_ACCESS_TOKEN_HERE

REM Base URL
set BASE_URL=http://localhost:8080/api/v1/ielts

echo Please login first and update TOKEN variable in this script!
echo.
pause

echo.
echo ========================================
echo 1. GENERATE IELTS TEST
echo ========================================
echo Request: POST %BASE_URL%/generate
curl -X POST "%BASE_URL%/generate" ^
  -H "Authorization: Bearer %TOKEN%" ^
  -H "Content-Type: application/json" ^
  -d "{\"skill\":\"Reading\",\"level\":\"General\",\"difficulty\":\"Easy\"}"
echo.
echo.
pause

echo.
echo ========================================
echo 2. GET TEST BY ID
echo ========================================
set /p TEST_ID="Enter test ID from previous response: "
echo Request: GET %BASE_URL%/tests/%TEST_ID%
curl -X GET "%BASE_URL%/tests/%TEST_ID%" ^
  -H "Authorization: Bearer %TOKEN%"
echo.
echo.
pause

echo.
echo ========================================
echo 3. START TEST SESSION
echo ========================================
echo Request: POST %BASE_URL%/start
curl -X POST "%BASE_URL%/start" ^
  -H "Authorization: Bearer %TOKEN%" ^
  -H "Content-Type: application/json" ^
  -d "{\"testId\":%TEST_ID%}"
echo.
echo.
echo Save the historyId from the response!
pause

echo.
echo ========================================
echo 4. SUBMIT TEST
echo ========================================
set /p HISTORY_ID="Enter history ID from previous response: "
echo Request: POST %BASE_URL%/submit
echo NOTE: Update question IDs and answer IDs based on your test!
curl -X POST "%BASE_URL%/submit" ^
  -H "Authorization: Bearer %TOKEN%" ^
  -H "Content-Type: application/json" ^
  -d "{\"historyId\":%HISTORY_ID%,\"timeSpentSeconds\":1800,\"answers\":[{\"questionId\":1,\"selectedAnswerId\":1},{\"questionId\":2,\"selectedAnswerId\":5}]}"
echo.
echo.
pause

echo.
echo ========================================
echo 5. GET TEST HISTORY
echo ========================================
echo Request: GET %BASE_URL%/history
curl -X GET "%BASE_URL%/history" ^
  -H "Authorization: Bearer %TOKEN%"
echo.
echo.
pause

echo.
echo ========================================
echo Testing Complete!
echo ========================================
echo.
echo Summary of endpoints tested:
echo 1. POST /api/v1/ielts/generate - Generate test with AI
echo 2. GET  /api/v1/ielts/tests/{id} - Get test details
echo 3. POST /api/v1/ielts/start - Start test session
echo 4. POST /api/v1/ielts/submit - Submit answers
echo 5. GET  /api/v1/ielts/history - Get user history
echo.
echo Check IELTS_API_DOCUMENTATION.md for detailed API docs
echo.
pause
