#!/bin/bash
    
mkdir -p ~/.npm-global
npm config set prefix ~/project/.npm-global
source ~/.bashrc
npm install -g @anthropic-ai/claude-code
npm install -g opencode-ai
