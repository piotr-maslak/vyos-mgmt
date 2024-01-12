@echo off

if exist config.cmd (
    call config.cmd
) else (
    call ..\config.cmd
)

if exist include (
    call include\include.cmd
) else (
    call ..\include\config.cmd
)

nmap -sS -sU -T4 -A -v %host%