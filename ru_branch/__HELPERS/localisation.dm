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
		letter = "ÿ"
		chat = "&#255;"
		browser = "&#1103;"
		log = "ß"
		temp = "¶"

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
			lcase_letter = "¶"

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
		else if(letter_ascii == text2ascii("ÿ"))
			ucase_letter = "ß"

		new_text += ucase_letter
		p++

	return new_text

/proc/fix_rus_nanoui(var/input)
	input = replacetext(input, "À", "&#1040;")
	input = replacetext(input, "Á", "&#1041;")
	input = replacetext(input, "Â", "&#1042;")
	input = replacetext(input, "Ã", "&#1043;")
	input = replacetext(input, "Ä", "&#1044;")
	input = replacetext(input, "Å", "&#1045;")
	input = replacetext(input, "Æ", "&#1046;")
	input = replacetext(input, "Ç", "&#1047;")
	input = replacetext(input, "È", "&#1048;")
	input = replacetext(input, "É", "&#1049;")
	input = replacetext(input, "Ê", "&#1050;")
	input = replacetext(input, "Ë", "&#1051;")
	input = replacetext(input, "Ì", "&#1052;")
	input = replacetext(input, "Í", "&#1053;")
	input = replacetext(input, "Î", "&#1054;")
	input = replacetext(input, "Ï", "&#1055;")
	input = replacetext(input, "Ð", "&#1056;")
	input = replacetext(input, "Ñ", "&#1057;")
	input = replacetext(input, "Ò", "&#1058;")
	input = replacetext(input, "Ó", "&#1059;")
	input = replacetext(input, "Ô", "&#1060;")
	input = replacetext(input, "Õ", "&#1061;")
	input = replacetext(input, "Ö", "&#1062;")
	input = replacetext(input, "×", "&#1063;")
	input = replacetext(input, "Ø", "&#1064;")
	input = replacetext(input, "Ù", "&#1065;")
	input = replacetext(input, "Ú", "&#1066;")
	input = replacetext(input, "Û", "&#1067;")
	input = replacetext(input, "Ü", "&#1068;")
	input = replacetext(input, "Ý", "&#1069;")
	input = replacetext(input, "Þ", "&#1070;")
	input = replacetext(input, "ß", "&#1071;")
	input = replacetext(input, "à", "&#1072;")
	input = replacetext(input, "á", "&#1073;")
	input = replacetext(input, "â", "&#1074;")
	input = replacetext(input, "ã", "&#1075;")
	input = replacetext(input, "ä", "&#1076;")
	input = replacetext(input, "å", "&#1077;")
	input = replacetext(input, "æ", "&#1078;")
	input = replacetext(input, "ç", "&#1079;")
	input = replacetext(input, "è", "&#1080;")
	input = replacetext(input, "é", "&#1081;")
	input = replacetext(input, "ê", "&#1082;")
	input = replacetext(input, "ë", "&#1083;")
	input = replacetext(input, "ì", "&#1084;")
	input = replacetext(input, "í", "&#1085;")
	input = replacetext(input, "î", "&#1086;")
	input = replacetext(input, "ï", "&#1087;")
	input = replacetext(input, "ð", "&#1088;")
	input = replacetext(input, "ñ", "&#1089;")
	input = replacetext(input, "ò", "&#1090;")
	input = replacetext(input, "ó", "&#1091;")
	input = replacetext(input, "ô", "&#1092;")
	input = replacetext(input, "õ", "&#1093;")
	input = replacetext(input, "ö", "&#1094;")
	input = replacetext(input, "÷", "&#1095;")
	input = replacetext(input, "ø", "&#1096;")
	input = replacetext(input, "ù", "&#1097;")
	input = replacetext(input, "ú", "&#1098;")
	input = replacetext(input, "û", "&#1099;")
	input = replacetext(input, "ü", "&#1100;")
	input = replacetext(input, "ý", "&#1101;")
	input = replacetext(input, "þ", "&#1102;")
	input = replacetext(input, "ÿ", "&#1103;")
	input = replacetext(input, "¸", "&#1105;")
	input = replacetext(input, "¨", "&#1025;")
	return input

