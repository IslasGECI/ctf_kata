.PHONY: \
	clean \
	submissions

clean:
	rm --force pollos_petrel/evaro_submission.csv

submissions: \
	pollos_petrel/evaro_submission.csv \
	pollos_petrel/example_submission.csv

pollos_petrel/evaro_submission.csv:
	@echo "Creating Évaro's submission file..."
	mv pollos_petrel/example2_submission.csv pollos_petrel/evaro_submission.csv

pollos_petrel/example_submission.csv:
	@echo "Creating example submission file..."
	touch pollos_petrel/example_submission.csv
