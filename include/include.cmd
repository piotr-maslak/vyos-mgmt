IF "%pw%" == "" ( SET /p pw="enter password or press enter to use agent:" )
set scrpath="include\get-scripts\%version%"
set mydate=%date:~10,4%%date:~6,2%/%date:~4,2%