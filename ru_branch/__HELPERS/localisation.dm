#define SANITIZE_CHAT 1
#define SANITIZE_BROWSER 2
#define SANITIZE_LOG 3
#define SANITIZE_TEMP 4

/*
	The most used output way is text chat. So fatal letters by default should be transformed into chat version.
	Also, it`s easier to fix all browser() calls than search all possible "[src|usr|mob|any other var] <<" calls.
	Logs need a special letter, because watch normal text with ascii code insertions is weird.
	And sometimes we need special unique temp letter for input windows whitch allows to edit text.
	Like in custom event message, admin memo and VV.
*/

/datum/letter
	var/letter = ""			//weird letter
	var/chat = ""			//chat letter
	var/browser = ""		//letter in browser windows
	var/log = ""			//letter for logs
	var/temp = ""			//temporatory letter for filled input windows
							//!!!temp must be unique for every letter!!!

	cyrillic_ya
		letter = "�"
		chat = "&#255;"
		browser = "&#1103;"
		log = "�"
		temp = "�"

proc/sanitize_local(var/text, var/mode = SANITIZE_CHAT)
	if(!istext(text))
		return text
	for(var/datum/letter/L in localisation)
		switch(mode)
			if(SANITIZE_CHAT)		//only basic input goes to chat
				text = replace_characters(text, list(L.letter=L.chat, L.temp=L.chat))

			if(SANITIZE_BROWSER)	//browser takes everything
				text = replace_characters(text, list(L.letter=L.browser, L.temp=L.browser, L.chat=L.browser))

			if(SANITIZE_LOG)		//logs can get raw or prepared text
				text = replace_characters(text, list(L.letter=L.log, L.chat=L.log))

			if(SANITIZE_TEMP)		//same for input windows
				text = replace_characters(text, list(L.letter=L.temp, L.chat=L.temp))
	return text

/*
	Both encode and decode can break special symbol codes, so we need to replace them.
	Text letters always tuning into chat mode, and browser sanitization should be before every browser() call.
	I dunno, should every call be replaced, because maybe there some calls that isn`t used with users input.
*/

/proc/lhtml_encode(var/text)
	text = sanitize_local(text, SANITIZE_TEMP)
	text = html_encode(text)
	text = sanitize_local(text)
	return text

/proc/lhtml_decode(var/text)
	text = sanitize_local(text, SANITIZE_TEMP)
	text = html_decode(text)
	text = sanitize_local(text)
	return text

//From Rubay
/proc/lowertext_alt(var/text)
	var/lenght = length(text)
	var/new_text = null
	var/lcase_letter
	var/letter_ascii

	var/p = 1
	while(p <= lenght)
		lcase_letter = copytext(text, p, p + 1)
		letter_ascii = text2ascii(lcase_letter)

		if((letter_ascii >= 65 && letter_ascii <= 90) || (letter_ascii >= 192 && letter_ascii < 223))
			lcase_letter = ascii2text(letter_ascii + 32)
		else if(letter_ascii == 223)
			lcase_letter = "�"

		new_text += lcase_letter
		p++

	return new_text

/proc/uppertext_alt(var/text)
	var/lenght = length(text)
	var/new_text = null
	var/ucase_letter
	var/letter_ascii

	var/p = 1
	while(p <= lenght)
		ucase_letter = copytext(text, p, p + 1)
		letter_ascii = text2ascii(ucase_letter)

		if((letter_ascii >= 97 && letter_ascii <= 122) || (letter_ascii >= 224 && letter_ascii < 255))
			ucase_letter = ascii2text(letter_ascii - 32)
		else if(letter_ascii == text2ascii("�"))
			ucase_letter = "�"

		new_text += ucase_letter
		p++

	return new_text

