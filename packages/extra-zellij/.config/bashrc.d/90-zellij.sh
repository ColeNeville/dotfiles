# Auto-start zellij in new shells (not over SSH, not nested)
if [ -z "${ZELLIJ}" ] && [ -z "${SSH_CONNECTION}" ]; then
	exec zellij
fi
