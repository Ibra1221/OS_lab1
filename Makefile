
OUTPUT_DIR := malicious_dir/
INPUT_DIR := my_dir/
INTERVAL := 3

.PHONY: antivirus restore

antivirus: $(OUTPUT_DIR)
	@./antivirusd.sh "$(INPUT_DIR)" "$(OUTPUT_DIR)" "$(INTERVAL)"

restore: $(OUTPUT_DIR)
	@./restore.sh "$(INPUT_DIR)" "$(OUTPUT_DIR)"

$(OUTPUT_DIR):
	mkdir -p "$(OUTPUT_DIR)"
