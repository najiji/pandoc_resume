all: html pdf docx rtf

pdf: resume.pdf
resume.pdf: resume.md style.tex
	pandoc --standalone --template style.tex \
	--from markdown --to context \
	-V papersize=A4 \
	-o resume.tex resume.md; \
	sed -i .bak 's/\\starttable\[|l|l|\]/\\starttable\[o0|l|l|\]/' resume.tex; \
	rm resume.tex.bak; \
	context resume.tex

html: resume.html
resume.html: style.css resume.md
	pandoc --standalone -H style.css \
        --from markdown --to html \
        -o resume.html resume.md

docx: resume.docx
resume.docx: resume.md
	pandoc -s -S resume.md -o resume.docx

rtf: resume.rtf
resume.rtf: resume.md
	pandoc -s -S resume.md -o resume.rtf

clean:
	rm resume.html
	rm resume.tex
	rm resume.tuc
	rm resume.log
	rm resume.pdf
	rm resume.docx
	rm resume.rtf