/proc/fix_rus_nanoui(var/input)
	input = replacetext(input, "�", "&#1040;")
	input = replacetext(input, "�", "&#1041;")
	input = replacetext(input, "�", "&#1042;")
	input = replacetext(input, "�", "&#1043;")
	input = replacetext(input, "�", "&#1044;")
	input = replacetext(input, "�", "&#1045;")
	input = replacetext(input, "�", "&#1046;")
	input = replacetext(input, "�", "&#1047;")
	input = replacetext(input, "�", "&#1048;")
	input = replacetext(input, "�", "&#1049;")
	input = replacetext(input, "�", "&#1050;")
	input = replacetext(input, "�", "&#1051;")
	input = replacetext(input, "�", "&#1052;")
	input = replacetext(input, "�", "&#1053;")
	input = replacetext(input, "�", "&#1054;")
	input = replacetext(input, "�", "&#1055;")
	input = replacetext(input, "�", "&#1056;")
	input = replacetext(input, "�", "&#1057;")
	input = replacetext(input, "�", "&#1058;")
	input = replacetext(input, "�", "&#1059;")
	input = replacetext(input, "�", "&#1060;")
	input = replacetext(input, "�", "&#1061;")
	input = replacetext(input, "�", "&#1062;")
	input = replacetext(input, "�", "&#1063;")
	input = replacetext(input, "�", "&#1064;")
	input = replacetext(input, "�", "&#1065;")
	input = replacetext(input, "�", "&#1066;")
	input = replacetext(input, "�", "&#1067;")
	input = replacetext(input, "�", "&#1068;")
	input = replacetext(input, "�", "&#1069;")
	input = replacetext(input, "�", "&#1070;")
	input = replacetext(input, "�", "&#1071;")
	input = replacetext(input, "�", "&#1072;")
	input = replacetext(input, "�", "&#1073;")
	input = replacetext(input, "�", "&#1074;")
	input = replacetext(input, "�", "&#1075;")
	input = replacetext(input, "�", "&#1076;")
	input = replacetext(input, "�", "&#1077;")
	input = replacetext(input, "�", "&#1078;")
	input = replacetext(input, "�", "&#1079;")
	input = replacetext(input, "�", "&#1080;")
	input = replacetext(input, "�", "&#1081;")
	input = replacetext(input, "�", "&#1082;")
	input = replacetext(input, "�", "&#1083;")
	input = replacetext(input, "�", "&#1084;")
	input = replacetext(input, "�", "&#1085;")
	input = replacetext(input, "�", "&#1086;")
	input = replacetext(input, "�", "&#1087;")
	input = replacetext(input, "�", "&#1088;")
	input = replacetext(input, "�", "&#1089;")
	input = replacetext(input, "�", "&#1090;")
	input = replacetext(input, "�", "&#1091;")
	input = replacetext(input, "�", "&#1092;")
	input = replacetext(input, "�", "&#1093;")
	input = replacetext(input, "�", "&#1094;")
	input = replacetext(input, "�", "&#1095;")
	input = replacetext(input, "�", "&#1096;")
	input = replacetext(input, "�", "&#1097;")
	input = replacetext(input, "�", "&#1098;")
	input = replacetext(input, "�", "&#1099;")
	input = replacetext(input, "�", "&#1100;")
	input = replacetext(input, "�", "&#1101;")
	input = replacetext(input, "�", "&#1102;")
	input = replacetext(input, "�", "&#1103;")
	input = replacetext(input, "�", "&#1105;")
	input = replacetext(input, "�", "&#1025;")
	return input

/proc/fix_rus_stats(var/text)
	text = replacetext(text, "�", "&#192;") // Fuck BYOND
	text = replacetext(text, "�", "&#193;")
	text = replacetext(text, "�", "&#194;")
	text = replacetext(text, "�", "&#195;")
	text = replacetext(text, "�", "&#196;")
	text = replacetext(text, "�", "&#197;")
	text = replacetext(text, "�", "&#198;")
	text = replacetext(text, "�", "&#199;")
	text = replacetext(text, "�", "&#200;")
	text = replacetext(text, "�", "&#201;")
	text = replacetext(text, "�", "&#202;")
	text = replacetext(text, "�", "&#203;")
	text = replacetext(text, "�", "&#204;")
	text = replacetext(text, "�", "&#205;")
	text = replacetext(text, "�", "&#206;")
	text = replacetext(text, "�", "&#207;")
	text = replacetext(text, "�", "&#208;")
	text = replacetext(text, "�", "&#209;")
	text = replacetext(text, "�", "&#210;")
	text = replacetext(text, "�", "&#211;")
	text = replacetext(text, "�", "&#212;")
	text = replacetext(text, "�", "&#213;")
	text = replacetext(text, "�", "&#214;")
	text = replacetext(text, "�", "&#215;")
	text = replacetext(text, "�", "&#216;")
	text = replacetext(text, "�", "&#217;")
	text = replacetext(text, "�", "&#218;")
	text = replacetext(text, "�", "&#219;")
	text = replacetext(text, "�", "&#220;")
	text = replacetext(text, "�", "&#221;")
	text = replacetext(text, "�", "&#222;")
	text = replacetext(text, "�", "&#223;")
	text = replacetext(text, "�", "&#224;")
	text = replacetext(text, "�", "&#225;")
	text = replacetext(text, "�", "&#226;")
	text = replacetext(text, "�", "&#227;")
	text = replacetext(text, "�", "&#228;")
	text = replacetext(text, "�", "&#229;")
	text = replacetext(text, "�", "&#230;")
	text = replacetext(text, "�", "&#231;")
	text = replacetext(text, "�", "&#232;")
	text = replacetext(text, "�", "&#233;")
	text = replacetext(text, "�", "&#234;")
	text = replacetext(text, "�", "&#235;")
	text = replacetext(text, "�", "&#236;")
	text = replacetext(text, "�", "&#237;")
	text = replacetext(text, "�", "&#238;")
	text = replacetext(text, "�", "&#239;")
	text = replacetext(text, "�", "&#240;")
	text = replacetext(text, "�", "&#241;")
	text = replacetext(text, "�", "&#242;")
	text = replacetext(text, "�", "&#243;")
	text = replacetext(text, "�", "&#244;")
	text = replacetext(text, "�", "&#245;")
	text = replacetext(text, "�", "&#246;")
	text = replacetext(text, "�", "&#247;")
	text = replacetext(text, "�", "&#248;")
	text = replacetext(text, "�", "&#249;")
	text = replacetext(text, "�", "&#250;")
	text = replacetext(text, "�", "&#251;")
	text = replacetext(text, "�", "&#251;")
	text = replacetext(text, "�", "&#253;")
	text = replacetext(text, "�", "&#254;")
	text = replacetext(text, "�", "&#255;")
	text = replacetext(text, "�", "&#184;")
	text = replacetext(text, "�", "&#168;")
	return text

/proc/replace_characters(var/t,var/list/repl_chars)
	for(var/char in repl_chars)
		t = replacetext(t, char, repl_chars[char])
	return t