/proc/fix_rus_stats(var/text)
	text = replacetext(text, "À", "&#192;") // Fuck BYOND
	text = replacetext(text, "Á", "&#193;")
	text = replacetext(text, "Â", "&#194;")
	text = replacetext(text, "Ã", "&#195;")
	text = replacetext(text, "Ä", "&#196;")
	text = replacetext(text, "Å", "&#197;")
	text = replacetext(text, "Æ", "&#198;")
	text = replacetext(text, "Ç", "&#199;")
	text = replacetext(text, "È", "&#200;")
	text = replacetext(text, "É", "&#201;")
	text = replacetext(text, "Ê", "&#202;")
	text = replacetext(text, "Ë", "&#203;")
	text = replacetext(text, "Ì", "&#204;")
	text = replacetext(text, "Í", "&#205;")
	text = replacetext(text, "Î", "&#206;")
	text = replacetext(text, "Ï", "&#207;")
	text = replacetext(text, "Ð", "&#208;")
	text = replacetext(text, "Ñ", "&#209;")
	text = replacetext(text, "Ò", "&#210;")
	text = replacetext(text, "Ó", "&#211;")
	text = replacetext(text, "Ô", "&#212;")
	text = replacetext(text, "Õ", "&#213;")
	text = replacetext(text, "Ö", "&#214;")
	text = replacetext(text, "×", "&#215;")
	text = replacetext(text, "Ø", "&#216;")
	text = replacetext(text, "Ù", "&#217;")
	text = replacetext(text, "Ú", "&#218;")
	text = replacetext(text, "Û", "&#219;")
	text = replacetext(text, "Ü", "&#220;")
	text = replacetext(text, "Ý", "&#221;")
	text = replacetext(text, "Þ", "&#222;")
	text = replacetext(text, "ß", "&#223;")
	text = replacetext(text, "à", "&#224;")
	text = replacetext(text, "á", "&#225;")
	text = replacetext(text, "â", "&#226;")
	text = replacetext(text, "ã", "&#227;")
	text = replacetext(text, "ä", "&#228;")
	text = replacetext(text, "å", "&#229;")
	text = replacetext(text, "æ", "&#230;")
	text = replacetext(text, "ç", "&#231;")
	text = replacetext(text, "è", "&#232;")
	text = replacetext(text, "é", "&#233;")
	text = replacetext(text, "ê", "&#234;")
	text = replacetext(text, "ë", "&#235;")
	text = replacetext(text, "ì", "&#236;")
	text = replacetext(text, "í", "&#237;")
	text = replacetext(text, "î", "&#238;")
	text = replacetext(text, "ï", "&#239;")
	text = replacetext(text, "ð", "&#240;")
	text = replacetext(text, "ñ", "&#241;")
	text = replacetext(text, "ò", "&#242;")
	text = replacetext(text, "ó", "&#243;")
	text = replacetext(text, "ô", "&#244;")
	text = replacetext(text, "õ", "&#245;")
	text = replacetext(text, "ö", "&#246;")
	text = replacetext(text, "÷", "&#247;")
	text = replacetext(text, "ø", "&#248;")
	text = replacetext(text, "ù", "&#249;")
	text = replacetext(text, "ú", "&#250;")
	text = replacetext(text, "û", "&#251;")
	text = replacetext(text, "ü", "&#251;")
	text = replacetext(text, "ý", "&#253;")
	text = replacetext(text, "þ", "&#254;")
	text = replacetext(text, "ÿ", "&#255;")
	text = replacetext(text, "¸", "&#184;")
	text = replacetext(text, "¨", "&#168;")
	return text

/proc/replace_characters(var/t,var/list/repl_chars)
	for(var/char in repl_chars)
		t = replacetext(t, char, repl_chars[char])
	return t