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
	src/evaro/get_submission.sh > $@

pollos_petrel/example_submission.csv:
	@echo "Creating example submission file..."
	touch pollos_petrel/example_submission.csv
