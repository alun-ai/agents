#!/bin/bash

# Claude Code Agents Collection - Automated Setup Script
# ========================================================
# This script automates the installation and configuration of the Claude Code Agents collection
# Run with: bash setup.sh

set -e  # Exit on error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Functions for colored output
print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[✓]${NC} $1"
}

print_error() {
    echo -e "${RED}[✗]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[!]${NC} $1"
}

print_header() {
    echo ""
    echo "========================================="
    echo "$1"
    echo "========================================="
    echo ""
}

# Check prerequisites
check_prerequisites() {
    print_header "Checking Prerequisites"
    
    # Check if macOS
    if [[ "$OSTYPE" != "darwin"* ]]; then
        print_error "This script is designed for macOS. Please adapt for your OS."
        exit 1
    fi
    
    # Check if Homebrew is installed
    if ! command -v brew &> /dev/null; then
        print_error "Homebrew is not installed. Please install it first:"
        echo "  /bin/bash -c \"\$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)\""
        exit 1
    fi
    print_success "Homebrew is installed"
    
    # Check if git is installed
    if ! command -v git &> /dev/null; then
        print_error "Git is not installed. Installing..."
        brew install git
    fi
    print_success "Git is installed"
    
    # Check if Claude Code directory exists
    if [ ! -d "$HOME/.claude" ]; then
        print_status "Creating ~/.claude directory..."
        mkdir -p "$HOME/.claude"
    fi
    print_success "Claude directory exists"
}

# Clone the agents repository
clone_repository() {
    print_header "Setting Up Agents Repository"
    
    AGENTS_DIR="$HOME/.claude/agents"
    
    if [ -d "$AGENTS_DIR" ]; then
        print_warning "Agents directory already exists at $AGENTS_DIR"
        read -p "Do you want to update it? (y/n): " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            print_status "Updating agents repository..."
            cd "$AGENTS_DIR"
            git pull origin main
            print_success "Repository updated"
        else
            print_status "Keeping existing repository"
        fi
    else
        print_status "Cloning agents repository..."
        cd "$HOME/.claude"
        git clone https://github.com/alun-ai/agents.git
        print_success "Repository cloned to $AGENTS_DIR"
    fi
}

# Install required CLI tools
install_cli_tools() {
    print_header "Installing Required CLI Tools"
    
    # Install GitHub CLI
    if ! command -v gh &> /dev/null; then
        print_status "Installing GitHub CLI..."
        brew install gh
        print_success "GitHub CLI installed"
    else
        print_success "GitHub CLI already installed"
    fi
    
    # Install Jira CLI
    if ! command -v jira &> /dev/null; then
        print_status "Installing Jira CLI..."
        brew install jira-cli
        print_success "Jira CLI installed"
    else
        print_success "Jira CLI already installed"
    fi
}

# Setup GitHub CLI
setup_github_cli() {
    print_header "Setting Up GitHub CLI"
    
    # Check if already authenticated
    if gh auth status &> /dev/null; then
        print_success "GitHub CLI already authenticated"
    else
        print_status "GitHub CLI needs authentication"
        print_warning "Please follow the prompts to authenticate:"
        gh auth login
    fi
}

# Setup Jira CLI (optional)
setup_jira_cli() {
    print_header "Setting Up Jira CLI (Optional)"
    
    read -p "Do you want to configure Jira CLI? (y/n): " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        print_status "Configuring Jira CLI..."
        print_warning "You'll need:"
        echo "  - Your Jira instance URL (e.g., https://yourcompany.atlassian.net/)"
        echo "  - Your email address"
        echo "  - An API token from https://id.atlassian.com/manage-profile/security/api-tokens"
        echo ""
        jira init
        print_success "Jira CLI configured"
    else
        print_status "Skipping Jira CLI configuration"
    fi
}

# Setup MCP configuration for current project
setup_mcp_config() {
    print_header "Setting Up MCP Configuration"
    
    if [ -f ".mcp.json" ]; then
        print_warning ".mcp.json already exists in current directory"
        read -p "Do you want to replace it? (y/n): " -n 1 -r
        echo
        if [[ ! $REPLY =~ ^[Yy]$ ]]; then
            print_status "Keeping existing .mcp.json"
            return
        fi
    fi
    
    print_status "Copying .mcp.json.example to current directory..."
    cp "$HOME/.claude/agents/.mcp.json.example" .mcp.json
    print_success "MCP configuration copied to .mcp.json"
    
    # Check if .gitignore exists and add .mcp.json if not already there
    if [ -f ".gitignore" ]; then
        if ! grep -q "^\.mcp\.json$" .gitignore; then
            echo ".mcp.json" >> .gitignore
            print_success "Added .mcp.json to .gitignore"
        else
            print_success ".mcp.json already in .gitignore"
        fi
    else
        echo ".mcp.json" > .gitignore
        print_success "Created .gitignore with .mcp.json"
    fi
}

