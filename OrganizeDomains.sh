#!/bin/bash
# EX -> OrganizeDomains.sh hosts.txt

if [ -z "$1" ]; then
  echo "Error: no file specified."
  exit 1
fi

if [ ! -f "$1" ]; then
  echo "Error: file does not exist."
  exit 1
fi

first_level_domains=()
second_level_domains=()
third_level_domains=()

while IFS= read -r line; do
  domain=$(echo "$line" | grep -oE "(https?://)?([a-z0-9.-]+\.)+[a-z]{2,}" | sed "s/https\?:\/\///")

  IFS='.' read -ra parts <<< "$domain"

  case ${#parts[@]} in
    2)
      first_level_domains+=("$domain")
      ;;
    3)
      second_level_domains+=("$domain")
      ;;
    4)
      third_level_domains+=("$domain")
      ;;
  esac
done < "$1"

echo "First-level domains:"
printf '%s\n' "${first_level_domains[@]}" >> first-level.txt
echo
echo "Second-level domains:"
printf '%s\n' "${second_level_domains[@]}" >> second-level.txt
echo
echo "Third-level domains:"
printf '%s\n' "${third_level_domains[@]}" >> third-level.txt
