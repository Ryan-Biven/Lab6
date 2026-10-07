#!/bin/bash

exec > output.txt

input="The five boxing wizards jump quickly"

echo "Question 1:"
# -o only prints the match, bo then greedy .* then ng so it grabs boxing
echo "$input" | grep -oE 'bo.*ng'

echo "Question 2:"
# just 7 or more letters in a row, wizards and quickly are the only ones that long
echo "$input" | grep -oE '[A-Za-z]{7,}'

echo "Question 3:"
# -o puts every run of letters on its own line, then wc -l counts lines. tr strips mac's padding
echo "$input" | grep -oE '[A-Za-z]+' | wc -l | tr -d ' '

echo "Question 4:"
# anchor to the start so only lines that begin with EMAIL show up
grep -E '^EMAIL ' Emails.txt

echo "Question 5:"
# ^ and $ so the whole line has to be exactly COUNT or NEXT or READ, nothing else
grep -E '^(COUNT|NEXT|READ)$' Emails.txt

echo "Question 6:"
# Boss with a capital B plus the comma, so BOSS in all caps doesnt sneak in
grep -E '^EMAIL Boss,' Emails.txt

echo "Question 7:"
# end of line anchor, anything that finishes with -2025
grep -E '^EMAIL .*,[0-9]{2}-[0-9]{2}-2025$' Emails.txt

echo "Question 8:"
# needs 12 as the month and 2024 at the end, day in the middle can be any 2 digits
grep -E '^EMAIL .*,12-[0-9]{2}-2024$' Emails.txt

echo "Question 9:"
# Boss then ,Important, with the comma after so the Re: ones dont match
grep -E '^EMAIL Boss,Important,' Emails.txt

echo "Question 10:"
# Boss then ,Re: right after the comma so only his replies match
grep -E '^EMAIL Boss,Re:' Emails.txt

echo "Question 11:"
# any letters then Person right before the comma, catches Important and Other
grep -E '^EMAIL [A-Za-z]*Person,' Emails.txt

echo "Question 12:"
# same email filter as q4 but wc -l just counts them
grep -E '^EMAIL ' Emails.txt | wc -l | tr -d ' '

echo "Question 13:"
# same command filter as q5 and tr swaps A-Z to a-z
grep -E '^(COUNT|NEXT|READ)$' Emails.txt | tr 'A-Z' 'a-z'

echo "Question 14:"
# grabs the Person lines first, then sed swaps Important or Other glued to Person with Others
grep -E '^EMAIL [A-Za-z]*Person,' Emails.txt | sed -E 's/(Important|Other)Person/Others/'

echo "Question 15:"
# awk splits on commas and prints the 2nd chunk, which is the subject
grep -E '^EMAIL ' Emails.txt | awk -F',' '{print $2}'