# Configure environment variables
setup_environment() {
    print_header "Setting Up Environment Variables (Optional)"
    
    # Determine shell config file
    if [ -n "$ZSH_VERSION" ]; then
        SHELL_CONFIG="$HOME/.zshrc"
    elif [ -n "$BASH_VERSION" ]; then
        SHELL_CONFIG="$HOME/.bashrc"
    else
        SHELL_CONFIG="$HOME/.profile"
    fi
    
    read -p "Do you want to configure environment variables? (y/n): " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        
        # GitHub Token
        if [ -z "$GITHUB_TOKEN" ]; then
            print_status "Setting up GitHub Personal Access Token..."
            echo "Create a token at: https://github.com/settings/tokens"
            read -p "Enter your GitHub Personal Access Token: " github_token
            echo "export GITHUB_TOKEN=\"$github_token\"" >> "$SHELL_CONFIG"
            export GITHUB_TOKEN="$github_token"
            print_success "GitHub token configured"
        else
            print_success "GitHub token already configured"
        fi
        
        # Jira configuration
        read -p "Do you want to configure Jira environment variables? (y/n): " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            if [ -z "$JIRA_API_TOKEN" ]; then
                read -p "Enter your Jira API Token: " jira_token
                echo "export JIRA_API_TOKEN=\"$jira_token\"" >> "$SHELL_CONFIG"
                export JIRA_API_TOKEN="$jira_token"
            fi
            
            if [ -z "$JIRA_URL" ]; then
                read -p "Enter your Jira URL (e.g., https://company.atlassian.net/): " jira_url
                echo "export JIRA_URL=\"$jira_url\"" >> "$SHELL_CONFIG"
                export JIRA_URL="$jira_url"
            fi
            
            if [ -z "$JIRA_EMAIL" ]; then
                read -p "Enter your Jira email: " jira_email
                echo "export JIRA_EMAIL=\"$jira_email\"" >> "$SHELL_CONFIG"
                export JIRA_EMAIL="$jira_email"
            fi
            
            print_success "Jira environment variables configured"
        fi
        
        print_status "Sourcing $SHELL_CONFIG..."
        source "$SHELL_CONFIG"
    else
        print_status "Skipping environment variable configuration"
    fi
}

# Verify installation
verify_installation() {
    print_header "Verifying Installation"
    
    ERRORS=0
    
    # Check agents directory
    if [ -d "$HOME/.claude/agents" ]; then
        print_success "Agents repository exists"
    else
        print_error "Agents repository not found"
        ((ERRORS++))
    fi
    
    # Check .mcp.json.example
    if [ -f "$HOME/.claude/agents/.mcp.json.example" ]; then
        print_success "MCP example configuration exists"
    else
        print_error "MCP example configuration not found"
        ((ERRORS++))
    fi
    
    # Check GitHub CLI
    if gh auth status &> /dev/null; then
        print_success "GitHub CLI authenticated"
    else
        print_warning "GitHub CLI not authenticated (optional)"
    fi
    
    # Check Jira CLI
    if command -v jira &> /dev/null; then
        print_success "Jira CLI installed"
        if jira list --query "project = TEST" --max-results 1 &> /dev/null; then
            print_success "Jira CLI configured"
        else
            print_warning "Jira CLI not configured (optional)"
        fi
    else
        print_warning "Jira CLI not installed (optional)"
    fi
    
    if [ $ERRORS -eq 0 ]; then
        print_header "✨ Installation Complete!"
        echo "Next steps:"
        echo "1. Restart Claude Code to load MCP servers"
        echo "2. Copy .mcp.json to your project directory when needed"
        echo "3. Use @agent-name to invoke specialized agents"
        echo "4. Refer to README.md for workflow patterns"
        echo ""
        print_success "Setup completed successfully!"
    else
        print_error "Setup completed with errors. Please review the output above."
        exit 1
    fi
}

# Main execution
main() {
    clear
    echo "======================================================"
    echo "    Claude Code Agents Collection Setup Script"
    echo "======================================================"
    echo ""
    
    check_prerequisites
    clone_repository
    install_cli_tools
    setup_github_cli
    setup_jira_cli
    
    # Ask about project setup
    read -p "Do you want to set up MCP configuration for the current directory? (y/n): " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        setup_mcp_config
    fi
    
    setup_environment
    verify_installation
}

# Run main function
main