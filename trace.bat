@echo off

if exist config.cmd (
    call config.cmd
) else (
    call ..\config.cmd
)

tracert %host%