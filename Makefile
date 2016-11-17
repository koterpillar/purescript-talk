index.html: template.html talk.md
	sed '/source/ r talk.md' < template.html > index.html

serve: index.html
	(sleep 2 && xdg-open http://localhost:8000/) &
	python -m http.server

.PHONY: serve
