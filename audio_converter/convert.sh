#!/usr/bin/env bash 
convert_flac_to_mp3() {
	for file in *.flac; do 
		[ -e "$file" ] || continue 
		ffmpeg -i "$file" "${file%.flac}.mp3"

	done

}

convert_mp3_to_opus() {
	for file in *.mp3; do 
		[ -e "$file" ] || continue 
		ffmpeg -i "$file" "${file%.mp3}.opus"



	done       		
}

convert_opus_to_mp3() {
	for file in *.opus; do 
		[ -e "$file" ] || continue 
		ffmpeg -i "$file" "${file%.opus}.mp3"


	done
}

convert_aac_to_opus() {
	for file in *.m4a; do
		[ -e "$file" ] || continue
		ffmpeg -i "$file" "${file%.m4a}.opus"
	done

	for file in *.aac; do 
		[ -e "$file" ] || continue 
		ffmpeg -i "$file" "${file%.acc}.opus"


	done

	for file in *.m4b; do
	       [ -e "$file" ] || continue
	       ffmpeg -i "$file" "${file%.m4b}.opus"


	done

	for file in *.m4p; do 
		[ -e "$file" ] || continue 
		ffmpeg -i "$file" "${file%.m4p}.opus"


	done

	for file in *.m4r; do
		[ -e "$file" ] || continue 
		ffmpeg -i "$file" "${file%.m4r}.opus"


	done


}
convert_mp3_to_ogg() {
	for file in *.mp3; do
	       [ -e "$file" ] || continue 
	       ffmpeg -i "$file" "${file%.mp3}.ogg"


	done



}

convert_aac_to_ogg() {
	for file in *.m4a; do
		[ -e "$file" ] || continue
		ffmpeg -i "$file" "${file%.m4a}.ogg"
	done

	for file in *.aac; do 
		[ -e "$file" ] || continue 
		ffmpeg -i "$file" "${file%.acc}.ogg"


	done

	for file in *.m4b; do
	       [ -e "$file" ] || continue
	       ffmpeg -i "$file" "${file%.m4b}.ogg"


	done

	for file in *.m4p; do 
		[ -e "$file" ] || continue 
		ffmpeg -i "$file" "${file%.m4p}.ogg"


	done

	for file in *.m4r; do
		[ -e "$file" ] || continue 
		ffmpeg -i "$file" "${file%.m4r}.ogg"


	done
}

convert_flac_to_aac() {
	for file in *.flac; do 
		[ -e "$file" ] || continue 
		ffmpeg -i "$file" "${file%.flac}.m4a"

	done
}

convert_flac_to_opus() {
	for file in *.flac; do 
		[ -e "$file" ] || continue 
		ffmpeg -i "$file" "${file%.flac}.opus"

	done
}

convert_flac_to_ogg() {
	for file in *.flac; do 
		[ -e "$file" ] || continue 
		ffmpeg -i "$file" "${file%.flac}.opus"

	done
}

convert_aac_to_mp3() {
	for file in *.m4a; do
		[ -e "$file" ] || continue
		ffmpeg -i "$file" "${file%.m4a}.mp3"
	done

	for file in *.aac; do 
		[ -e "$file" ] || continue 
		ffmpeg -i "$file" "${file%.acc}.mp3"


	done

	for file in *.m4b; do
	       [ -e "$file" ] || continue
	       ffmpeg -i "$file" "${file%.m4b}.mp3"


	done

	for file in *.m4p; do 
		[ -e "$file" ] || continue 
		ffmpeg -i "$file" "${file%.m4p}.mp3"


	done

	for file in *.m4r; do
		[ -e "$file" ] || continue 
		ffmpeg -i "$file" "${file%.m4r}.mp3"


	done

}

convert_mp3_to_aac() {
	printf "m4a,acc,m4b,m4p, or m4r \n"
	read -rp "What container do you want for aac: " option 
	if [ "$option" = "m4a" ]; then 
		for file in *.m4a; do
			[ -e "$file" ] || continue
			ffmpeg -i "$file" "${file%.mp3}.m4a"
		done

	elif [ "$option" = "acc" ]; then 
		for file in *.aac; do 
			[ -e "$file" ] || continue 
			ffmpeg -i "$file" "${file%.mp3}.acc"


		done

	elif [ "$option" = "m4b" ]; then 
		for file in *.m4b; do
	       		[ -e "$file" ] || continue
	       		ffmpeg -i "$file" "${file%.mp3}.m4b"


		done

	elif [ "$option" = "m4p" ]; then	
		for file in *.m4p; do 
			[ -e "$file" ] || continue 
			ffmpeg -i "$file" "${file%.mp3}.m4p"


		done
	
	elif [ "$option" = "m4r" ]; then 
		for file in *.m4r; do
			[ -e "$file" ] || continue 
			ffmpeg -i "$file" "${file%.mp3}.m4r"


		done


	else 
		printf "Error: Container not recognized choose one above \n"
		return 1


	fi

}

# ffmpeg -i *.flac *.mp3


# for file in *.flac; do
 #      f="${file%.*}"
  #     ffmpeg -i "$file" -b:a 320k "$f.mp3"       
# done
