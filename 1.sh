input_url=$1
output_path="/sdcard/Download/"
current_date_time=$(date +"%Y-%m-%d_%H:%M:%S")

file_name=$(basename "$input_url")
extension="${input_url##*.}"
if [ -z "$extension" ]; then
    file_name="$file_name"
fi
	file_name="$file_name.$extension"

output_file_name="${current_date_time}_${file_name%.*}.mp4"

echo $output_file_name