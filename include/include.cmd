IF "%pw%" == "" ( SET /p pw="enter password or press enter to use agent:" )
IF NOT "%pw%" == "" (	SET pw=-pw=%pw%	)
IF "%pw%" == "" (SET pw="-pk=a")

set mydate=%date:~10,4%%date:~6,2%/%date:~4,2%