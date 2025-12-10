.PHONY: all clean scratch

all:
	make report/count_report.html

results/isles.dat: scripts/wordcount.py data/isles.txt
	python scripts/wordcount.py --input_file=data/isles.txt --output_file=results/isles.dat

results/abyss.dat: scripts/wordcount.py data/abyss.txt
	python scripts/wordcount.py --input_file=data/abyss.txt --output_file=results/abyss.dat

results/last.dat: scripts/wordcount.py data/last.txt
	python scripts/wordcount.py --input_file=data/last.txt --output_file=results/last.dat

results/sierra.dat: scripts/wordcount.py data/sierra.txt
	python scripts/wordcount.py --input_file=data/sierra.txt --output_file=results/sierra.dat


results/figure/isles.png: scripts/plotcount.py results/isles.dat
	python scripts/plotcount.py --input_file=results/isles.dat --output_file=results/figure/isles.png

results/figure/abyss.png: scripts/plotcount.py results/abyss.dat
	python scripts/plotcount.py --input_file=results/abyss.dat --output_file=results/figure/abyss.png

results/figure/last.png: scripts/plotcount.py results/last.dat
	python scripts/plotcount.py --input_file=results/last.dat --output_file=results/figure/last.png

results/figure/sierra.png: scripts/plotcount.py results/sierra.dat
	python scripts/plotcount.py --input_file=results/sierra.dat --output_file=results/figure/sierra.png


report/count_report.html: report/count_report.qmd results/figure/isles.png results/figure/abyss.png results/figure/last.png results/figure/sierra.png
	cd report && quarto render count_report.qmd --output count_report.html


clean:
	rm -f results/*.dat
	rm -f results/figure/*.png
	rm -f report/count_report.html
	rm -rf report/*_files

scratch:
	make clean
	python scripts/wordcount.py --input_file=data/isles.txt --output_file=results/isles.dat
	python scripts/wordcount.py --input_file=data/abyss.txt --output_file=results/abyss.dat
	python scripts/wordcount.py --input_file=data/last.txt --output_file=results/last.dat
	python scripts/wordcount.py --input_file=data/sierra.txt --output_file=results/sierra.dat
	python scripts/plotcount.py --input_file=results/isles.dat --output_file=results/figure/isles.png
	python scripts/plotcount.py --input_file=results/abyss.dat --output_file=results/figure/abyss.png
	python scripts/plotcount.py --input_file=results/last.dat --output_file=results/figure/last.png
	python scripts/plotcount.py --input_file=results/sierra.dat --output_file=results/figure/sierra.png
	cd report && quarto render count_report.qmd --output count_report.html
