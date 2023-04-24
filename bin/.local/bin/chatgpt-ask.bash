#!/bin/bash

# FROM https://kadekillary.work/posts/1000x-eng/
# model: gpt-4 is in private beta (have to get from waitlist)
# model: gpt-3.5-turbo (if you don't have access)

# function hey_gpt() {
    read -p "Enter ChatGPT query: " prompt

    echo "PROMPT = "$prompt

    curl -v \
    -H "Content-Type: application/json" \
    -H "Authorization: Bearer $OPENAI_API_KEY" \
    https://api.openai.com/v1/chat/completions \
    -d "{
        \"model\": \"gpt-3.5-turbo\",
        \"messages\": [{\"role\": \"user\", \"content\": \""$prompt"\"}],
        \"temperature\": 0.7
    }" |  jq -r '.choices[0].message.content'
# }
